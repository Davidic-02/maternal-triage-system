import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maternal_triage/bloc/triage/triage_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/enums/risk_enum.dart';

class FilterTabs extends StatelessWidget {
  final TriageFilter currentFilter;
  const FilterTabs({required this.currentFilter, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'All Patients',
            filter: TriageFilter.all,
            currentFilter: currentFilter,
            color: AppColors.primaryGreen,
          ),
          AppSpacing.horizontalSpaceSmall,
          _FilterChip(
            label: 'Emergency',
            filter: TriageFilter.high,
            currentFilter: currentFilter,
            color: AppColors.danger,
          ),
          AppSpacing.horizontalSpaceSmall,
          _FilterChip(
            label: 'Urgent',
            filter: TriageFilter.moderate,
            currentFilter: currentFilter,
            color: Colors.orange,
          ),
          AppSpacing.horizontalSpaceSmall,
          _FilterChip(
            label: 'Stable',
            filter: TriageFilter.low,
            currentFilter: currentFilter,
            color: AppColors.accentGreen,
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final TriageFilter filter;
  final TriageFilter currentFilter;
  final Color color;

  const _FilterChip({
    required this.label,
    required this.filter,
    required this.currentFilter,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentFilter == filter;

    return GestureDetector(
      onTap: () =>
          context.read<TriageBloc>().add(TriageEvent.filterChanged(filter)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? color : color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            if (!isActive)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : color,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
