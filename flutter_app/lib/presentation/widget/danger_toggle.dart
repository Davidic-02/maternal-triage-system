import 'package:flutter/material.dart';
import 'package:maternal_triage/constant/app_colors.dart';

class DangerToggle extends StatelessWidget {
  final String label;
  final bool value;
  final VoidCallback onToggle;

  const DangerToggle({
    required this.label,
    required this.value,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: value ? AppColors.danger : null,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: (_) => onToggle(),
            activeColor: AppColors.danger,
          ),
        ],
      ),
    );
  }
}
