import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/onboarding/onboarding_bloc.dart';
import 'package:maternal_triage/presentation/widget/onboarding_page.dart';
import 'package:maternal_triage/presentation/widget/terms_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends HookWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
        final isLastPage = state.currentPage == 2;

        return Scaffold(
            body: SafeArea(
                child: Column(children: [
          Expanded(
            child: isLastPage
                ? TermsPage(
                    accepted: state.hasAcceptedTerms,
                    onAccepted: (val) => context
                        .read<OnboardingBloc>()
                        .add(OnboardingEvent.termsAccepted(val)),
                  )
                : PageView(
                    controller: pageController,
                    onPageChanged: (index) => context
                        .read<OnboardingBloc>()
                        .add(OnboardingEvent.pageChanged(index)),
                    children: const [
                      OnboardingPage(
                        title: 'Maternal Triage Assistant',
                        description:
                            'flutter_app/assets/animations/Hero animation for health care.json',
                        animationPath: 'assets/animations/intro.json',
                      ),
                      OnboardingPage(
                        title: 'How It Works',
                        description:
                            'Fill the patient form, run the AI model, review SHAP explanation, save the record.',
                        animationPath:
                            'flutter_app/assets/animations/Medical Icon Prescription.json',
                      ),
                    ],
                  ),
          ),

          // smooth page indicator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Theme.of(context).colorScheme.primary,
                dotHeight: 8,
                dotWidth: 16,
                spacing: 8,
                expansionFactor: 3,
              ),
            ),
          ),

          // next / get started button
          Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLastPage && !state.hasAcceptedTerms
                        ? null
                        : () {
                            if (isLastPage) {
                              context
                                  .read<OnboardingBloc>()
                                  .add(const OnboardingEvent.completed());
                            } else {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                    child: Text(isLastPage ? 'Get Started' : 'Next'),
                  )))
        ])));
      }, listener: (context, state) {
        if (state.isCompleted == true) {
          context.go('/login');
        }
      }),
    );
  }
}
