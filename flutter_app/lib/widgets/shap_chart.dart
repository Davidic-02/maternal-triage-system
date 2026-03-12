import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/risk_result.dart';

/// Horizontal bar chart displaying the top SHAP feature contributions.
class ShapChart extends StatelessWidget {
  final List<ShapFeature> features;

  const ShapChart({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    if (features.isEmpty) {
      return const Center(child: Text('No SHAP data available'));
    }

    final maxAbs = features
        .map((f) => f.shapValue.abs())
        .reduce((a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        maxY: maxAbs * 1.2,
        minY: -(maxAbs * 1.2),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 120,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= features.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Text(
                    features[idx].featureName,
                    style: const TextStyle(fontSize: 11),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: const AxisTitles(
            axisNameWidget: Text(
              'SHAP value',
              style: TextStyle(fontSize: 12),
            ),
            sideTitles: SideTitles(showTitles: true, reservedSize: 20),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: features.asMap().entries.map((entry) {
          final i = entry.key;
          final f = entry.value;
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: f.shapValue,
                color: f.isPositive ? Colors.red.shade400 : Colors.blue.shade400,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
