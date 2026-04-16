import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String animationPath;
  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.animationPath,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LottieBuilder.asset(
            animationPath,
            width: double.infinity,
            fit: BoxFit.contain,
            repeat: true,
            animate: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
