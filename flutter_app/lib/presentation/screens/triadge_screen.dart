import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/triage/triage_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/enums/risk_enum.dart';
import 'package:maternal_triage/presentation/widget/empty_state.dart';
import 'package:maternal_triage/presentation/widget/filter_tab.dart';
import 'package:maternal_triage/presentation/widget/header.dart';
import 'package:maternal_triage/presentation/widget/patient_card.dart';
import 'package:maternal_triage/presentation/widget/summary_cards.dart';
import 'package:maternal_triage/presentation/widget/triage_searchbar.dart';

class TriageScreen extends HookWidget {
  static const routeName = '/triage';
  const TriageScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: Header(),
                  ),
                ),

                // ── summary cards ────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: SummaryCards(state: state),
                  ),
                ),

                // ── search bar ───────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TriageSearchBar(
                      controller: searchController,
                      focusNode: searchFocusNode,
                    ),
                  ),
                ),

                // ── filter tabs ──────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: FilterTabs(currentFilter: state.filter),
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
                SliverToBoxAdapter(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    child: state.filteredQueue.isEmpty
                        ? const EmptyState(
                            key: ValueKey('empty_state'),
                            message: 'No active patients in queue',
                          )
                        : const SizedBox(key: ValueKey('list_state')),
                  ),
                ),

                // ── active queue list ────────────────────────────
                if (state.filteredQueue.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final record = state.filteredQueue[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                        child: PatientCard(
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
                        child: PatientCard(
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
