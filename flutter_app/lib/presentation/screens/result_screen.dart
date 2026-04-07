import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/assessment/assessment_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/models/patient_record.dart';
import 'package:maternal_triage/models/risk_result.dart';
import 'package:maternal_triage/presentation/widget/button.dart';
import 'package:maternal_triage/presentation/widget/custom_top_bar.dart';
import 'package:maternal_triage/presentation/widget/recommendation_card.dart';
import 'package:maternal_triage/presentation/widget/risk_badge.dart';

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

                        _VitalsSummary(record: record),

                        AppSpacing.verticalSpaceMedium,

                        _ClinicalReasoningSection(state: state),

                        AppSpacing.verticalSpaceMedium,

                        if (result.shapFeatures.isNotEmpty)
                          _ShapGraphSection(result: result),

                        AppSpacing.verticalSpaceMedium,

                        _ProbabilitySection(result: result),

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

// ── Patient Vitals Summary ───────────────────────────────────

class _VitalsSummary extends StatelessWidget {
  final PatientRecord record;
  const _VitalsSummary({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Patient Vitals',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          AppSpacing.verticalSpaceMedium,
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _VitalChip(label: 'Age', value: '${record.age.toInt()} yrs'),
              _VitalChip(
                label: 'BP',
                value:
                    '${record.systolicBP.toInt()}/${record.diastolicBP.toInt()} mmHg',
              ),
              _VitalChip(label: 'HR', value: '${record.heartRate.toInt()} bpm'),
              _VitalChip(
                label: 'Blood Sugar',
                value: '${record.bloodSugar.toStringAsFixed(1)} mmol/L',
              ),
              _VitalChip(
                label: 'Temp',
                value: '${record.bodyTemp.toStringAsFixed(1)} °C',
              ),
              if (record.weight != null)
                _VitalChip(
                  label: 'Weight',
                  value: '${record.weight!.toStringAsFixed(1)} kg',
                ),
              if (record.bmi != null)
                _VitalChip(label: 'BMI', value: record.bmi!.toStringAsFixed(1)),
              _VitalChip(
                label: 'Pulse Pressure',
                value: '${record.pulsePressure.toStringAsFixed(0)} mmHg',
              ),
            ],
          ),
          // danger signs
          if (_hasDangerSigns(record)) ...[
            AppSpacing.verticalSpaceMedium,
            const Text(
              'Danger Signs Present',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.danger,
              ),
            ),
            AppSpacing.verticalSpaceSmall,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (record.blurredVision)
                  _DangerChip(label: 'Headache / Blurred Vision'),
                if (record.vaginalBleeding)
                  _DangerChip(label: 'Vaginal Bleeding'),
                if (record.severeSwelling)
                  _DangerChip(label: 'Severe Swelling'),
                if (record.reducedFetalMovement)
                  _DangerChip(label: 'Reduced Fetal Movement'),
              ],
            ),
          ],
        ],
      ),
    );
  }

  bool _hasDangerSigns(PatientRecord record) =>
      record.blurredVision ||
      record.vaginalBleeding ||
      record.severeSwelling ||
      record.reducedFetalMovement;
}

class _VitalChip extends StatelessWidget {
  final String label;
  final String value;
  const _VitalChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryGreen.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _DangerChip extends StatelessWidget {
  final String label;
  const _DangerChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.danger.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.danger.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.danger,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── CLINICAL REASONING SECTION (Gemini Explanation) ──────────

// ── CLINICAL REASONING SECTION (Gemini Explanation) ──────────

class _ClinicalReasoningSection extends StatelessWidget {
  final AssessmentState state;
  const _ClinicalReasoningSection({required this.state});

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
            offset: const Offset(0, 2),
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
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primaryGreen,
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
// ── SHAP Explanation as Graph ────────────────────────────────

class _ShapGraphSection extends StatelessWidget {
  final RiskResult result;
  const _ShapGraphSection({required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
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
              const Text(
                'Key Risk Factors',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'SHAP',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),

          AppSpacing.verticalSpaceSmall,

          const Text(
            'Features with highest impact on prediction',
            style: TextStyle(fontSize: 12, color: AppColors.greyColor),
          ),

          AppSpacing.verticalSpaceMedium,

          // SHAP bars (graph form)
          ...result.shapFeatures
              .take(5)
              .map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _ShapGraphBar(feature: feature),
                ),
              ),
        ],
      ),
    );
  }
}

class _ShapGraphBar extends HookWidget {
  final ShapFeature feature;
  const _ShapGraphBar({required this.feature});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );
    final animation = useAnimation(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );

    useEffect(() {
      controller.forward();
      return null;
    }, const []);

    final isPositive = feature.isPositive;
    final color = isPositive ? AppColors.danger : AppColors.accentGreen;
    final absValue = feature.shapValue.abs();
    final displayValue = absValue.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Feature name + value
        Row(
          children: [
            Expanded(
              child: Text(
                _formatFeatureName(feature.featureName),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${isPositive ? '+' : '-'}${absValue.toStringAsFixed(3)}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ],
        ),

        AppSpacing.verticalSpaceSmall,

        // Horizontal bar graph
        Row(
          children: [
            // Negative bar (green, left side)
            Expanded(
              child: isPositive
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: FractionallySizedBox(
                        widthFactor: displayValue * animation,
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),

            // Center divider line
            Container(
              width: 2,
              height: 14,
              color: AppColors.greyColor.withOpacity(0.3),
            ),

            // Positive bar (red, right side)
            Expanded(
              child: isPositive
                  ? FractionallySizedBox(
                      widthFactor: displayValue * animation,
                      child: Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),

        // Direction indicator
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              Text(
                isPositive ? 'Increases risk' : 'Decreases risk',
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
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

// ── Probability Breakdown ─────────────────────────────────────

class _ProbabilitySection extends StatelessWidget {
  final RiskResult result;
  const _ProbabilitySection({required this.result});

  @override
  Widget build(BuildContext context) {
    final labels = ['Low Risk', 'Medium Risk', 'High Risk'];
    final colors = [AppColors.accentGreen, Colors.orange, AppColors.danger];

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
            result.probabilities.length.clamp(0, 3),
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ProbBar(
                label: labels[i],
                value: result.probabilities[i],
                color: colors[i],
                isSelected: result.riskClass == i,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProbBar extends HookWidget {
  final String label;
  final double value;
  final Color color;
  final bool isSelected;

  const _ProbBar({
    required this.label,
    required this.value,
    required this.color,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );
    final animation = useAnimation(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );

    useEffect(() {
      controller.forward();
      return null;
    }, const []);

    final pct = (value * 100).toStringAsFixed(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected ? color : null,
              ),
            ),
            const Spacer(),
            Text(
              '$pct%',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? color : AppColors.greyColor,
              ),
            ),
          ],
        ),
        AppSpacing.verticalSpaceTiny,
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value * animation,
            minHeight: 8,
            backgroundColor: color.withOpacity(0.12),
            valueColor: AlwaysStoppedAnimation<Color>(
              isSelected ? color : color.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Recommendation Card ──────────────────────────────────────

// ── Helpers ──────────────────────────────────────────────────
