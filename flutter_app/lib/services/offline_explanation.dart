import 'package:maternal_triage/models/patient_record.dart';
import 'package:maternal_triage/models/risk_result.dart';

const _labels = {
  'Age': 'maternal age',
  'SystolicBP': 'systolic blood pressure',
  'DiastolicBP': 'diastolic blood pressure',
  'BloodSugar': 'blood sugar',
  'BodyTemp': 'body temperature',
  'BMI': 'BMI',
  'HeartRate': 'heart rate',
  'Weight': 'weight',
  'Height': 'height',
  'PreviousComplications': 'previous pregnancy complications',
  'PreexistingDiabetes': 'pre-existing diabetes',
  'GestationalDiabetes': 'gestational diabetes',
  'PulsePressure': 'pulse pressure',
  'ShockIndex': 'shock index (heart rate / systolic BP)',
  'MAP': 'mean arterial pressure',
  'HypertensionFlag': 'raised blood pressure',
  'TachycardiaFlag': 'fast heart rate',
  'DiabetesRisk': 'diabetes-adjusted blood sugar',
  'AgeRiskFlag': 'age outside 18-35',
};

/// Plain-language explanation built on-device from the patient's own SHAP
/// factors, so no patient data leaves the device.
/// Prompt to repeat measurements when the result could change with ordinary
/// measurement error: blood pressure near the 140/90 mmHg cut-off, or a risk
/// score close to the decision threshold. Null when no repeat is needed.
String? measurementAdvisory(PatientRecord record, double? pHigh, double threshold) {
  final reasons = <String>[
    if ((record.systolicBP >= 135 && record.systolicBP < 145) ||
        (record.diastolicBP >= 85 && record.diastolicBP < 95))
      'blood pressure is close to the 140/90 mmHg cut-off',
    if (pHigh != null && (pHigh - threshold).abs() <= 0.1)
      'the risk score is close to the decision threshold',
  ];
  if (reasons.isEmpty) return null;
  return 'Borderline result: ${reasons.join(' and ')}. Repeat the blood pressure '
      'reading after the patient has rested for 5 minutes, recheck blood sugar, '
      'and run the assessment again.';
}

String buildOfflineExplanation(PatientRecord record, RiskResult result, {double threshold = 0.5}) {
  final high = result.riskLabel == 'High';
  final pHigh = result.probabilities.length == 2 ? result.probabilities[1] : null;
  final buffer = StringBuffer()
    ..write('The model assessed this patient as ${result.riskLabel.toUpperCase()} risk')
    ..writeln(pHigh == null ? '.' : ' (estimated probability of high risk: ${(pHigh * 100).round()}%).');

  final factors = result.shapFeatures.take(3).toList();
  if (factors.isNotEmpty) {
    buffer.writeln('\nMain factors for this patient:');
    for (final f in factors) {
      final name = _labels[f.featureName] ?? f.featureName;
      final direction = f.isPositive ? 'raised' : 'lowered';
      buffer.writeln('• $name $direction the risk estimate');
    }
  }

  final advisory = measurementAdvisory(record, pHigh, threshold);
  if (advisory != null) buffer.writeln('\n$advisory');

  if (record.blurredVision || record.vaginalBleeding) {
    buffer.writeln('\nDanger sign recorded '
        '(${[if (record.blurredVision) 'blurred vision', if (record.vaginalBleeding) 'vaginal bleeding'].join(', ')}): '
        'refer according to local protocol regardless of the model result.');
  }

  buffer.writeln(high
      ? '\nSuggested action: refer to a facility with emergency obstetric care and recheck vital signs.'
      : '\nSuggested action: continue routine antenatal care and reassess at the next visit or if danger signs appear.');
  buffer.write('This is decision support only; final decisions rest with the health worker.');
  return buffer.toString();
}
