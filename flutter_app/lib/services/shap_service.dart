import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/risk_result.dart';

/// Service that loads pre-computed SHAP values and provides local explanations.
class ShapService {
  static const String _shapAsset = 'assets/shap/shap_values.json';

  List<String> _featureNames = [];

  /// shap_values[classIndex][sampleIndex][featureIndex]
  List<List<List<double>>> _shapValues = [];

  bool get isLoaded => _shapValues.isNotEmpty;

  /// Loads the SHAP JSON file from assets.  Call once during app startup.
  Future<void> loadShapValues() async {
    final raw = await rootBundle.loadString(_shapAsset);
    final json = jsonDecode(raw) as Map<String, dynamic>;

    _featureNames = List<String>.from(json['feature_names'] as List);

    final rawValues = json['shap_values'] as List;
    _shapValues = rawValues
        .map((cls) => (cls as List)
            .map((sample) => (sample as List).map((v) => (v as num).toDouble()).toList())
            .toList())
        .toList();
  }

  /// Returns the top 5 SHAP feature contributions for sample at [index].
  ///
  /// Uses the class corresponding to [predictedClass] to select which
  /// SHAP values to return.
  List<ShapFeature> getLocalExplanation({
    required int index,
    required int predictedClass,
    int topN = 5,
  }) {
    if (!isLoaded) {
      throw StateError('SHAP values not loaded. Call loadShapValues() first.');
    }

    final classIdx = predictedClass.clamp(0, _shapValues.length - 1);
    final sampleIdx = index.clamp(0, _shapValues[classIdx].length - 1);
    final values = _shapValues[classIdx][sampleIdx];

    final pairs = List.generate(
      values.length,
      (i) => ShapFeature(
        featureName: i < _featureNames.length ? _featureNames[i] : 'feature_$i',
        shapValue: values[i],
      ),
    );

    pairs.sort((a, b) => b.shapValue.abs().compareTo(a.shapValue.abs()));
    return pairs.take(topN).toList();
  }
}
