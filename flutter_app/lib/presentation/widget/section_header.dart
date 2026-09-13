import 'package:flutter/material.dart';
import 'package:maternal_triage/constant/app_spacing.dart';

class SectionHeader extends StatelessWidget {
  final String number;
  final String title;
  final Color color;

  const SectionHeader({
    required this.number,
    required this.title,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: color,
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        AppSpacing.horizontalSpaceSmall,
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: color,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
