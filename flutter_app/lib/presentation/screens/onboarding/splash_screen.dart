import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:maternal_triage/constant/app_spacing.dart';

class SplashScreen extends HookWidget {
  static const routeName = '/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 6));
      return null;
    }, const []);
    return Scaffold(
        body: Center(
            child: Center(
                child: Column(children: [
      LottieBuilder.asset(
        'flutter_app/assets/animations/covid_pregnant_woman.json',
        width: 200,
        height: 200,
        repeat: true,
        animate: true,
      ),
      AppSpacing.verticalSpaceMedium,
      const Text('Maternaly')
    ]))));
  }
}
