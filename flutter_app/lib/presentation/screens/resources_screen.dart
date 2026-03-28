import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ResourcesScreen extends HookWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🟢 Hook state
    final isLoading = useState(false);
    final textController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reusable Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟢 TextField
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Enter something',
              ),
            ),

            const SizedBox(height: 20),

            // 🟢 Button
            ElevatedButton(
              onPressed: () {
                isLoading.value = true;

                Future.delayed(const Duration(seconds: 2), () {
                  isLoading.value = false;
                });
              },
              child: const Text('Submit'),
            ),

            const SizedBox(height: 20),

            // 🟢 Loading indicator
            if (isLoading.value)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
