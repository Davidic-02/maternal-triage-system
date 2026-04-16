import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:maternal_triage/router/app_routes.dart';

class SplashScreen extends HookWidget {
  static const routeName = '/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 90), () {
        context.go(AppRoutes.onboarding);
      });
      return null;
    }, const []);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/animations/covid_pregnant_woman.json',
              width: 400,
              height: 400,
              repeat: true,
              animate: true,
            ),
            Text(
              'Maternal DSS',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
