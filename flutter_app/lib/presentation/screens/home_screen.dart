import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/patient_record.dart';
import '../../providers/assessment_provider.dart';

/// Home screen with a welcome message, "New Assessment" button, and recent records.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AssessmentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maternal Triage'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Welcome banner
          Container(
            color: Colors.teal.shade50,
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Welcome, Clinician',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 16),
          // New Assessment button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                provider.clearAssessment();
                context.push('/assessment');
              },
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('New Assessment'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Recent Assessments',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.recentRecords.isEmpty
                    ? const Center(child: Text('No assessments yet'))
                    : ListView.builder(
                        itemCount: provider.recentRecords.length,
                        itemBuilder: (ctx, i) =>
                            _RecordTile(record: provider.recentRecords[i]),
                      ),
          ),
        ],
      ),
    );
  }
}

class _RecordTile extends StatelessWidget {
  final PatientRecord record;

  const _RecordTile({required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.teal),
        title: Text(
            'Age ${record.age.toStringAsFixed(0)} · BP ${record.systolicBP.toStringAsFixed(0)}/${record.diastolicBP.toStringAsFixed(0)}'),
        subtitle: Text(
          record.createdAt.toLocal().toString().split('.').first,
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
