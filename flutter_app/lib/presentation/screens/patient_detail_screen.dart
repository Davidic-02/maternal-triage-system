import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/triage/triage_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/models/patient_record.dart';
import 'package:maternal_triage/presentation/widget/button.dart';
import 'package:maternal_triage/presentation/widget/custom_top_bar.dart';
import 'package:maternal_triage/presentation/widget/risk_color.dart';
import 'package:maternal_triage/presentation/widget/vitals_summary.dart';

class PatientDetailScreen extends HookWidget {
  final String patientId;

  const PatientDetailScreen({super.key, required this.patientId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TriageBloc, TriageState>(
      builder: (context, state) {
        final patient = _findPatientById(state, patientId);

        if (patient == null) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person_off_outlined,
                      size: 48,
                      color: AppColors.greyColor,
                    ),
                    AppSpacing.verticalSpaceMedium,
                    const Text('Patient not found'),
                    AppSpacing.verticalSpaceMedium,
                    Button('Go Back', onPressed: () => context.go('/triage')),
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
                CustomTopBar(
                  title: 'Patient Details',
                  onTap: () => context.go('/triage'),
                  ending: _riskLabel(patient.riskClass ?? 0),
                ),

                // ── Scrollable Content ───────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpacing.verticalSpaceMedium,

                        _PatientInfoCard(patient: patient),

                        AppSpacing.verticalSpaceMedium,

                        // ── Risk Assessment Card ─────────────
                        _RiskAssessmentCard(patient: patient),

                        AppSpacing.verticalSpaceMedium,

                        VitalsSummary(record: patient),

                        AppSpacing.verticalSpaceMedium,

                        _ClinicalFindingsCard(patient: patient),

                        AppSpacing.verticalSpaceMedium,

                        _AssessmentInfoCard(patient: patient),

                        AppSpacing.verticalSpaceLarge,
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: Column(
                    children: [
                      Button(
                        'View Full Assessment',
                        onPressed: () {
                          context.go('/results');
                        },
                      ),
                      AppSpacing.verticalSpaceSmall,
                      Button(
                        'Back to Queue',
                        color: Colors.transparent,
                        textColor: AppColors.primaryGreen,
                        onPressed: () => context.go('/triage'),
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

  PatientRecord? _findPatientById(TriageState state, String id) {
    // Combine both queues and search
    final allPatients = [...state.activeQueue, ...state.resolvedToday];
    try {
      return allPatients.firstWhere((patient) => patient.id == id);
    } catch (e) {
      return null;
    }
  }
}

class _PatientInfoCard extends StatelessWidget {
  final PatientRecord patient;
  const _PatientInfoCard({required this.patient});

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
          Text(
            patient.patientNameOrId ?? 'Patient',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          AppSpacing.verticalSpaceSmall,
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _InfoChip(label: 'Age', value: '${patient.age.toInt()} yrs'),
              _InfoChip(
                label: 'GA',
                value: '${patient.gestationalAge?.toInt() ?? 'N/A'} weeks',
              ),
              _InfoChip(
                label: 'ID',
                value: patient.id?.substring(0, 8) ?? 'N/A',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  const _InfoChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

// ── Risk Assessment Card (Minimal) ───────────────────────────

class _RiskAssessmentCard extends StatelessWidget {
  final PatientRecord patient;
  const _RiskAssessmentCard({required this.patient});

  @override
  Widget build(BuildContext context) {
    final color = riskColor(patient.riskClass ?? 0);
    final icon = riskIcon(patient.riskClass ?? 0);

    return Container(
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
            child: Icon(icon, color: color, size: 20),
          ),
          AppSpacing.horizontalSpaceSmall,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Risk Classification',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.greyColor,
                  ),
                ),
                AppSpacing.verticalSpaceTiny,
                Text(
                  _riskLabel(patient.riskClass ?? 0),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
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

// ── Clinical Findings Card ───────────────────────────────────

class _ClinicalFindingsCard extends StatelessWidget {
  final PatientRecord patient;
  const _ClinicalFindingsCard({required this.patient});

  @override
  Widget build(BuildContext context) {
    final findings = _getClinicalFindings(patient);

    if (findings.isEmpty) {
      return const SizedBox.shrink();
    }

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
            'Clinical Findings',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          AppSpacing.verticalSpaceMedium,
          ...findings.asMap().entries.map(
            (entry) => Padding(
              padding: EdgeInsets.only(
                bottom: entry.key < findings.length - 1 ? 12 : 0,
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: entry.value['type'] == 'danger'
                          ? AppColors.danger
                          : AppColors.accentGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.value['label'],
                      style: TextStyle(
                        fontSize: 13,
                        color: entry.value['type'] == 'danger'
                            ? AppColors.danger
                            : AppColors.primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getClinicalFindings(PatientRecord patient) {
    final findings = <Map<String, dynamic>>[];

    if (patient.blurredVision) {
      findings.add({'label': 'Blurred Vision / Headache', 'type': 'danger'});
    }
    if (patient.vaginalBleeding) {
      findings.add({'label': 'Vaginal Bleeding', 'type': 'danger'});
    }
    if (patient.severeSwelling) {
      findings.add({'label': 'Severe Swelling', 'type': 'danger'});
    }
    if (patient.reducedFetalMovement) {
      findings.add({'label': 'Reduced Fetal Movement', 'type': 'danger'});
    }
    if (patient.previousComplications) {
      findings.add({
        'label': 'Previous Pregnancy Complications',
        'type': 'info',
      });
    }
    if (patient.preexistingDiabetes) {
      findings.add({'label': 'Preexisting Diabetes', 'type': 'info'});
    }
    if (patient.gestationalDiabetes) {
      findings.add({'label': 'Gestational Diabetes', 'type': 'info'});
    }
    if (patient.hypertension) {
      findings.add({'label': 'Hypertension', 'type': 'info'});
    }

    return findings;
  }
}

// ── Assessment Info Card ────────────────────────────────────

class _AssessmentInfoCard extends StatelessWidget {
  final PatientRecord patient;
  const _AssessmentInfoCard({required this.patient});

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
            'Assessment Info',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          AppSpacing.verticalSpaceMedium,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Assessed By',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.greyColor,
                      ),
                    ),
                    AppSpacing.verticalSpaceTiny,
                    Text(
                      patient.assessedBy ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Assessment Date',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.greyColor,
                      ),
                    ),
                    AppSpacing.verticalSpaceTiny,
                    Text(
                      '${patient.createdAt.day}/${patient.createdAt.month}/${patient.createdAt.year}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Helpers (REUSED from risk_color.dart) ────────────────────

String _riskLabel(int riskClass) {
  switch (riskClass) {
    case 2:
      return 'HIGH RISK';
    case 1:
      return 'MEDIUM RISK';
    case 0:
      return 'LOW RISK';
    default:
      return 'UNKNOWN';
  }
}
