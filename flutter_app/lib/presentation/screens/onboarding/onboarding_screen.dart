import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:maternal_triage/bloc/onboarding/onboarding_bloc.dart';

import 'package:maternal_triage/presentation/widget/onboarding_page.dart';

import 'package:maternal_triage/router/app_routes.dart';

class OnboardingScreen extends HookWidget {
  static const routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listenWhen: (p, c) => p.currentPage != c.currentPage,
        listener: (context, state) {
          pageController.animateToPage(
            state.currentPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
        child: BlocConsumer<OnboardingBloc, OnboardingState>(
          listener: (context, state) {
            if (state.isCompleted == true) {
              context.go(AppRoutes.login);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  PageView(
                    // ✅ Pages must be inside PageView
                    controller: pageController,
                    onPageChanged: (index) {
                      context.read<OnboardingBloc>().add(
                        OnboardingEvent.pageChanged(index),
                      );
                    },
                    children: [
                      OnboardingPage(
                        title: 'Smarter Maternal Care, Instantly',
                        description:
                            'AI Powered triage decision support system designed to help you make faster, safer clinical decisions',
                        imagePath: 'assets/images/onboarding1.png',

                        onGetStarted: () => context.read<OnboardingBloc>().add(
                          const OnboardingEvent.nextPageRequested(),
                        ),
                        onSignIn: () => context.go(AppRoutes.login),
                      ),
                      OnboardingPage(
                        title: 'Assess. Analyze. Decide.',
                        description:
                            'Fill in Patient Details, Get instant AI risk \n Insights, Undersatnd the "why" behind result',
                        imagePath: 'assets/images/onboarding2.png',

                        onGetStarted: () => context.read<OnboardingBloc>().add(
                          const OnboardingEvent.nextPageRequested(),
                        ),
                        onSignIn: () => context.go(AppRoutes.login),
                      ),
                      OnboardingPage(
                        title: 'You Stay in Control always.',
                        description:
                            'This tool supports your clinical decisions;\nIt dosent replace them.',
                        imagePath: 'assets/images/onboarding3.png',

                        onGetStarted: () => context.read<OnboardingBloc>().add(
                          const OnboardingEvent.completed(),
                        ),
                        onSignIn: () => context.go(AppRoutes.login),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 420, // adjust to sit above your card
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.orange,
                          dotColor: Colors.grey,
                          dotHeight: 8,
                          dotWidth: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
