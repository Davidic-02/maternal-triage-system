// lib/presentation/widget/video_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maternal_triage/bloc/education.dart/education_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/models/education_content.dart';

class VideoCard extends StatelessWidget {
  final EducationVideo video;
  final double width;

  const VideoCard({super.key, required this.video, this.width = 170});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: SizedBox(
        width: width,
        child: GestureDetector(
          onTap: () => context.read<EducationBloc>().add(
            EducationEvent.videoTapped(video.youtubeVideoId),
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
                          color: AppColors.white,
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
                  color: AppColors.textDark,
                ),
              ),
              AppSpacing.verticalSpaceTiny,
              Text(
                video.subtitle,
                style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
