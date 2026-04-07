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
                // ── top bar ──────────────────────────────────
                _TopBar(record: record),

                // ── scrollable content ────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpacing.verticalSpaceMedium,

                        // ── risk badge with confidence ────────
                        _RiskBadge(result: result),

                        AppSpacing.verticalSpaceMedium,

                        // ── patient vitals summary ────────────
                        _VitalsSummary(record: record),

                        AppSpacing.verticalSpaceMedium,

                        // ── clinical reasoning (Gemini explanation) ──
                        _ClinicalReasoningSection(state: state),

                        AppSpacing.verticalSpaceMedium,

                        // ── probability breakdown (optional) ───
                        _ProbabilitySection(result: result),

                        AppSpacing.verticalSpaceMedium,

                        // ── recommendation ────────────────────
                        _RecommendationCard(result: result),

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

// ── Top Bar ──────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final PatientRecord record;
  const _TopBar({required this.record});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/assessment'),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 16),
            ),
          ),
          const Expanded(
            child: Text(
              'AI Assessment Result',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              record.patientNameOrId ?? 'Patient',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Risk Badge ───────────────────────────────────────────────

class _RiskBadge extends StatelessWidget {
  final RiskResult result;
  const _RiskBadge({required this.result});

  @override
  Widget build(BuildContext context) {
    final color = _riskColor(result.riskClass);
    final icon = _riskIcon(result.riskClass);
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

          // Content
          if (state.isGeneratingExplanation)
            // Loading state
            Row(
              children: [
                SizedBox(
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
            // Conversational explanation from Gemini
            Text(
              state.clinicalExplanation!,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: AppColors.primaryGreen,
              ),
            )
          else if (state.result?.shapFeatures.isNotEmpty ?? false)
            // Fallback: Show SHAP if no Gemini explanation
            _ShapFallback(result: state.result!),
        ],
      ),
    );
  }
}

// Fallback SHAP display if Gemini fails
class _ShapFallback extends StatelessWidget {
  final RiskResult result;
  const _ShapFallback({required this.result});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Key Risk Factors:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.greyColor,
          ),
        ),
        AppSpacing.verticalSpaceSmall,
        ...result.shapFeatures
            .take(3)
            .map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: feature.isPositive
                            ? AppColors.danger
                            : AppColors.accentGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppSpacing.horizontalSpaceSmall,
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
                      '${feature.isPositive ? '+' : '-'}${feature.shapValue.abs().toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: feature.isPositive
                            ? AppColors.danger
                            : AppColors.accentGreen,
                      ),
                    ),
                  ],
                ),
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

class _RecommendationCard extends StatelessWidget {
  final RiskResult result;
  const _RecommendationCard({required this.result});

  @override
  Widget build(BuildContext context) {
    final color = _riskColor(result.riskClass);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.medical_information_outlined,
              color: color,
              size: 20,
            ),
          ),
          AppSpacing.horizontalSpaceSmall,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended Action',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                AppSpacing.verticalSpaceTiny,
                Text(
                  result.recommendation,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: AppColors.primaryGreen,
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

// ── Helpers ──────────────────────────────────────────────────

Color _riskColor(int riskClass) {
  switch (riskClass) {
    case 2:
      return AppColors.danger;
    case 1:
      return Colors.orange;
    case 0:
      return AppColors.accentGreen;
    default:
      return AppColors.greyColor;
  }
}

IconData _riskIcon(int riskClass) {
  switch (riskClass) {
    case 2:
      return Icons.emergency_rounded;
    case 1:
      return Icons.warning_amber_rounded;
    case 0:
      return Icons.check_circle_rounded;
    default:
      return Icons.help_outline;
  }
}
