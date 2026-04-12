import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/triage/triage_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/models/patient_record.dart';
import 'package:maternal_triage/presentation/widget/custom_top_bar.dart';
import 'package:maternal_triage/presentation/widget/empty_state.dart';
import 'package:maternal_triage/presentation/widget/risk_color.dart';

class HistoryScreen extends HookWidget {
  static const routeName = '/history';
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TriageBloc, TriageState>(
      builder: (context, state) {
        // Get resolved patients (history)
        final history = state.filteredResolved;

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // ── Use CustomTopBar ──────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: CustomTopBar(
                    title: 'Assessment History',
                    onTap: () => context.go('/home'),
                  ),
                ),

                // ── Summary stats ─────────────────────────────
                if (history.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _HistoryStat(
                          label: 'Total',
                          value: history.length.toString(),
                        ),
                        _HistoryStat(
                          label: 'High Risk',
                          value: history
                              .where((p) => p.riskClass == 2)
                              .length
                              .toString(),
                          color: AppColors.danger,
                        ),
                        _HistoryStat(
                          label: 'Medium Risk',
                          value: history
                              .where((p) => p.riskClass == 1)
                              .length
                              .toString(),
                          color: Colors.orange,
                        ),
                        _HistoryStat(
                          label: 'Low Risk',
                          value: history
                              .where((p) => p.riskClass == 0)
                              .length
                              .toString(),
                          color: AppColors.accentGreen,
                        ),
                      ],
                    ),
                  ),

                // ── History List ──────────────────────────────
                Expanded(
                  child: history.isEmpty
                      ? const Center(
                          child: EmptyState(
                            message: 'No assessment history',
                            icon: Icons.history,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            final patient = history[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _HistoryCard(
                                patient: patient,
                                onTap: () {
                                  context.go('/triage/${patient.id}');
                                },
                              ),
                            );
                          },
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

// ── History Card ──────────────────────────────────────────────

class _HistoryCard extends StatelessWidget {
  final PatientRecord patient;
  final VoidCallback onTap;

  const _HistoryCard({required this.patient, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = riskColor(patient.riskClass);
    final icon = riskIcon(patient.riskClass);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // ── Risk Badge ────────────────────────
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),

              AppSpacing.horizontalSpaceSmall,

              // ── Patient Info ───────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.patientNameOrId ?? 'Patient',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AppSpacing.verticalSpaceTiny,
                    Row(
                      children: [
                        Text(
                          'Age: ${patient.age.toInt()}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.greyColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'BP: ${patient.systolicBP.toInt()}/${patient.diastolicBP.toInt()}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalSpaceTiny,
                    Text(
                      patient.createdAt != null
                          ? _formatDate(patient.createdAt!)
                          : 'N/A',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.greyColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Risk Label ─────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _riskLabel(patient.riskClass),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),

              // ── Chevron ────────────────────────────
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: AppColors.greyColor),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _riskLabel(int riskClass) {
    switch (riskClass) {
      case 2:
        return 'HIGH';
      case 1:
        return 'MEDIUM';
      case 0:
        return 'LOW';
      default:
        return 'UNKNOWN';
    }
  }
}

// ── History Stat ───────────────────────────────────────────────

class _HistoryStat extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _HistoryStat({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    final displayColor = color ?? AppColors.primaryGreen;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: displayColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: displayColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
