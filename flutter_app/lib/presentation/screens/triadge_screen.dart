import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/bloc/triage/triage_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/enums/risk_enum.dart';
import 'package:maternal_triage/models/patient_record.dart';
import 'package:timeago/timeago.dart' as timeago;

class TriageScreen extends HookWidget {
  static const routeName = '/triage';
  const TriageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // only hooks needed — controller + focusNode for search field
    final searchController = useTextEditingController();
    final searchFocusNode = useFocusNode();

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TriageBloc, TriageState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                // ── header ──────────────────────────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: _Header(),
                  ),
                ),

                // ── summary cards ────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: _SummaryCards(state: state),
                  ),
                ),

                // ── search bar ───────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: _TriageSearchBar(
                      controller: searchController,
                      focusNode: searchFocusNode,
                    ),
                  ),
                ),

                // ── filter tabs ──────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: _FilterTabs(currentFilter: state.filter),
                  ),
                ),

                // ── active queue header ──────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: Row(
                      children: [
                        Text(
                          'Active Queue (${state.filteredQueue.length})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'By Urgency',
                          style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.primaryGreen,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),

                // ── loading ──────────────────────────────────────
                if (state.status == TriageStatus.loading)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),

                // ── empty active queue ───────────────────────────
                if (state.status == TriageStatus.loaded &&
                    state.filteredQueue.isEmpty)
                  const SliverToBoxAdapter(
                    child: _EmptyState(
                      message: 'No active patients in queue',
                      icon: Icons.check_circle_outline,
                    ),
                  ),

                // ── active queue list ────────────────────────────
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final record = state.filteredQueue[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                      child: _PatientCard(
                        record: record,
                        isResolved: false,
                        onTap: () => context.go('/triage/${record.id}'),
                        onResolve: () => context.read<TriageBloc>().add(
                          TriageEvent.resolvePatient(record.id!),
                        ),
                      ),
                    );
                  }, childCount: state.filteredQueue.length),
                ),

                // ── resolved today ───────────────────────────────
                if (state.filteredResolved.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Text(
                        'Resolved Today (${state.filteredResolved.length})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final record = state.filteredResolved[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                        child: _PatientCard(
                          record: record,
                          isResolved: true,
                          onTap: () => context.go('/triage/${record.id}'),
                        ),
                      );
                    }, childCount: state.filteredResolved.length),
                  ),
                ],

                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Header ───────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous.userName != current.userName ||
          previous.userRole != current.userRole,
      builder: (context, state) {
        final displayName = state.userName ?? 'Doctor';
        final displayRole = state.userRole ?? 'Medical Officer';

        return Row(
          children: [
            // avatar with initials
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primaryGreen.withOpacity(0.15),
              child: Text(
                _initials(displayName),
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            AppSpacing.horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayRole.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  displayName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Text(
                  'Triage Dashboard',
                  style: TextStyle(color: AppColors.greyColor, fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            // notification bell
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.notifications_outlined, size: 20),
            ),
          ],
        );
      },
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

// ── Summary Cards ────────────────────────────────────────────

class _SummaryCards extends StatelessWidget {
  final TriageState state;
  const _SummaryCards({required this.state});

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
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15)),
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

// ── Search Bar ───────────────────────────────────────────────

class _TriageSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const _TriageSearchBar({required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: (value) =>
          context.read<TriageBloc>().add(TriageEvent.searchChanged(value)),
      decoration: InputDecoration(
        hintText: 'Search patients...',
        prefixIcon: const Icon(Icons.search, size: 20),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  controller.clear();
                  context.read<TriageBloc>().add(
                    const TriageEvent.searchChanged(''),
                  );
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
      ),
    );
  }
}

// ── Filter Tabs ──────────────────────────────────────────────

class _FilterTabs extends StatelessWidget {
  final TriageFilter currentFilter;
  const _FilterTabs({required this.currentFilter});

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
          color: isActive ? color : color.withOpacity(0.08),
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

// ── Patient Card ─────────────────────────────────────────────

class _PatientCard extends StatelessWidget {
  final PatientRecord record;
  final bool isResolved;
  final VoidCallback onTap;
  final VoidCallback? onResolve;

  const _PatientCard({
    required this.record,
    required this.isResolved,
    required this.onTap,
    this.onResolve,
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
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 8,
                offset: const Offset(0, 2),
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
                        record.assessedBy ?? 'Unknown',
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
                        color: riskColor.withOpacity(0.12),
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
                          color: AppColors.accentGreen.withOpacity(0.1),
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
        color: AppColors.primaryGreen.withOpacity(0.07),
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

class _EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  const _EmptyState({required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(icon, size: 48, color: AppColors.greyColor),
          AppSpacing.verticalSpaceSmall,
          Text(
            message,
            style: const TextStyle(color: AppColors.greyColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
