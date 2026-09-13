import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/models/risk_result.dart';

class ShapChartSection extends StatelessWidget {
  final RiskResult result;
  const ShapChartSection({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    if (result.shapFeatures.isEmpty) {
      return const SizedBox.shrink();
    }

    final topFeatures = result.shapFeatures.take(6).toList();

    // Calculate max value for scaling
    final maxValue = topFeatures
        .map((f) => f.shapValue.abs())
        .reduce((a, b) => a > b ? a : b);

    // Prepare chart data
    final chartData = topFeatures.asMap().entries.map((entry) {
      final index = entry.key;
      final feature = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: feature.shapValue.abs(),
            color: feature.isPositive
                ? AppColors.danger
                : AppColors.accentGreen,
            width: 30,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
        ],
      );
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  color: Colors.orange,
                  size: 18,
                ),
              ),
              AppSpacing.horizontalSpaceSmall,
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key Risk Factors',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'What influenced this prediction',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'SHAP',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),

          AppSpacing.verticalSpaceMedium,

          // ── Legend ───────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.greyColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.danger,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Increases Risk',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.accentGreen,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Decreases Risk',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          AppSpacing.verticalSpaceMedium,

          // ── Bar Chart ────────────────────────────────────
          SizedBox(
            height: 280,
            child: BarChart(
              BarChartData(
                groupsSpace: 2,
                alignment: BarChartAlignment.spaceBetween,
                maxY: maxValue * 1.1,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) =>
                        AppColors.primaryGreen.withOpacity(0.9),
                    tooltipBorderRadius: BorderRadius.circular(8),
                    tooltipPadding: const EdgeInsets.all(8),
                    tooltipMargin: 6,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      if (groupIndex >= topFeatures.length) {
                        return null;
                      }
                      final feature = topFeatures[groupIndex];
                      return BarTooltipItem(
                        '${_formatFeatureName(feature.featureName)}\n${rod.toY.toStringAsFixed(3)}',
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= topFeatures.length) {
                          return const SizedBox.shrink();
                        }
                        final feature = topFeatures[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Text(
                              _formatFeatureName(feature.featureName),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                          ),
                        );
                      },
                      reservedSize: 80,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(2),
                          style: const TextStyle(
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        );
                      },
                      reservedSize: 40,
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxValue / 4,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.greyColor.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.greyColor.withOpacity(0.2),
                    ),
                    left: BorderSide(
                      color: AppColors.greyColor.withOpacity(0.2),
                    ),
                    bottom: BorderSide(
                      color: AppColors.greyColor.withOpacity(0.2),
                    ),
                    right: BorderSide.none,
                  ),
                ),
                barGroups: chartData,
              ),
            ),
          ),

          AppSpacing.verticalSpaceMedium,

          // ── Data Table ───────────────────────────────────
          _FeatureTable(features: topFeatures),

          AppSpacing.verticalSpaceMedium,

          // ── Footer note ──────────────────────────────────
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primaryGreen.withOpacity(0.1),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 14,
                  color: AppColors.primaryGreen,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Higher bars = stronger influence on the risk prediction',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.greyColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatFeatureName(String name) {
    return name
        .replaceAll('_', ' ')
        .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(0)}')
        .trim()
        .split(' ')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}

// ── Feature Table ────────────────────────────────────────────

class _FeatureTable extends StatelessWidget {
  final List<ShapFeature> features;
  const _FeatureTable({required this.features});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyColor.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 10, 12, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Feature',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.greyColor,
                  ),
                ),
                Text(
                  'Impact',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.greyColor,
                  ),
                ),
                Text(
                  'Effect',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.greyColor.withOpacity(0.1)),
          ...features.asMap().entries.map((entry) {
            final feature = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _formatFeatureName(feature.featureName),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    feature.shapValue.abs().toStringAsFixed(3),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: feature.isPositive
                          ? AppColors.danger
                          : AppColors.accentGreen,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: feature.isPositive
                          ? AppColors.danger.withOpacity(0.1)
                          : AppColors.accentGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      feature.isPositive ? '↑ Risk' : '↓ Risk',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: feature.isPositive
                            ? AppColors.danger
                            : AppColors.accentGreen,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _formatFeatureName(String name) {
    return name
        .replaceAll('_', ' ')
        .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(0)}')
        .trim()
        .split(' ')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}
