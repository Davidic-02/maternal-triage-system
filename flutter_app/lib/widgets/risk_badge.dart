import 'package:flutter/material.dart';

/// Colored badge widget that displays the risk level (Low / Mid / High).
class RiskBadge extends StatelessWidget {
  final String label;

  const RiskBadge({super.key, required this.label});

  Color get _color {
    switch (label.toLowerCase()) {
      case 'low':
        return Colors.green;
      case 'mid':
        return Colors.amber;
      case 'high':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
