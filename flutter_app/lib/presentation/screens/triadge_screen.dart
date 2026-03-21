import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

class TriadgeScreen extends HookWidget {
  static const routeName = '/';
  const TriadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Center(
      child: LottieBuilder.asset(
        'flutter_app/assets/animations/Covid pregnant woman.json',
        width: 200,
        height: 200,
        repeat: true,
        animate: true,
      ),
    )));
  }
}
