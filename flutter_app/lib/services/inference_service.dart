import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:onnxruntime/onnxruntime.dart';

import '../models/patient_record.dart';
import '../utils/constants.dart';

/// Service that loads the ONNX model and runs inference.
class InferenceService {
  OrtSession? _session;
  List<double> _minVals = List.filled(14, 0.0);
  List<double> _maxVals = List.filled(14, 1.0);

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

    final input = _buildInputTensor(record);
    final inputOrt = OrtValueTensor.createTensorWithDataList(input, [1, 14]);
    final runOptions = OrtRunOptions();
    final outputs = _session!.run(runOptions, {'float_input': inputOrt});

    inputOrt.release();
    runOptions.release();

    // outputs[0] = predicted label (int64 scalar or [1])
    // outputs[1] = probability map or float array [1, 3]
    final labelVal = outputs[0]?.value;
    int riskClass = 0;
    if (labelVal is List) {
      riskClass = (labelVal[0] as num).toInt();
    } else if (labelVal is int) {
      riskClass = labelVal;
    }

    final probaVal = outputs[1]?.value;
    List<double> probs = [0.0, 0.0, 0.0];
    if (probaVal is List) {
      final flat = (probaVal.first is List) ? (probaVal[0] as List) : probaVal;
      probs = flat.map<double>((v) => (v as num).toDouble()).toList();
    }

    for (final o in outputs) {
      o?.release();
    }

    return {'riskClass': riskClass, 'probabilities': probs};
  }

  /// Builds a normalised [Float32List] input tensor from [record].
  Float32List _buildInputTensor(PatientRecord record) {
    final w = record.weight ?? 0.0;
    final h = record.height ?? 0.0;
    final heightInMeters = h / 100;
    final bmi = (w > 0 && h > 0) ? w / (heightInMeters * heightInMeters) : 0.0;

    final raw = <double>[
      record.age,
      record.systolicBP,
      record.diastolicBP,
      record.bloodSugar,
      record.bodyTemp,
      bmi,
      record.heartRate,
      w,
      h,
      record.previousComplications ? 1.0 : 0.0,
      record.preexistingDiabetes ? 1.0 : 0.0,
      record.gestationalDiabetes ? 1.0 : 0.0,
      _encodeMentalHealth(record.mentalHealthStatus),
      record.systolicBP - record.diastolicBP, // PulsePressure
    ];

    final normalised = Float32List(14);
    for (int i = 0; i < 14; i++) {
      final scale = _maxVals[i] - _minVals[i];
      normalised[i] = scale == 0
          ? 0.0
          : ((raw[i] - _minVals[i]) / scale).clamp(0.0, 1.0);
    }
    return normalised;
  }

  double _encodeMentalHealth(String status) {
    switch (status.toLowerCase()) {
      case 'mild':
        return 1.0;
      case 'moderate':
        return 2.0;
      case 'severe':
        return 3.0;
      default:
        return 0.0;
    }
  }
}
