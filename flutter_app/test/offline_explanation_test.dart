import 'package:flutter_test/flutter_test.dart';
import 'package:maternal_triage/models/patient_record.dart';
import 'package:maternal_triage/services/offline_explanation.dart';

PatientRecord rec({double sbp = 118, double dbp = 76}) => PatientRecord(
      age: 28,
      systolicBP: sbp,
      diastolicBP: dbp,
      bloodSugar: 6.5,
      bodyTemp: 98.0,
      heartRate: 78,
      createdAt: DateTime(2026),
    );

void main() {
  test('no prompt for clear readings far from the threshold', () {
    expect(measurementAdvisory(rec(), 0.05, 0.805), isNull);
  });

  test('prompts when blood pressure is near 140/90', () {
    expect(measurementAdvisory(rec(sbp: 138), 0.05, 0.805), contains('140/90'));
    expect(measurementAdvisory(rec(dbp: 92), 0.05, 0.805), contains('140/90'));
  });

  test('prompts when the risk score is near the decision threshold', () {
    expect(measurementAdvisory(rec(), 0.75, 0.805), contains('decision threshold'));
    expect(measurementAdvisory(rec(), 0.95, 0.805), isNull);
  });
}
