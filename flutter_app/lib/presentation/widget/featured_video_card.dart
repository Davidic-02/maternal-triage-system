// lib/presentation/widget/featured_video_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maternal_triage/bloc/education.dart/education_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/models/education_content.dart';

class FeaturedVideoCard extends StatelessWidget {
  final EducationVideo video;

  const FeaturedVideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<EducationBloc>().add(
        EducationEvent.videoTapped(video.youtubeVideoId),
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
            // Gradient overlay
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
            // Play button
            Positioned.fill(
              child: Center(
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    size: 30,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ),
            // Title + duration
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
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (video.duration.isNotEmpty)
                    Text(
                      '${video.subtitle} · ${video.duration}',
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.85),
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
