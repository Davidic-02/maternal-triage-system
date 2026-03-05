import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/risk_result.dart';
import '../utils/constants.dart';

/// Service that loads pre-computed SHAP values and provides local explanations.
class ShapService {
  List<String> _featureNames = [];

  /// shap_values[classIndex][sampleIndex][featureIndex]
  List<List<List<double>>> _shapValues = [];

  bool get isLoaded => _shapValues.isNotEmpty;

  /// Loads the SHAP JSON file from assets.  Call once during app startup.
  ///
  /// The JSON has shape [1][50][14][3] — 1 outer list, 50 samples,
  /// 14 features, 3 classes.  This method transposes to
  /// [classIndex][sampleIndex][featureIndex] for convenient access.
  Future<void> loadShapValues() async {
    final raw = await rootBundle.loadString(kShapAsset);
    final json = jsonDecode(raw) as Map<String, dynamic>;

    _featureNames =
        List<String>.from(json['feature_names'] as List? ?? []);

    // raw shape: [1][50][14][3] — squeeze outer dim → [50][14][3]
    final outerList = json['shap_values'] as List;
    final samples = outerList[0] as List; // [50][14][3]

    // Transpose to [3][50][14] for classIdx-first access
    final nSamples = samples.length;
    final nFeatures = (samples[0] as List).length;
    final nClasses = ((samples[0] as List)[0] as List).length;

    _shapValues = List.generate(
      nClasses,
      (c) => List.generate(
        nSamples,
        (s) => List.generate(
          nFeatures,
          (f) => (((samples[s] as List)[f] as List)[c] as num).toDouble(),
        ),
      ),
    );
  }

  /// Returns the top [topN] SHAP feature contributions for sample at [index].
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
