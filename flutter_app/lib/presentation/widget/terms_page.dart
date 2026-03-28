import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  final bool accepted;
  final ValueChanged<bool> onAccepted;

  const TermsPage({
    super.key,
    required this.accepted,
    required this.onAccepted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const Text(
            'Terms & Conditions',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Expanded(
            child: SingleChildScrollView(
              child: Text(
                'This application is intended for use by licensed medical '
                'professionals only.\n\n'
                'The AI risk assessment is a clinical decision support tool '
                'and does not replace clinical judgement. Always apply '
                'professional expertise when interpreting results.\n\n'
                'Patient data is stored securely on Firebase and is subject '
                'to your institution\'s data protection policies.\n\n'
                'By using this app you confirm you are a licensed healthcare '
                'professional and agree to use this tool responsibly.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
          ),
          Row(
            children: [
              Checkbox(
                activeColor: Colors.green,
                value: accepted,
                onChanged: (val) => onAccepted(val ?? false),
              ),
              const Expanded(
                child: Text(
                  'I have read and agree to the Terms & Conditions',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
