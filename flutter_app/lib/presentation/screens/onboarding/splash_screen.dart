import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/router/app_routes.dart';

class SplashScreen extends HookWidget {
  static const routeName = '/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    useEffect(() {
      final timer = Future.delayed(const Duration(seconds: 3), () {
        // ✅ check context is still valid before navigating
        if (context.mounted) {
          context.go(AppRoutes.onboarding);
        }
      });
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // ✅ start, not center
        children: [
          // ✅ push logo + title down more
          SizedBox(height: screenHeight * 0.12),

          Image.asset('assets/images/maternal_dss.png', height: 80),

          const SizedBox(height: 8),

          const SizedBox(height: 40),

          // ✅ fixed height so Positioned children don't clip
          SizedBox(
            height: screenHeight * 0.5,
            width: double.infinity,
            child: SizedBox(
              height: screenHeight * 0.5,
              width: double.infinity,
              child: SizedBox(
                height: screenHeight * 0.6,
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // 1️⃣ LEFT
                    Positioned(
                      left: -30,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Image.asset(
                          'assets/images/left_circle.png',
                          height: screenHeight * 0.42,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // 2️⃣ RIGHT
                    Positioned(
                      right: -30,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Image.asset(
                          'assets/images/right_circle.png',
                          height: screenHeight * 0.42,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // 3️⃣ CENTER CIRCLE — bigger
                    Center(
                      child: Image.asset(
                        'assets/images/center_circle.png',
                        width: screenHeight * 0.62, // ✅ increased
                        height: screenHeight * 0.62, // ✅ increased
                      ),
                    ),

                    // 4️⃣ WOMAN — fills all remaining space to screen bottom
                    Positioned(
                      top: 0,
                      bottom: -(screenHeight * 0.25),
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/pregnant_woman.png',
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
