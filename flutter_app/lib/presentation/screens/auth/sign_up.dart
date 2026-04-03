import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/sign_up/sign_up_bloc.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/presentation/widget/button.dart';
import 'package:maternal_triage/presentation/widget/step_one.dart';
import 'package:maternal_triage/presentation/widget/step_two.dart';
import 'package:maternal_triage/services/toast_services.dart';

class SignUpScreen extends HookWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/signUp';

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    return Scaffold(
      body: BlocProvider<SignUpBloc>(
        create: (_) => SignUpBloc(),
        child: BlocListener<SignUpBloc, SignUpState>(
          listenWhen: (previous, current) => _listenWhen(previous, current),
          listener: (context, state) => _listener(context, state),
          child: BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) => _buildWhen(previous, current),
            builder: (context, state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Column(
                    children: [
                      // header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 30,
                        ),
                        child: Row(
                          children: [
                            if (state.currentStep > 0)
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                  context.read<SignUpBloc>().add(
                                    SignUpEvent.stepChanged(
                                      state.currentStep - 1,
                                    ),
                                  );
                                },
                              ),
                            const Spacer(),
                            Text(
                              'Step ${state.currentStep + 1} of 2',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // steps
                      Expanded(
                        child: PageView(
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (index) => context
                              .read<SignUpBloc>()
                              .add(SignUpEvent.stepChanged(index)),
                          children: const [StepOne(), StepTwo()],
                        ),
                      ),

                      // button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Button(
                                state.currentStep == 0 ? 'Next' : 'Register',
                                onPressed: state.status.isInProgress
                                    ? null
                                    : () => _onButtonPressed(
                                        context,
                                        state,
                                        pageController,
                                      ),
                                busy: state.status.isInProgress,
                                busyText: 'Please wait...', // ← optional
                              ),
                            ),
                            AppSpacing.verticalSpaceSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an account?'),
                                TextButton(
                                  onPressed: () => context.go('/login'),
                                  child: const Text('Login'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onButtonPressed(
    BuildContext context,
    SignUpState state,
    PageController pageController,
  ) {
    if (state.currentStep == 0) {
      // validate step 1 first
      context.read<SignUpBloc>().add(const SignUpEvent.validateStepOne());
      if (state.isStepOneValid) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      // validate step 2 then submit
      context.read<SignUpBloc>().add(const SignUpEvent.validateStepTwo());
      if (state.isStepTwoValid) {
        context.read<SignUpBloc>().add(const SignUpEvent.submit());
      }
    }
  }

  // ── listen ───────────────────────────────────────────────────

  bool _listenWhen(SignUpState previous, SignUpState current) =>
      previous.status != current.status ||
      previous.errorMessage != current.errorMessage;

  void _listener(BuildContext context, SignUpState state) {
    if (state.status.isSuccess) {
      ToastService.toast('Registration successful! Awaiting approval.');
      context.go('/pending-approval');
    }

    if (state.status.isFailure && state.errorMessage != null) {
      ToastService.toast(
        state.errorMessage ?? 'Something went wrong',
        ToastType.error,
      );
    }

    if (state.status.isFailure && state.errorMessage != null) {
      ToastService.toast(
        state.errorMessage ?? 'Something went wrong',
        ToastType.error,
      );
    }
  }

  bool _buildWhen(SignUpState previous, SignUpState current) =>
      previous.currentStep != current.currentStep ||
      previous.status != current.status ||
      previous.name != current.name ||
      previous.email != current.email ||
      previous.password != current.password ||
      previous.role != current.role ||
      previous.medicalId != current.medicalId ||
      previous.isPasswordVisible != current.isPasswordVisible;
}
