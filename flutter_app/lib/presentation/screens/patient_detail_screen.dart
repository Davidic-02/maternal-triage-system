import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PatientDetailScreen extends HookWidget {
  final String patientId;

  const PatientDetailScreen({
    super.key,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context) {
    // 🟢 Hook states
    final isLoading = useState(true);
    final patientData = useState<Map<String, dynamic>?>(null);

    // 🟢 Simulate fetching data (later this will be Firestore)
    useEffect(() {
      Future.delayed(const Duration(seconds: 2), () {
        patientData.value = {
          'name': 'Jane Doe',
          'age': 28,
          'id': patientId,
          'bloodPressure': '120/80',
          'temperature': '36.8°C',
        };

        isLoading.value = false;
      });

      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : patientData.value == null
                ? const Center(child: Text('No data found'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patientData.value!['name'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Age: ${patientData.value!['age']}'),
                      Text('Patient ID: ${patientData.value!['id']}'),
                      const SizedBox(height: 20),
                      const Text(
                        'Vitals',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('BP: ${patientData.value!['bloodPressure']}'),
                      Text('Temp: ${patientData.value!['temperature']}'),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to assessment
                          },
                          child: const Text('Start Assessment'),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
