import 'dart:typed_data';

import 'package:tflite_flutter/tflite_flutter.dart';

import '../models/patient_record.dart';
import '../utils/constants.dart';

/// Service that loads the TFLite model and runs inference.
class InferenceService {
  static const String _modelAsset = 'assets/models/maternal_triage_model.tflite';

  Interpreter? _interpreter;

  /// Loads the TFLite model from assets.  Call once during app startup.
  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset(_modelAsset);
  }

  void dispose() {
    _interpreter?.close();
  }

  /// Runs inference on a [PatientRecord] and returns the predicted risk class
  /// and class probabilities.
  ///
  /// Returns a map with keys: `riskClass` (int) and `probabilities` (List<double>).
  Map<String, dynamic> predict(PatientRecord record) {
    if (_interpreter == null) {
      throw StateError('Model not loaded. Call loadModel() first.');
    }

    final input = _buildInputTensor(record);
    // Output shape: [1, 3] — probabilities for low/mid/high
    final output = List.filled(3, 0.0).reshape([1, 3]);
    _interpreter!.run(input, output);

    final probs = List<double>.from(output[0] as List);
    int riskClass = 0;
    double maxProb = probs[0];
    for (int i = 1; i < probs.length; i++) {
      if (probs[i] > maxProb) {
        maxProb = probs[i];
        riskClass = i;
      }
    }
    return {'riskClass': riskClass, 'probabilities': probs};
  }

  /// Builds a normalised [Float32List] input tensor from [record].
  Float32List _buildInputTensor(PatientRecord record) {
    final raw = <double>[
      record.age,
      record.systolicBP,
      record.diastolicBP,
      record.bloodSugar,
      record.bodyTemp,
      record.heartRate,
      record.weight ?? 0.0,
      record.height ?? 0.0,
      record.previousComplications ? 1.0 : 0.0,
      record.preexistingDiabetes ? 1.0 : 0.0,
      record.gestationalDiabetes ? 1.0 : 0.0,
      _encodeMentalHealth(record.mentalHealthStatus),
      // PulsePressure derived feature
      record.systolicBP - record.diastolicBP,
    ];

    final normalised = Float32List(raw.length);
    for (int i = 0; i < raw.length; i++) {
      final min = FeatureNorm.min[i];
      final max = FeatureNorm.max[i];
      final scale = max - min == 0 ? 1.0 : max - min;
      normalised[i] = ((raw[i] - min) / scale).clamp(0.0, 1.0);
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
