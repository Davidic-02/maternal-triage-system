import 'package:flutter/material.dart';
import 'package:maternal_triage/bloc/triage/triage_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';

class SummaryCards extends StatelessWidget {
  final TriageState state;
  const SummaryCards({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: 'EMERGENCY',
            count: state.emergencyCount,
            color: AppColors.danger,
            icon: Icons.error_outline,
          ),
        ),
        AppSpacing.horizontalSpaceSmall,
        Expanded(
          child: _SummaryCard(
            label: 'URGENT',
            count: state.urgentCount,
            color: Colors.orange,
            icon: Icons.warning_amber_outlined,
          ),
        ),
        AppSpacing.horizontalSpaceSmall,
        Expanded(
          child: _SummaryCard(
            label: 'STABLE',
            count: state.stableCount,
            color: AppColors.accentGreen,
            icon: Icons.check_circle_outline,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final IconData icon;

  const _SummaryCard({
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Icon(icon, color: color, size: 14),
            ],
          ),
          AppSpacing.verticalSpaceTiny,
          Text(
            count.toString().padLeft(2, '0'),
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
