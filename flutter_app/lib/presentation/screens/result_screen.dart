import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/assessment/assessment_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/presentation/widget/button.dart';
import 'package:maternal_triage/presentation/widget/clinical_reasoning_section.dart';
import 'package:maternal_triage/presentation/widget/custom_top_bar.dart';
import 'package:maternal_triage/presentation/widget/probability_section.dart';
import 'package:maternal_triage/presentation/widget/recommendation_card.dart';
import 'package:maternal_triage/presentation/widget/risk_badge.dart';
import 'package:maternal_triage/presentation/widget/shap_graph_bar.dart';
import 'package:maternal_triage/presentation/widget/vitals_summary.dart';

class ResultScreen extends HookWidget {
  static const routeName = '/results';
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentBloc, AssessmentState>(
      builder: (context, state) {
        final result = state.result;
        final record = state.record;

        if (result == null || record == null) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppColors.greyColor,
                    ),
                    AppSpacing.verticalSpaceMedium,
                    const Text('No result available'),
                    AppSpacing.verticalSpaceMedium,
                    Button(
                      'Go Back',
                      onPressed: () => context.go('/assessment'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const CustomTopBar(title: 'record'),

                //  _TopBar(record: record),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpacing.verticalSpaceMedium,

                        RiskBadge(result: result),

                        AppSpacing.verticalSpaceMedium,

                        VitalsSummary(record: record),

                        AppSpacing.verticalSpaceMedium,

                        ClinicalReasoningSection(state: state),

                        AppSpacing.verticalSpaceMedium,

                        if (result.shapFeatures.isNotEmpty)
                          ShapGraphSection(result: result),

                        AppSpacing.verticalSpaceMedium,

                        ProbabilitySection(result: result),

                        AppSpacing.verticalSpaceMedium,

                        RecommendationCard(result: result),

                        AppSpacing.verticalSpaceLarge,
                      ],
                    ),
                  ),
                ),

                // ── bottom buttons ────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: Column(
                    children: [
                      Button(
                        'Add to Triage Queue',
                        onPressed: () => context.go('/triage'),
                      ),
                      AppSpacing.verticalSpaceSmall,
                      Button(
                        'New Assessment',
                        color: Colors.transparent,
                        textColor: AppColors.primaryGreen,
                        onPressed: () {
                          context.read<AssessmentBloc>().add(
                            const AssessmentEvent.clearAssessment(),
                          );
                          context.go('/assessment');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
