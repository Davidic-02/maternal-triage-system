import 'package:flutter/material.dart';
import 'package:maternal_triage/constant/app_colors.dart';

class HistoryToggle extends StatelessWidget {
  final String label;
  final bool value;
  final VoidCallback onToggle;

  const HistoryToggle({
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
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Switch(
            value: value,
            onChanged: (_) => onToggle(),
            activeThumbColor: AppColors.primaryGreen,
          ),
        ],
      ),
    );
  }
}
