import 'package:flutter/material.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/models/patient_record.dart';

class VitalsSummary extends StatelessWidget {
  final PatientRecord record;
  const VitalsSummary({required this.record, super.key});

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
                  const _DangerChip(label: 'Headache / Blurred Vision'),
                if (record.vaginalBleeding)
                  const _DangerChip(label: 'Vaginal Bleeding'),
                if (record.severeSwelling)
                  const _DangerChip(label: 'Severe Swelling'),
                if (record.reducedFetalMovement)
                  const _DangerChip(label: 'Reduced Fetal Movement'),
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
