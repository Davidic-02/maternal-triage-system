import 'package:flutter/material.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/models/risk_result.dart';
import 'package:maternal_triage/presentation/widget/prob_bar.dart';

class ProbabilitySection extends StatelessWidget {
  final RiskResult result;
  const ProbabilitySection({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    // Adapt to the model's class count: binary (2) → Low/High,
    // three-class (3) → Low/Medium/High. `classForBar` maps each bar back to
    // the integer riskClass so the selected bar highlights correctly
    // (binary high == class 2, not index 1).
    final bool isBinary = result.probabilities.length == 2;
    final labels = isBinary
        ? ['Low Risk', 'High Risk']
        : ['Low Risk', 'Medium Risk', 'High Risk'];
    final colors = isBinary
        ? [AppColors.accentGreen, AppColors.danger]
        : [AppColors.accentGreen, Colors.orange, AppColors.danger];
    final classForBar = isBinary ? [0, 2] : [0, 1, 2];

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
          const Text(
            'Risk Probability Breakdown',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          AppSpacing.verticalSpaceMedium,
          ...List.generate(
            result.probabilities.length.clamp(0, labels.length),
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ProbBar(
                label: labels[i],
                value: result.probabilities[i],
                color: colors[i],
                isSelected: result.riskClass == classForBar[i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
