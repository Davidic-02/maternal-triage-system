import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/router/app_routes.dart';

class SplashScreen extends HookWidget {
  static const routeName = '/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 60), () {
        context.go(AppRoutes.onboarding);
      });
      return null;
    }, const []);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('flutter_app/assets/images/maternal_dss.png'),
          Text(
            'Maternal DSS',
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 400,
            child: Stack(
              children: [
                Center(child: Image.asset('assets/images/center_circle.png')),

                Positioned(
                  top: 40,
                  left: 0,
                  right: 0,

                  child: Image.asset(
                    'assets/images/pregnant_woman.png',
                    width: 100,
                    height: 100,
                  ),
                ),

                Positioned(
                  left: -75, // pushes half outside
                  top: 200,
                  child: Image.asset('assets/images/left_circle.png'),
                ),

                /// RIGHT SEMI-CIRCLE
                Positioned(
                  right: -75,
                  top: 200,
                  child: Image.asset('assets/images/right_semi.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
