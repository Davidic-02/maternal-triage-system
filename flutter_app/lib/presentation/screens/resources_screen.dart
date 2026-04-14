import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maternal_triage/bloc/education.dart/education_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/enums/education_enum.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maternal_triage/models/education_content.dart';

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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: BlocBuilder<EducationBloc, EducationState>(
                builder: (context, state) {
                  return RefreshIndicator(
                    color: AppColors.primaryGreen,
                    onRefresh: () async => context.read<EducationBloc>().add(
                      const EducationEvent.refresh(),
                    ),
                    child: _buildBody(context, state, searchController),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 16),
            ),
          ),
          const Expanded(
            child: Text(
              'Educational Library',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowColor,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.bookmark_border, size: 18),
          ),
        ],
      ),
    );
  }

  // ── Body ─────────────────────────────────────────────────────

  Widget _buildBody(
    BuildContext context,
    EducationState state,
    TextEditingController searchController,
  ) {
    if (state.status == EducationStatus.loading && state.allVideos.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryGreen),
      );
    }

    if (state.status == EducationStatus.error && state.allVideos.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              color: AppColors.greyColor.withOpacity(0.4),
              size: 48,
            ),
            AppSpacing.verticalSpaceMedium,
            const Text(
              'Could not load content',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            AppSpacing.verticalSpaceTiny,
            const Text(
              'Check your connection and try again',
              style: TextStyle(color: AppColors.greyColor, fontSize: 13),
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

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        AppSpacing.verticalSpaceSmall,
        _buildSearchBar(context, searchController),
        AppSpacing.verticalSpaceMedium,
        _buildTrimesterTabs(context, state),
        AppSpacing.verticalSpaceLarge,
        if (state.searchQuery.isEmpty) ...[
          _buildSectionLabel('Recommended for you'),
          AppSpacing.verticalSpaceSmall,
          _buildFeaturedVideo(state),
          const SizedBox(height: 28),
          if (state.sectionVideos.isNotEmpty) ...[
            _buildSectionLabel('Birth Preparedness'),
            AppSpacing.verticalSpaceSmall,
            _buildBirthPrepRow(state),
            const SizedBox(height: 28),
          ],
        ] else ...[
          _buildSectionLabel('Search Results'),
          AppSpacing.verticalSpaceSmall,
          _buildSearchResults(state),
          const SizedBox(height: 28),
        ],
        _buildSectionLabel('Illustrated Guides'),
        AppSpacing.verticalSpaceSmall,
        _buildGuidesList(context, state),
        const SizedBox(height: 32),
      ],
    );
  }

  // ── Search Bar ───────────────────────────────────────────────

  Widget _buildSearchBar(
    BuildContext context,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        onChanged: (q) =>
            context.read<EducationBloc>().add(EducationEvent.searchChanged(q)),
        decoration: InputDecoration(
          hintText: 'Search nutrition, signs',
          suffixIcon: const Icon(
            Icons.search,
            color: AppColors.greyColor,
            size: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.primaryGreen,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  // ── Trimester Tabs ───────────────────────────────────────────

  Widget _buildTrimesterTabs(BuildContext context, EducationState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _tabs.map((tab) {
            final isSelected = state.selectedTab == tab.$1;
            return GestureDetector(
              onTap: () => context.read<EducationBloc>().add(
                EducationEvent.tabChanged(tab.$1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    Text(
                      tab.$2,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected
                            ? AppColors.primaryGreen
                            : AppColors.greyColor,
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
      ),
    );
  }

  // ── Section Label ────────────────────────────────────────────

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // ── Featured Video ───────────────────────────────────────────

  Widget _buildFeaturedVideo(EducationState state) {
    if (state.featuredVideos.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.primaryGreen.withOpacity(0.06),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Center(
            child: Text(
              'No featured video available',
              style: TextStyle(color: AppColors.greyColor),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _FeaturedVideoCard(video: state.featuredVideos.first),
    );
  }

  // ── Birth Prep Row ───────────────────────────────────────────

  Widget _buildBirthPrepRow(EducationState state) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: state.sectionVideos.length,
        itemBuilder: (_, i) => _VideoCard(video: state.sectionVideos[i]),
      ),
    );
  }

  // ── Search Results ───────────────────────────────────────────

  Widget _buildSearchResults(EducationState state) {
    final videos = state.filteredVideos;
    if (videos.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'No results for "${state.searchQuery}"',
          style: const TextStyle(color: AppColors.greyColor, fontSize: 14),
        ),
      );
    }
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: videos.length,
        itemBuilder: (_, i) => _VideoCard(video: videos[i]),
      ),
    );
  }

  // ── Guides List ──────────────────────────────────────────────

  Widget _buildGuidesList(BuildContext context, EducationState state) {
    final guides = state.filteredGuides;
    if (guides.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'No guides found',
          style: TextStyle(color: AppColors.greyColor),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: List.generate(guides.length, (i) {
            final isLast = i == guides.length - 1;
            return Column(
              children: [
                _GuideRow(guide: guides[i]),
                if (!isLast)
                  Divider(
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                    color: AppColors.greyColor.withOpacity(0.15),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

// ── Featured Video Card ───────────────────────────────────────

class _FeaturedVideoCard extends StatelessWidget {
  final EducationVideo video;
  const _FeaturedVideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrl(
        Uri.parse('https://www.youtube.com/watch?v=${video.youtubeVideoId}'),
        mode: LaunchMode.externalApplication,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.network(
                video.thumbnailUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.primaryGreen.withOpacity(0.08),
                  child: const Icon(
                    Icons.play_circle_outline,
                    size: 48,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
            ),
            // gradient overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.72),
                    ],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
            ),
            // play button
            Positioned.fill(
              child: Center(
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow_rounded, size: 30),
                ),
              ),
            ),
            // title + duration
            Positioned(
              left: 16,
              right: 16,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (video.duration.isNotEmpty)
                    Text(
                      '${video.subtitle} · ${video.duration}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Small Video Card ──────────────────────────────────────────

class _VideoCard extends StatelessWidget {
  final EducationVideo video;
  const _VideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: SizedBox(
        width: 170,
        child: GestureDetector(
          onTap: () => launchUrl(
            Uri.parse(
              'https://www.youtube.com/watch?v=${video.youtubeVideoId}',
            ),
            mode: LaunchMode.externalApplication,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Image.network(
                        video.thumbnailUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.primaryGreen.withOpacity(0.08),
                          child: const Icon(
                            Icons.play_circle_outline,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.12),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalSpaceSmall,
              Text(
                video.title,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              AppSpacing.verticalSpaceTiny,
              Text(
                video.subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Guide Row ─────────────────────────────────────────────────

class _GuideRow extends StatelessWidget {
  final EducationGuide guide;
  const _GuideRow({required this.guide});

  IconData get _icon {
    switch (guide.category) {
      case 'nutrition':
        return Icons.restaurant_outlined;
      case 'warning':
        return Icons.warning_amber_rounded;
      case 'birth':
        return Icons.article_outlined;
      default:
        return Icons.health_and_safety_outlined;
    }
  }

  Color get _iconBg {
    switch (guide.category) {
      case 'nutrition':
        return AppColors.primaryGreen.withOpacity(0.1);
      case 'warning':
        return AppColors.danger.withOpacity(0.1);
      case 'birth':
        return AppColors.secondaryColor.withOpacity(0.1);
      default:
        return AppColors.greyColor.withOpacity(0.1);
    }
  }

  Color get _iconColor {
    switch (guide.category) {
      case 'nutrition':
        return AppColors.primaryGreen;
      case 'warning':
        return AppColors.danger;
      case 'birth':
        return AppColors.secondaryColor;
      default:
        return AppColors.greyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (guide.url.isNotEmpty) {
          launchUrl(Uri.parse(guide.url), mode: LaunchMode.externalApplication);
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // icon
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: _iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_icon, color: _iconColor, size: 22),
            ),
            AppSpacing.horizontalSpaceMedium,
            // title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    guide.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.verticalSpaceTiny,
                  Text(
                    guide.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
            ),
            // download button
            GestureDetector(
              onTap: () {
                if (guide.url.isNotEmpty) {
                  launchUrl(
                    Uri.parse(guide.url),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.primaryGreen.withOpacity(0.2),
                  ),
                ),
                child: const Icon(
                  Icons.download_outlined,
                  size: 18,
                  color: AppColors.primaryGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
