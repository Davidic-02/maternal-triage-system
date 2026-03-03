import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/patient_record.dart';
import '../providers/assessment_provider.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';

/// Data-entry form for the 11 clinical features required for triage assessment.
class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({super.key});

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers for numeric fields
  final _ageCtrl = TextEditingController();
  final _sysCtrl = TextEditingController();
  final _diasCtrl = TextEditingController();
  final _bsCtrl = TextEditingController();
  final _tempCtrl = TextEditingController();
  final _hrCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();

  // Boolean toggles
  bool _prevComp = false;
  bool _preDiab = false;
  bool _gestDiab = false;

  // Dropdown
  String _mentalHealth = 'none';

  @override
  void dispose() {
    for (final c in [
      _ageCtrl, _sysCtrl, _diasCtrl, _bsCtrl,
      _tempCtrl, _hrCtrl, _weightCtrl, _heightCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final record = PatientRecord(
      age: double.parse(_ageCtrl.text),
      systolicBP: double.parse(_sysCtrl.text),
      diastolicBP: double.parse(_diasCtrl.text),
      bloodSugar: double.parse(_bsCtrl.text),
      bodyTemp: double.parse(_tempCtrl.text),
      heartRate: double.parse(_hrCtrl.text),
      weight: _weightCtrl.text.isNotEmpty ? double.tryParse(_weightCtrl.text) : null,
      height: _heightCtrl.text.isNotEmpty ? double.tryParse(_heightCtrl.text) : null,
      previousComplications: _prevComp,
      preexistingDiabetes: _preDiab,
      gestationalDiabetes: _gestDiab,
      mentalHealthStatus: _mentalHealth,
      createdAt: DateTime.now(),
    );

    await context.read<AssessmentProvider>().runAssessment(record);
    if (mounted) context.push('/result');
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AssessmentProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Assessment'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _sectionTitle('Vital Signs'),
              _numericField('Age (years)', _ageCtrl, Validators.validateAge),
              _numericField('Systolic BP (mmHg)', _sysCtrl, Validators.validateSystolicBP),
              _numericField('Diastolic BP (mmHg)', _diasCtrl, Validators.validateDiastolicBP),
              _numericField('Blood Sugar (mmol/L)', _bsCtrl, Validators.validateBloodSugar),
              _numericField('Body Temperature (°F)', _tempCtrl, Validators.validateBodyTemp),
              _numericField('Heart Rate (bpm)', _hrCtrl, Validators.validateHeartRate),
              _sectionTitle('Anthropometrics (optional)'),
              _numericField('Weight (kg)', _weightCtrl, Validators.validateWeight),
              _numericField('Height (m)', _heightCtrl, Validators.validateHeight),
              _sectionTitle('Clinical History'),
              _toggleRow('Previous Complications', _prevComp,
                  (v) => setState(() => _prevComp = v)),
              _toggleRow('Preexisting Diabetes', _preDiab,
                  (v) => setState(() => _preDiab = v)),
              _toggleRow('Gestational Diabetes', _gestDiab,
                  (v) => setState(() => _gestDiab = v)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _mentalHealth,
                decoration: const InputDecoration(
                  labelText: 'Mental Health Status',
                  border: OutlineInputBorder(),
                ),
                items: kMentalHealthOptions
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) => setState(() => _mentalHealth = v ?? 'none'),
              ),
              const SizedBox(height: 24),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: const Text('Run Assessment'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Text(title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      );

  Widget _numericField(
    String label,
    TextEditingController controller,
    String? Function(String?) validator,
  ) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: validator,
        ),
      );

  Widget _toggleRow(String label, bool value, ValueChanged<bool> onChanged) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Switch(value: value, onChanged: onChanged, activeColor: Colors.teal),
          ],
        ),
      );
}
