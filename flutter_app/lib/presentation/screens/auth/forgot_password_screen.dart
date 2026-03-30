import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';

import 'package:maternal_triage/constant/app_spacing.dart';

import 'package:maternal_triage/presentation/widget/button.dart';
import 'package:maternal_triage/presentation/widget/custom_text_form_field.dart';

import 'package:maternal_triage/services/toast_services.dart';

class ForgotPasswordScreen extends HookWidget {
  const ForgotPasswordScreen({super.key});
  static const String routeName = '/forgot_password';

  @override
  Widget build(BuildContext context) {
    final emailFocusNode = useFocusNode();

    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) =>
            _buildWhen(context, previous, current),
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                AppSpacing.verticalSpaceSmall,
                const Text(
                  'Enter your email to receive a password reset link',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.verticalSpaceMedium,
                CustomTextFormField(
                  onChanged: (value) => context.read<AuthBloc>().add(
                    AuthEvent.emailChanged(value),
                  ),
                  errorText: !state.email.isPure && !state.email.isValid
                      ? "Please enter a valid email address"
                      : null,
                  focusNode: emailFocusNode,
                  hintText: 'Email Address',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,

                  onFieldSubmitted: (_) => context.read<AuthBloc>().add(
                    const AuthEvent.forgotPassword(),
                  ),
                ),
                AppSpacing.verticalSpaceMassive,
                Button(
                  'Send Reset Email',
                  busy:
                      state.forgotPasswordStatus ==
                      FormzSubmissionStatus.inProgress,
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      const AuthEvent.forgotPassword(),
                    );
                  },
                ),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool _buildWhen(BuildContext context, AuthState previous, AuthState current) {
    if (previous.forgotPasswordStatus != current.forgotPasswordStatus &&
        current.forgotPasswordStatus.isSuccess) {
      ToastService.toast(
        'If an account exists with this email, a password reset link has been sent.',
        ToastType.success,
      );

      Navigator.pop(context);
      return true;
    }

    // Show error messages
    if (previous.errorMessage != current.errorMessage &&
        current.errorMessage != null) {
      ToastService.toast('${current.errorMessage}', ToastType.error);
      context.read<AuthBloc>().add(const AuthEvent.errorMessage(null));
      return true;
    }

    // Rebuild if forgot password status changed
    if (previous.forgotPasswordStatus != current.forgotPasswordStatus) {
      return true;
    }

    // Rebuild if email changes
    if (previous.email != current.email) {
      return true;
    }
    return false;
  }
}
