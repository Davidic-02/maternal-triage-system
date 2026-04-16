// lib/presentation/widget/guide_row_item.dart
import 'package:flutter/material.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/models/education_content.dart';
import 'package:url_launcher/url_launcher.dart';

class GuideRowItem extends StatelessWidget {
  final EducationGuide guide;
  final bool showDivider;

  const GuideRowItem({super.key, required this.guide, this.showDivider = true});

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
        return AppColors.accentGreen.withOpacity(0.1);
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
        return AppColors.accentGreen;
      default:
        return AppColors.greyColor;
    }
  }

  void _launchGuide() {
    if (guide.url.isNotEmpty) {
      launchUrl(Uri.parse(guide.url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: _launchGuide,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Icon container
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
                // Title + Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        guide.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      AppSpacing.verticalSpaceTiny,
                      Text(
                        guide.subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Download button
                GestureDetector(
                  onTap: _launchGuide,
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
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 20,
            endIndent: 20,
            color: AppColors.greyColor.withOpacity(0.15),
          ),
      ],
    );
  }
}
