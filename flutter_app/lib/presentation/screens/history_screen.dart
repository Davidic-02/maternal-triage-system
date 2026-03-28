import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HistoryScreen extends HookWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🟢 Hook states
    final isLoading = useState(true);
    final historyList = useState<List<Map<String, dynamic>>>([]);

    // 🟢 Simulate fetching data (replace with Firestore later)
    useEffect(() {
      Future.delayed(const Duration(seconds: 2), () {
        historyList.value = [
          {
            'id': '1',
            'name': 'Jane Doe',
            'date': '2026-03-27',
            'risk': 'Low',
          },
          {
            'id': '2',
            'name': 'Mary John',
            'date': '2026-03-26',
            'risk': 'High',
          },
        ];

        isLoading.value = false;
      });

      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : historyList.value.isEmpty
              ? const Center(child: Text('No history available'))
              : ListView.builder(
                  itemCount: historyList.value.length,
                  itemBuilder: (context, index) {
                    final item = historyList.value[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Text(item['name']),
                        subtitle: Text('Date: ${item['date']}'),
                        trailing: Text(item['risk']),
                        onTap: () {
                          // Navigate to patient details
                          // Example:
                          // context.push('/patient/${item['id']}');
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
