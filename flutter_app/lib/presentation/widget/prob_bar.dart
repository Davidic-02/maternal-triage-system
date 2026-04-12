import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';

class ProbBar extends HookWidget {
  final String label;
  final double value;
  final Color color;
  final bool isSelected;

  const ProbBar({
    required this.label,
    required this.value,
    required this.color,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );
    final animation = useAnimation(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );

    useEffect(() {
      controller.forward();
      return null;
    }, const []);

    final pct = (value * 100).toStringAsFixed(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected ? color : null,
              ),
            ),
            const Spacer(),
            Text(
              '$pct%',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? color : AppColors.greyColor,
              ),
            ),
          ],
        ),
        AppSpacing.verticalSpaceTiny,
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value * animation,
            minHeight: 8,
            backgroundColor: color.withOpacity(0.12),
            valueColor: AlwaysStoppedAnimation<Color>(
              isSelected ? color : color.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
