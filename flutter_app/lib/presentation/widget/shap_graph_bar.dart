import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/models/risk_result.dart';

class ShapGraphBar extends HookWidget {
  final ShapFeature feature;
  const ShapGraphBar({required this.feature, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );
    final animation = useAnimation(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );

    useEffect(() {
      controller.forward();
      return null;
    }, const []);

    final isPositive = feature.isPositive;
    final color = isPositive ? AppColors.danger : AppColors.accentGreen;
    final absValue = feature.shapValue.abs();
    final displayValue = absValue.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Feature name + value
        Row(
          children: [
            Expanded(
              child: Text(
                _formatFeatureName(feature.featureName),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${isPositive ? '+' : '-'}${absValue.toStringAsFixed(3)}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ],
        ),

        AppSpacing.verticalSpaceSmall,

        // Horizontal bar graph
        Row(
          children: [
            // Negative bar (green, left side)
            Expanded(
              child: isPositive
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: FractionallySizedBox(
                        widthFactor: displayValue * animation,
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),

            // Center divider line
            Container(
              width: 2,
              height: 14,
              color: AppColors.greyColor.withOpacity(0.3),
            ),

            // Positive bar (red, right side)
            Expanded(
              child: isPositive
                  ? FractionallySizedBox(
                      widthFactor: displayValue * animation,
                      child: Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),

        // Direction indicator
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              Text(
                isPositive ? 'Increases risk' : 'Decreases risk',
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatFeatureName(String name) {
    return name
        .replaceAll('_', ' ')
        .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(0)}')
        .trim()
        .split(' ')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}
