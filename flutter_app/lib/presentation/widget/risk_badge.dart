import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/models/risk_result.dart';
import 'package:maternal_triage/presentation/widget/risk_color.dart';

class RiskBadge extends StatelessWidget {
  final RiskResult result;
  const RiskBadge({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    final color = riskColor(result.riskClass);
    final icon = riskIcon(result.riskClass);
    final confidence = (result.probabilities[result.riskClass] * 100)
        .toStringAsFixed(0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 36),
          ),
          AppSpacing.verticalSpaceMedium,
          Text(
            '$confidence%',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          AppSpacing.verticalSpaceTiny,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${result.riskLabel.toUpperCase()} RISK DETECTED',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
