import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/assessment_provider.dart';
import '../widgets/risk_badge.dart';
import '../widgets/shap_chart.dart';

/// Result screen displaying the triage risk level, recommended action,
/// and top SHAP feature contributions.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AssessmentProvider>();
    final result = provider.currentResult;

    if (result == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Result')),
        body: const Center(child: Text('No result available.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Result'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Risk level badge
            Center(child: RiskBadge(label: result.riskLabel)),
            const SizedBox(height: 24),
            // Class probabilities
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Class Probabilities',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...['Low', 'Mid', 'High'].asMap().entries.map((e) {
                      final pct = result.probabilities.length > e.key
                          ? (result.probabilities[e.key] * 100).toStringAsFixed(1)
                          : '—';
                      return Text('${e.value}: $pct%');
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Recommended action
            Card(
              color: Colors.teal.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Recommended Action',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(result.recommendedAction),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // SHAP chart
            if (result.shapFeatures.isNotEmpty) ...[
              const Text('Top Contributing Features',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SizedBox(
                height: 260,
                child: ShapChart(features: result.shapFeatures),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
