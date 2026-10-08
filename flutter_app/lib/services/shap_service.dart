import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import '../models/risk_result.dart';
import '../utils/constants.dart';

/// Scores a batch of [n] normalised feature rows and returns P(high risk) per row.
typedef BatchModel = List<double> Function(Float32List rows, int n);

class ShapExplanation {
  const ShapExplanation({required this.values, required this.baseValue});

  /// Contribution of each feature to P(high risk), in model feature order.
  final List<double> values;

  /// Expected P(high risk) over the background set.
  final double baseValue;
}

/// Computes per-patient Shapley explanations on-device.
///
/// Mirrors permutation_shapley() in ml_pipeline/src/export_explainer_assets.py,
/// which validates it against shap.KernelExplainer.
class ShapService {
  List<String> _featureNames = [];
  List<Float32List> _background = [];
  List<double> _cumulativeWeights = [];
  int _permutations = kShapPermutations;

  bool get isLoaded => _background.isNotEmpty;

  Future<void> loadBackground() async {
    final json = jsonDecode(await rootBundle.loadString(kShapBackgroundAsset))
        as Map<String, dynamic>;
    _featureNames = List<String>.from(json['feature_names'] as List);
    _background = [
      for (final row in json['data'] as List)
        Float32List.fromList([for (final v in row as List) (v as num).toDouble()]),
    ];
    final weights = [for (final w in json['weights'] as List) (w as num).toDouble()];
    final total = weights.reduce((a, b) => a + b);
    var acc = 0.0;
    _cumulativeWeights = [for (final w in weights) acc += w / total];
    _permutations = (json['permutations'] as num?)?.toInt() ?? kShapPermutations;
  }

  /// Top [topN] features driving this patient's P(high risk), largest first.
  List<ShapFeature> explainPatient({
    required Float32List input,
    required BatchModel model,
    int topN = 5,
  }) {
    if (!isLoaded) {
      throw StateError('SHAP background not loaded. Call loadBackground() first.');
    }
    final result = permutationShapley(
      input: input,
      background: _background,
      cumulativeWeights: _cumulativeWeights,
      model: model,
      permutations: _permutations,
      seed: kShapSeed,
    );
    final features = [
      for (var i = 0; i < result.values.length; i++)
        ShapFeature(
          featureName: i < _featureNames.length ? _featureNames[i] : 'feature_$i',
          shapValue: result.values[i],
        ),
    ]..sort((a, b) => b.shapValue.abs().compareTo(a.shapValue.abs()));
    return features.take(topN).toList();
  }
}

/// Monte-Carlo Shapley values with antithetic permutations.
///
/// For each permutation a background row is drawn by weight, features are
/// switched from background to patient values in permutation order, and each
/// feature is credited with the resulting change in P(high risk). All rows are
/// scored in a single batched model call.
ShapExplanation permutationShapley({
  required Float32List input,
  required List<Float32List> background,
  required List<double> cumulativeWeights,
  required BatchModel model,
  required int permutations,
  required int seed,
}) {
  final d = input.length;
  final rng = Random(seed);
  final orders = <List<int>>[];
  for (var k = 0; k < permutations ~/ 2; k++) {
    final p = List<int>.generate(d, (i) => i)..shuffle(rng);
    orders
      ..add(p)
      ..add(p.reversed.toList());
  }

  final step = d + 1;
  final rows = Float32List(orders.length * step * d);
  var offset = 0;
  for (final order in orders) {
    final r = rng.nextDouble();
    var b = cumulativeWeights.indexWhere((c) => r <= c);
    if (b < 0) b = background.length - 1;
    final z = Float32List.fromList(background[b]);
    rows.setAll(offset, z);
    offset += d;
    for (final j in order) {
      z[j] = input[j];
      rows.setAll(offset, z);
      offset += d;
    }
  }

  final preds = model(rows, orders.length * step);
  final phi = List<double>.filled(d, 0.0);
  var base = 0.0;
  for (var i = 0; i < orders.length; i++) {
    final start = i * step;
    base += preds[start];
    for (var k = 0; k < d; k++) {
      phi[orders[i][k]] += preds[start + k + 1] - preds[start + k];
    }
  }
  final n = orders.length;
  return ShapExplanation(
    values: [for (final v in phi) v / n],
    baseValue: base / n,
  );
}
