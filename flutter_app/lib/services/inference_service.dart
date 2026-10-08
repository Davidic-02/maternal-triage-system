import 'dart:convert';
import 'dart:typed_data';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:onnxruntime/onnxruntime.dart';

import '../models/patient_record.dart';
import '../utils/constants.dart';

/// Service that loads the ONNX model and runs inference.
class InferenceService {
  // The model uses 19 engineered features (see buildInputTensor and the
  // ml_pipeline feature_engineering order). Binary model: 2 output classes.
  static const int _kNumFeatures = 19;

  OrtSession? _session;
  List<double> _minVals = List.filled(_kNumFeatures, 0.0);
  List<double> _maxVals = List.filled(_kNumFeatures, 1.0);

  // Youden-optimal decision threshold for the binary model. Predict the
  // positive (high-risk) class when P(high) >= threshold instead of 0.5.
  // Loaded from assets; falls back to 0.5 if unavailable.
  double _threshold = 0.5;
  int _positiveClass = 2;
  int _negativeClass = 0;

  // Training-set medians for optional inputs (pipeline imputation rule).
  double _medianWeight = 73.0;
  double _medianHeightM = 1.66;
  double _medianBmi = 23.0;

  double get decisionThreshold => _threshold;

  /// Loads the ONNX model and scaler params from assets.
  /// Call once during app startup.
  Future<void> loadModel() async {
    OrtEnv.instance.init();

    // Load scaler params for normalisation
    final scalerJson = await rootBundle.loadString(kScalerAsset);
    final scalerMap = jsonDecode(scalerJson) as Map<String, dynamic>;
    _minVals = List<double>.from(
      (scalerMap['min'] as List).map((v) => (v as num).toDouble()),
    );
    _maxVals = List<double>.from(
      (scalerMap['max'] as List).map((v) => (v as num).toDouble()),
    );

    // Load the Youden decision threshold (binary model). Optional — if the
    // asset is missing we keep the 0.5 default.
    try {
      final thrJson = await rootBundle.loadString(kThresholdAsset);
      final thrMap = jsonDecode(thrJson) as Map<String, dynamic>;
      _threshold = (thrMap['threshold'] as num).toDouble();
      _positiveClass = (thrMap['positive_class'] as num?)?.toInt() ?? 2;
      _negativeClass = (thrMap['negative_class'] as num?)?.toInt() ?? 0;
    } catch (_) {
      // No threshold asset — fall back to the model's argmax via 0.5.
    }

    final medians =
        jsonDecode(await rootBundle.loadString(kMediansAsset)) as Map<String, dynamic>;
    _medianWeight = (medians['Weight'] as num).toDouble();
    _medianHeightM = (medians['Height'] as num).toDouble();
    _medianBmi = (medians['BMI'] as num).toDouble();

    // Load ONNX model from assets
    final modelBytes = await rootBundle.load(kModelAsset);
    final bytes = modelBytes.buffer.asUint8List();
    final sessionOptions = OrtSessionOptions();
    _session = OrtSession.fromBuffer(bytes, sessionOptions);
  }

  void dispose() {
    _session?.release();
    OrtEnv.instance.release();
  }

  /// Runs inference on a [PatientRecord] and returns the predicted risk class
  /// and class probabilities.
  ///
  /// Returns a map with keys: `riskClass` (int) and `probabilities` (List<double>).
  Map<String, dynamic> predict(PatientRecord record) {
    if (_session == null) {
      throw StateError('Model not loaded. Call loadModel() first.');
    }

    final input = buildInputTensor(record);
    final inputOrt = OrtValueTensor.createTensorWithDataList(input, [1, _kNumFeatures]);
    final runOptions = OrtRunOptions();

    try {
      log("🧠 INPUT SHAPE: [1, $_kNumFeatures]");
      log("🧠 INPUT DATA: ${input.toList()}");

      final outputs = _session!.run(runOptions, {'float_input': inputOrt});

      log("✅ RAW OUTPUTS: $outputs");

      // ✅ Parse outputs
      final labelVal = outputs[0]?.value;
      int riskClass = 0;

      if (labelVal is List) {
        riskClass = (labelVal[0] as num).toInt();
      } else if (labelVal is int) {
        riskClass = labelVal;
      }

      final probaVal = outputs[1]?.value;
      // Binary model → 2 probabilities: [P(low), P(high)].
      List<double> probs = [0.0, 0.0];

      if (probaVal is List) {
        final flat = (probaVal.first is List)
            ? (probaVal[0] as List)
            : probaVal;

        probs = flat.map<double>((v) => (v as num).toDouble()).toList();
      }

      // ✅ Release outputs
      for (final o in outputs) {
        o?.release();
      }

      // Apply the Youden-optimal threshold for the binary model: assign the
      // high-risk class when P(high) >= threshold, else low. This overrides
      // the model's default argmax label and matches the evaluated 95.17%.
      if (probs.length == 2) {
        riskClass =
            probs[1] >= _threshold ? _positiveClass : _negativeClass;
      }

      return {'riskClass': riskClass, 'probabilities': probs};
    } catch (e, stackTrace) {
      log("❌ ONNX ERROR: $e");
      log("📍 STACK TRACE: $stackTrace");

      rethrow;
    } finally {
      // ✅ ALWAYS runs (success or failure)
      inputOrt.release();
      runOptions.release();
    }
  }

  /// Returns P(high risk) for each of [n] normalised rows packed in [rows].
  /// Used to compute per-patient Shapley explanations in one batched call.
  List<double> predictHighRiskBatch(Float32List rows, int n) {
    if (_session == null) {
      throw StateError('Model not loaded. Call loadModel() first.');
    }
    final input = OrtValueTensor.createTensorWithDataList(rows, [n, _kNumFeatures]);
    final runOptions = OrtRunOptions();
    try {
      final outputs = _session!.run(runOptions, {'float_input': input});
      final proba = outputs[1]?.value as List;
      final result = [
        for (final row in proba) ((row as List)[1] as num).toDouble(),
      ];
      for (final o in outputs) {
        o?.release();
      }
      return result;
    } finally {
      input.release();
      runOptions.release();
    }
  }

  /// Builds a normalised [Float32List] input tensor from [record].
  Float32List buildInputTensor(PatientRecord record) {
    // Missing weight/height are imputed with training medians, matching the
    // pipeline; BMI is only computed when both were actually measured.
    final w = record.weight ?? _medianWeight;
    final heightInMeters = record.height != null ? record.height! / 100 : _medianHeightM;
    final bmi = (record.weight != null && record.height != null)
        ? w / (heightInMeters * heightInMeters)
        : _medianBmi;

    // Derived clinical features — MUST match ml_pipeline feature order
    // (feature_engineering.compute_clinical_features).
    final pulsePressure = record.systolicBP - record.diastolicBP;
    final shockIndex = record.systolicBP != 0
        ? record.heartRate / record.systolicBP
        : 0.0;
    final map = record.diastolicBP + pulsePressure / 3;
    final hypertensionFlag =
        (record.systolicBP >= 130 || record.diastolicBP >= 85) ? 1.0 : 0.0;
    final tachycardiaFlag = record.heartRate >= 100 ? 1.0 : 0.0;
    final preexisting = record.preexistingDiabetes ? 1.0 : 0.0;
    final gestational = record.gestationalDiabetes ? 1.0 : 0.0;
    final diabetesRisk = record.bloodSugar * (1 + preexisting + gestational);
    final ageRiskFlag = (record.age < 18 || record.age > 35) ? 1.0 : 0.0;

    final raw = <double>[
      record.age, //                              0  Age
      record.systolicBP, //                       1  SystolicBP
      record.diastolicBP, //                      2  DiastolicBP
      record.bloodSugar, //                       3  BloodSugar
      record.bodyTemp, //                         4  BodyTemp
      bmi, //                                     5  BMI
      record.heartRate, //                        6  HeartRate
      w, //                                       7  Weight
      heightInMeters, //                          8  Height
      record.previousComplications ? 1.0 : 0.0, //9  PreviousComplications
      preexisting, //                            10  PreexistingDiabetes
      gestational, //                            11  GestationalDiabetes
      pulsePressure, //                          12  PulsePressure
      shockIndex, //                             13  ShockIndex
      map, //                                    14  MAP
      hypertensionFlag, //                       15  HypertensionFlag
      tachycardiaFlag, //                        16  TachycardiaFlag
      diabetesRisk, //                           17  DiabetesRisk
      ageRiskFlag, //                            18  AgeRiskFlag
    ];

    final normalised = Float32List(_kNumFeatures);
    for (int i = 0; i < _kNumFeatures; i++) {
      final scale = _maxVals[i] - _minVals[i];
      normalised[i] = scale == 0
          ? 0.0
          : ((raw[i] - _minVals[i]) / scale).clamp(0.0, 1.0);
    }
    return normalised;
  }
}
