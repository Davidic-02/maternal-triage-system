import 'package:flutter/material.dart';
import 'package:maternal_triage/constant/app_colors.dart';

Color riskColor(int riskClass) {
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

IconData riskIcon(int riskClass) {
  switch (riskClass) {
    case 2:
      return Icons.emergency_rounded;
    case 1:
      return Icons.warning_amber_rounded;
    case 0:
      return Icons.check_circle_rounded;
    default:
      return Icons.help_outline;
  }
}
