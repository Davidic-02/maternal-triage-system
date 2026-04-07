import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maternal_triage/models/patient_record.dart';
import 'package:maternal_triage/models/risk_result.dart';

class GeminiService {
  static const _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';
  final String _apiKey;

  GeminiService({required String apiKey}) : _apiKey = apiKey;

  String _buildPrompt(PatientRecord record, RiskResult result) {
    final shapContext = result.shapFeatures
        .take(3)
        .map((f) => '${f.featureName} (+${f.shapValue.toStringAsFixed(2)})')
        .join(', ');

    return '''
Explain why this maternal patient is classified as ${result.riskLabel} risk.

Vitals:
SBP: ${record.systolicBP.toInt()} | DBP: ${record.diastolicBP.toInt()} | HR: ${record.heartRate.toInt()} | Sugar: ${record.bloodSugar.toStringAsFixed(1)} | Temp: ${record.bodyTemp.toStringAsFixed(1)}
Age: ${record.age.toInt()} | GA: ${record.gestationalAge?.toInt() ?? 'N/A'} weeks
${record.blurredVision ? 'Danger: Blurred Vision' : ''}
${record.vaginalBleeding ? 'Danger: Vaginal Bleeding' : ''}

Top factors: $shapContext

In 2-9 lines, explain the clinical reasoning. Be conversational, direct. Speak like a colleague explaining to another doctor.
''';
  }

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
        'generationConfig': {
          'temperature': 0.4,
          'maxOutputTokens': 2028, // ← INCREASED from 500 to 1024
        },
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Gemini API error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final text = data['candidates'][0]['content']['parts'][0]['text'] as String;
    print('📝 Gemini response length: ${text.length} characters');
    print('📝 Full response:\n$text');
    print('📝 Usage: ${data['usageMetadata']}');

    _validateExplanationAlignment(text, result.riskLabel);

    return text.trim();
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
