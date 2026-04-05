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

        // guard — should never happen but just in case
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

                        // ── risk badge ────────────────────────
                        _RiskBadge(result: result),

                        AppSpacing.verticalSpaceMedium,

                        // ── recommendation ────────────────────
                        _RecommendationCard(result: result),

                        AppSpacing.verticalSpaceMedium,

                        // ── probability bars ──────────────────
                        _ProbabilitySection(result: result),

                        AppSpacing.verticalSpaceMedium,

                        // ── patient vitals summary ────────────
                        _VitalsSummary(record: record),

                        AppSpacing.verticalSpaceMedium,

                        // ── shap explanation ──────────────────
                        if (result.shapFeatures.isNotEmpty)
                          _ShapSection(result: result),

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
                      // add to triage queue
                      Button(
                        'Add to Triage Queue',
                        onPressed: () => context.go('/triage'),
                      ),
                      AppSpacing.verticalSpaceSmall,
                      // new assessment
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
              'Assessment Result',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // patient id/name on the right
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
          // animated icon
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
            '${result.riskLabel} Risk',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          AppSpacing.verticalSpaceTiny,
          Text(
            _riskSubtitle(result.riskClass),
            style: const TextStyle(fontSize: 13, color: AppColors.greyColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _riskSubtitle(int riskClass) {
    switch (riskClass) {
      case 0:
        return 'Routine care recommended';
      case 1:
        return 'Increased monitoring needed';
      case 2:
        return 'Immediate intervention required';
      default:
        return '';
    }
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
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
                const Text(
                  'Clinical Recommendation',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.greyColor,
                  ),
                ),
                AppSpacing.verticalSpaceTiny,
                Text(
                  result.recommendation,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
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

// ── Probability Bars ─────────────────────────────────────────

class _ProbabilitySection extends StatelessWidget {
  final RiskResult result;
  const _ProbabilitySection({required this.result});

  @override
  Widget build(BuildContext context) {
    final labels = ['Low Risk', 'Mid Risk', 'High Risk'];
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
            'Risk Probabilities',
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

// ── Vitals Summary ───────────────────────────────────────────

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
          // two column grid of vitals
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

          // danger signs if any active
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

// ── SHAP Explanation ─────────────────────────────────────────

class _ShapSection extends StatelessWidget {
  final RiskResult result;
  const _ShapSection({required this.result});

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
          Row(
            children: [
              const Text(
                'Why this result?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              AppSpacing.horizontalSpaceSmall,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'SHAP Explanation',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.verticalSpaceTiny,
          const Text(
            'Top features that influenced this prediction',
            style: TextStyle(fontSize: 12, color: AppColors.greyColor),
          ),
          AppSpacing.verticalSpaceMedium,
          ...result.shapFeatures.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ShapBar(feature: feature),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShapBar extends HookWidget {
  final ShapFeature feature;
  const _ShapBar({required this.feature});

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

    // normalize for display — cap at 1.0
    final displayValue = absValue.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // direction indicator
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            AppSpacing.horizontalSpaceTiny,
            Expanded(
              child: Text(
                _formatFeatureName(feature.featureName),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              '${isPositive ? '+' : '-'}${absValue.toStringAsFixed(3)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        AppSpacing.verticalSpaceTiny,
        Row(
          children: [
            // negative bar grows left (green — reduces risk)
            Expanded(
              child: isPositive
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: FractionallySizedBox(
                        widthFactor: displayValue * animation,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
            ),
            // centre line
            Container(
              width: 1,
              height: 10,
              color: AppColors.greyColor.withOpacity(0.3),
            ),
            // positive bar grows right (red — increases risk)
            Expanded(
              child: isPositive
                  ? FractionallySizedBox(
                      widthFactor: displayValue * animation,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ],
    );
  }

  String _formatFeatureName(String name) {
    // convert snake_case / camelCase to readable
    return name
        .replaceAll('_', ' ')
        .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(0)}')
        .trim()
        .split(' ')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
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
