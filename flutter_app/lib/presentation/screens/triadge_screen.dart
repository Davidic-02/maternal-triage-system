import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maternal_triage/bloc/triage/triage_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/enums/risk_enum.dart';
import 'package:maternal_triage/presentation/widget/custom_text_form_field.dart';
import 'package:maternal_triage/services/persistence_services.dart';
import 'package:maternal_triage/presentation/widget/custom_top_bar.dart';

class TriadgeScreen extends HookWidget {
  static const routeName = '/triage';
  const TriadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameFuture = useMemoized(() => PersistenceService().getUserName());
    final roleFuture = useMemoized(() => PersistenceService().getUserRole());
    final name = useFuture(nameFuture);
    final role = useFuture(roleFuture);

    final displayName = name.data ?? 'Doctor';
    final displayRole = role.data ?? 'Medical Officer';
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TriageBloc, TriageState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTopBar(
                  title: '',
                  leading: Row(
                    children: [
                      // avatar with initials
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.primaryGreen,
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
                            displayName,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const Text(
                            'Triage Dashboard',
                            style: TextStyle(
                              // color: AppColors.greyColor,
                              fontSize: 12,
                            ),
                          ), // role from persistence

                          Text(
                            displayRole.toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.primaryGreen,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),

                          // name from persistence

                          // triage dashboard subtitle
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
                              // color: AppColors.shadowColor,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
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

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const SearchBar({required this.controller, required this.focusNode});
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,

      focusNode: focusNode,
      hintText: 'Search patients...',
      keyboardType: TextInputType.text,
      prefixIcon: '🔍',
      onChanged: (value) =>
          context.read<TriageBloc>().add(TriageEvent.searchChanged(value)),
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
