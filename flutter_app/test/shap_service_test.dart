import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:maternal_triage/services/shap_service.dart';

List<double> Function(Float32List, int) rowModel(double Function(List<double>) f, int d) =>
    (rows, n) => [for (var i = 0; i < n; i++) f(rows.sublist(i * d, (i + 1) * d))];

void main() {
  test('linear model with one background row gives exact Shapley values', () {
    const w = [0.5, -1.0, 2.0, 0.25];
    final x = Float32List.fromList([0.9, 0.2, 0.4, 1.0]);
    final b = Float32List.fromList([0.1, 0.6, 0.5, 0.0]);
    final r = permutationShapley(
      input: x,
      background: [b],
      cumulativeWeights: [1.0],
      model: rowModel((v) => [for (var i = 0; i < 4; i++) w[i] * v[i]].reduce((a, c) => a + c), 4),
      permutations: 8,
      seed: 1,
    );
    for (var i = 0; i < 4; i++) {
      expect(r.values[i], closeTo(w[i] * (x[i] - b[i]), 1e-6));
    }
  });

  test('values sum to f(x) minus the base value for a nonlinear model', () {
    double f(List<double> v) => v[0] * v[1] + v[2] * v[2] - v[3];
    final x = Float32List.fromList([0.8, 0.7, 0.3, 0.6]);
    final r = permutationShapley(
      input: x,
      background: [Float32List.fromList([0.1, 0.2, 0.9, 0.0]), Float32List.fromList([0.5, 0.5, 0.5, 0.5])],
      cumulativeWeights: [0.4, 1.0],
      model: rowModel(f, 4),
      permutations: 64,
      seed: 42,
    );
    expect(r.values.reduce((a, b) => a + b) + r.baseValue, closeTo(f(x), 1e-6));
  });

  test('same patient and seed give the same explanation', () {
    final x = Float32List.fromList([0.3, 0.6]);
    ShapExplanation run() => permutationShapley(
          input: x,
          background: [Float32List.fromList([0.0, 0.0]), Float32List.fromList([1.0, 1.0])],
          cumulativeWeights: [0.5, 1.0],
          model: rowModel((v) => v[0] * v[1], 2),
          permutations: 16,
          seed: 42,
        );
    expect(run().values, run().values);
  });
}
