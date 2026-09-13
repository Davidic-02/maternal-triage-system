// lib/presentation/screens/resources_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/education.dart/education_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/enums/education_enum.dart';
import 'package:maternal_triage/presentation/widget/custom_text_form_field.dart';
import 'package:maternal_triage/presentation/widget/custom_top_bar.dart';
import 'package:maternal_triage/presentation/widget/empty_state.dart';
import 'package:maternal_triage/presentation/widget/featured_video_card.dart';
import 'package:maternal_triage/presentation/widget/guide_row_item.dart';
import 'package:maternal_triage/presentation/widget/text_title.dart';
import 'package:maternal_triage/presentation/widget/video_card.dart';

class EducationalLibraryScreen extends HookWidget {
  const EducationalLibraryScreen({super.key});
  static const routeName = '/resources';

  static const _tabs = [
    ('first', '1st Tri'),
    ('second', '2nd Tri'),
    ('third', '3rd Trimester'),
    ('postpartum', 'Postpartum'),
  ];

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final searchFocus = useFocusNode();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomTopBar(
              title: 'Educational Library',
              onTap: () => context.go('/triage'),
            ),
            Expanded(
              child: BlocBuilder<EducationBloc, EducationState>(
                builder: (context, state) {
                  return RefreshIndicator(
                    color: AppColors.primaryGreen,
                    onRefresh: () async => context.read<EducationBloc>().add(
                      const EducationEvent.refresh(),
                    ),
                    child: _buildContent(
                      context,
                      state,
                      searchController,
                      searchFocus,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    EducationState state,
    TextEditingController searchController,
    FocusNode searchFocus,
  ) {
    // LOADING STATE
    if (state.status == EducationStatus.loading && state.allVideos.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryGreen),
      );
    }

    // ERROR STATE
    if (state.status == EducationStatus.error && state.allVideos.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EmptyState(message: 'Could not load content'),
            AppSpacing.verticalSpaceMedium,
            const Text(
              'Check your connection and try again',
              style: TextStyle(color: AppColors.textGrey, fontSize: 13),
            ),
            AppSpacing.verticalSpaceMedium,
            TextButton.icon(
              onPressed: () => context.read<EducationBloc>().add(
                const EducationEvent.refresh(),
              ),
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Try again'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryGreen,
              ),
            ),
          ],
        ),
      );
    }

    // SUCCESS STATE
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        AppSpacing.verticalSpaceSmall,

        // ── Search Bar ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomTextFormField(
            controller: searchController,
            focusNode: searchFocus,
            hintText: 'Search nutrition, signs',
            keyboardType: TextInputType.text,
            onChanged: (q) => context.read<EducationBloc>().add(
              EducationEvent.searchChanged(q),
            ),
          ),
        ),
        AppSpacing.verticalSpaceMedium,

        // ── Trimester Tabs ──
        Row(
          children: _tabs.map((tab) {
            final isSelected = state.selectedTab == tab.$1;
            return Expanded(
              child: GestureDetector(
                onTap: () => context.read<EducationBloc>().add(
                  EducationEvent.tabChanged(tab.$1),
                ),
                child: Column(
                  children: [
                    Text(
                      tab.$2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected
                            ? AppColors.primaryGreen
                            : AppColors.textGrey,
                      ),
                    ),
                    AppSpacing.verticalSpaceTiny,
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 2,
                      width: isSelected ? tab.$2.length * 7.5 : 0,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        AppSpacing.verticalSpaceLarge,

        // ── Conditional: Search or Recommended ──
        if (state.searchQuery.isEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextTitle(text: 'Recommended for you'),
          ),
          AppSpacing.verticalSpaceMedium,
          if (state.featuredVideos.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: EmptyState(message: 'No featured video available'),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FeaturedVideoCard(video: state.featuredVideos.first),
            ),
          const SizedBox(height: 28),
          if (state.sectionVideos.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextTitle(text: 'Birth Preparedness'),
            ),
            AppSpacing.verticalSpaceMedium,
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: state.sectionVideos.length,
                itemBuilder: (_, i) => VideoCard(video: state.sectionVideos[i]),
              ),
            ),
            const SizedBox(height: 28),
          ],
        ] else ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextTitle(text: 'Search Results'),
          ),
          AppSpacing.verticalSpaceSmall,
          if (state.filteredVideos.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: EmptyState(
                message: 'No results for "${state.searchQuery}"',
              ),
            )
          else
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: state.filteredVideos.length,
                itemBuilder: (_, i) =>
                    VideoCard(video: state.filteredVideos[i]),
              ),
            ),
          const SizedBox(height: 28),
        ],

        // ── Illustrated Guides ──
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextTitle(text: 'Illustrated Guides'),
        ),
        AppSpacing.verticalSpaceSmall,
        if (state.filteredGuides.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: EmptyState(message: 'No guides found'),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: List.generate(state.filteredGuides.length, (i) {
                    final isLast = i == state.filteredGuides.length - 1;
                    return GuideRowItem(
                      guide: state.filteredGuides[i],
                      showDivider: !isLast,
                    );
                  }),
                ),
              ),
            ),
          ),
        const SizedBox(height: 32),
      ],
    );
  }
}
