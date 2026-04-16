import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:maternal_triage/bloc/onboarding/onboarding_bloc.dart';
import 'package:maternal_triage/presentation/widget/button.dart';
import 'package:maternal_triage/presentation/widget/onboarding_page.dart';
import 'package:maternal_triage/presentation/widget/terms_page.dart';
import 'package:maternal_triage/router/app_routes.dart';

class OnboardingScreen extends HookWidget {
  static const routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state.isCompleted == true) {
            context.go(AppRoutes.triage);
          }
        },
        builder: (context, state) {
          final isLastPage = state.currentPage == 2;

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                          context.read<OnboardingBloc>().add(
                            OnboardingEvent.pageChanged(index),
                          );
                        },
                        children: [
                          const OnboardingPage(
                            title: 'Maternal Triage Assistant',
                            description:
                                'Your intelligent maternal health companion for fast, accurate triage decisions.',
                            animationPath:
                                'assets/animations/Hero animation for health care.json',
                          ),
                          const OnboardingPage(
                            title: 'How It Works',
                            description:
                                'Fill the patient form, run the AI model, review SHAP explanation, save the record.',
                            animationPath: 'assets/animations/chatbot.json',
                          ),
                          TermsPage(
                            accepted: state.hasAcceptedTerms,
                            onAccepted: (val) {
                              context.read<OnboardingBloc>().add(
                                OnboardingEvent.termsAccepted(val),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // 📍 INDICATOR
                    if (!isLastPage)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: AppColors.primaryGreen,
                            dotColor: Colors.grey,
                            dotHeight: 10,
                            dotWidth: 10,
                            expansionFactor: 2.5,
                            spacing: 8,
                          ),
                        ),
                      ),

                    if (isLastPage)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: SizedBox(
                          width: double.infinity,
                          child: Button(
                            'Get Started',
                            onPressed: !state.hasAcceptedTerms
                                ? null
                                : () {
                                    context.read<OnboardingBloc>().add(
                                      const OnboardingEvent.completed(),
                                    );
                                  },
                          ),
                        ),
                      ),

                    // 📏 BOTTOM SPACING
                    if (!isLastPage) const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
