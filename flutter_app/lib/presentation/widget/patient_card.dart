import 'package:flutter/material.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/models/patient_record.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:maternal_triage/constant/app_colors.dart';

class PatientCard extends StatelessWidget {
  final PatientRecord record;
  final bool isResolved;
  final VoidCallback onTap;
  final VoidCallback? onResolve;

  const PatientCard({
    required this.record,
    required this.isResolved,
    required this.onTap,
    this.onResolve,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final riskColor = _riskColor(record.riskClass);
    final riskLabel = _riskLabel(record.riskClass);

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isResolved ? 0.6 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border(left: BorderSide(color: riskColor, width: 4)),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // top row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        record.patientNameOrId ?? 'Unknown',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: riskColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        riskLabel,
                        style: TextStyle(
                          color: riskColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    AppSpacing.horizontalSpaceTiny,
                    Text(
                      timeago.format(record.createdAt),
                      style: const TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                AppSpacing.verticalSpaceTiny,

                // age + heart rate
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 13,
                      color: AppColors.greyColor,
                    ),
                    AppSpacing.horizontalSpaceTiny,
                    Text(
                      '${record.age.toInt()}y',
                      style: const TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 12,
                      ),
                    ),
                    AppSpacing.horizontalSpaceSmall,
                    const Icon(
                      Icons.favorite_border,
                      size: 13,
                      color: AppColors.greyColor,
                    ),
                    AppSpacing.horizontalSpaceTiny,
                    Text(
                      '${record.heartRate.toInt()} bpm',
                      style: const TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                AppSpacing.verticalSpaceSmall,

                // vitals tags + action
                Row(
                  children: [
                    _VitalTag(
                      label:
                          'BP ${record.systolicBP.toInt()}/${record.diastolicBP.toInt()}',
                    ),
                    AppSpacing.horizontalSpaceTiny,
                    _VitalTag(
                      label: 'BS ${record.bloodSugar.toStringAsFixed(1)}',
                    ),
                    const Spacer(),
                    if (isResolved)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Resolved',
                          style: TextStyle(
                            color: AppColors.accentGreen,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: onResolve,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  String _riskLabel(int riskClass) {
    switch (riskClass) {
      case 2:
        return 'HIGH RISK AI';
      case 1:
        return 'MODERATE';
      case 0:
        return 'LOW';
      default:
        return 'UNKNOWN';
    }
  }
}

// ── Vital Tag ────────────────────────────────────────────────

class _VitalTag extends StatelessWidget {
  final String label;
  const _VitalTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryGreen.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryGreen,
        ),
      ),
    );
  }
}

// ── Empty State ──────────────────────────────────────────────
