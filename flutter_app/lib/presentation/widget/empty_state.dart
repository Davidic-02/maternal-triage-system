import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/constant/app_colors.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  const EmptyState({required this.message, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Lottie.asset(
            'assets/animations/No_Data.json',
            height: 180,
            repeat: true,
            animate: true,
            frameRate: FrameRate.max,
          ),
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
