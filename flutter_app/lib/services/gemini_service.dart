import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maternal_triage/models/patient_record.dart';
import 'package:maternal_triage/models/risk_result.dart';

class GeminiService {
  static const _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';
  final String _apiKey;

  GeminiService({required String apiKey}) : _apiKey = apiKey;

  Future<String> generateClinicalExplanation({
    required PatientRecord record,
    required RiskResult result,
  }) async {
    final prompt = _buildPrompt(record, result);

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json', 'X-Goog-Api-Key': _apiKey},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt},
            ],
          },
        ],
        'generationConfig': {'temperature': 0.4, 'maxOutputTokens': 500},
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Gemini API error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final text = data['candidates'][0]['content']['parts'][0]['text'] as String;

    _validateExplanationAlignment(text, result.riskLabel);

    return text.trim();
  }

  String _buildPrompt(PatientRecord record, RiskResult result) {
    // Extract top SHAP features
    final shapContext = result.shapFeatures
        .take(3)
        .map((f) => '${f.featureName}: SHAP=${f.shapValue.toStringAsFixed(3)}')
        .join(', ');

    return '''
You are a clinical AI assistant explaining a maternal triage assessment result 
to a frontline healthcare worker in a conversational, clear way.

⚠️ IMPORTANT DIRECTIVE:
The AI model has determined this patient is at: ${result.riskLabel} RISK
Model confidence: ${(result.probabilities[result.riskClass] * 100).toStringAsFixed(1)}%

Your role is to EXPLAIN the clinical reasoning behind this assessment.
Do NOT question, contradict, or re-evaluate the risk level.
You are providing context, not a second opinion.

Patient Details:
- Age: ${record.age.toInt()} years
- Gestational age: ${record.gestationalAge?.toInt() ?? 'unknown'} weeks
- Systolic BP: ${record.systolicBP.toInt()} mmHg
- Diastolic BP: ${record.diastolicBP.toInt()} mmHg  
- Heart Rate: ${record.heartRate.toInt()} bpm
- Blood Sugar: ${record.bloodSugar.toStringAsFixed(1)} mmol/L
- Body Temperature: ${record.bodyTemp.toStringAsFixed(1)} °C
${record.weight != null ? '- Weight: ${record.weight!.toStringAsFixed(1)} kg' : ''}
${record.bmi != null ? '- BMI: ${record.bmi!.toStringAsFixed(1)}' : ''}
- Pulse Pressure: ${record.pulsePressure.toStringAsFixed(0)} mmHg
- Previous Complications: ${record.previousComplications ? 'Yes' : 'No'}
- Preexisting Diabetes: ${record.preexistingDiabetes ? 'Yes' : 'No'}
- Gestational Diabetes: ${record.gestationalDiabetes ? 'Yes' : 'No'}
- Hypertension: ${record.hypertension ? 'Yes' : 'No'}
- Mental Health Status: ${record.mentalHealthStatus}
${record.blurredVision ? '- ⚠️ DANGER SIGN: Blurred Vision/Headache present' : ''}
${record.vaginalBleeding ? '- ⚠️ DANGER SIGN: Vaginal Bleeding present' : ''}
${record.severeSwelling ? '- ⚠️ DANGER SIGN: Severe Swelling present' : ''}
${record.reducedFetalMovement ? '- ⚠️ DANGER SIGN: Reduced Fetal Movement present' : ''}

Key Factors Driving This Assessment (Model Analysis):
$shapContext

TASK:
In 3-4 short paragraphs, explain:
1. What the key clinical findings mean
2. Why these findings led to a ${result.riskLabel} risk assessment
3. What the healthcare worker should prioritize monitoring or action items

Write conversationally like a knowledgeable colleague.
Use actual values from the patient data.
Avoid jargon where possible.
Do NOT use bullet points or markdown — write in plain flowing paragraphs.
''';
  }

  void _validateExplanationAlignment(
    String explanation,
    String modelRiskLabel,
  ) {
    final lowerExplanation = explanation.toLowerCase();

    // Check for contradictions with model prediction
    if (modelRiskLabel == 'HIGH') {
      if (lowerExplanation.contains('low risk') ||
          lowerExplanation.contains('not at risk') ||
          lowerExplanation.contains('minimal risk')) {
        _logWarning(
          'Gemini explanation may contradict model prediction (Model: HIGH, Explanation suggests: LOW)',
        );
      }
    }

    if (modelRiskLabel == 'MEDIUM') {
      if ((lowerExplanation.contains('critical') ||
              lowerExplanation.contains('life-threatening')) &&
          !lowerExplanation.contains('could')) {
        _logWarning(
          'Gemini explanation escalates risk beyond model assessment (Model: MEDIUM, Explanation: HIGH)',
        );
      }
    }

    if (modelRiskLabel == 'LOW') {
      if (lowerExplanation.contains('high risk') ||
          lowerExplanation.contains('critical') ||
          lowerExplanation.contains('urgent attention')) {
        _logWarning(
          'Gemini explanation contradicts model prediction (Model: LOW, Explanation suggests: HIGH)',
        );
      }
    }
  }

  void _logWarning(String message) {
    // Replace with your actual logging service
    print('⚠️ GeminiService Warning: $message');
    // In production, you'd send this to Crashlytics or your logging service
  }
}
