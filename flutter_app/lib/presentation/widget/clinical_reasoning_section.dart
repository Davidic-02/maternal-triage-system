import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maternal_triage/bloc/assessment/assessment_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';

class ClinicalReasoningSection extends StatelessWidget {
  final AssessmentState state;
  const ClinicalReasoningSection({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
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
        mainAxisSize: MainAxisSize.min, // ← ADD THIS
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.psychology_outlined,
                  color: AppColors.primaryGreen,
                  size: 18,
                ),
              ),
              AppSpacing.horizontalSpaceSmall,
              const Text(
                'Clinical Reasoning',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'AI Powered',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
            ],
          ),

          AppSpacing.verticalSpaceMedium,

          // Content — now uses SelectableText for full visibility
          if (state.isGeneratingExplanation)
            Row(
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.9, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    builder: (context, scale, child) {
                      return Transform.scale(scale: scale, child: child);
                    },
                    child: Lottie.asset(
                      'assets/animations/chatbot.json',
                      //height: 180,
                    ),
                  ),
                ),
                AppSpacing.horizontalSpaceSmall,
                const Expanded(
                  child: Text(
                    'Generating clinical explanation...',
                    style: TextStyle(color: AppColors.greyColor, fontSize: 13),
                  ),
                ),
              ],
            )
          else if (state.clinicalExplanation != null &&
              state.clinicalExplanation!.isNotEmpty)
            // Full text explanation — no cutting
            SelectableText(
              state.clinicalExplanation!,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: AppColors.primaryGreen,
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.greyColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppColors.greyColor,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'See SHAP explanation below for factor analysis',
                      style: TextStyle(
                        fontSize: 12,
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
}
