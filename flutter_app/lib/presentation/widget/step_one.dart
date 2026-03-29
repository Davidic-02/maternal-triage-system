import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maternal_triage/bloc/sign_up/sign_up_bloc.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/presentation/widget/custom_text_form_field.dart';

class StepOne extends HookWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    final nameFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final confirmPasswordFocusNode = useFocusNode();

    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.verticalSpaceMedium,
              const Text(
                'Welcome OnBoard!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Tell us about yourself',
                style: TextStyle(color: Colors.grey),
              ),
              AppSpacing.verticalSpaceMedium,
              CustomTextFormField(
                hintText: 'Full Name',
                focusNode: nameFocusNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,

                onChanged: (value) => context.read<SignUpBloc>().add(
                  SignUpEvent.nameChanged(value),
                ),
                errorText: !state.name.isPure && state.name.isNotValid
                    ? 'Name must be at least 3 characters'
                    : null,
              ),
              AppSpacing.verticalSpaceSmall,
              CustomTextFormField(
                hintText: 'Email',
                focusNode: emailFocusNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => context.read<SignUpBloc>().add(
                  SignUpEvent.emailChanged(value),
                ),
                errorText: !state.email.isPure && state.email.isNotValid
                    ? 'Please enter a valid email address'
                    : null,
              ),
              AppSpacing.verticalSpaceSmall,
              CustomTextFormField(
                focusNode: passwordFocusNode,
                textInputAction: TextInputAction.next,
                hintText: 'Password',
                keyboardType: TextInputType.text,

                obscureText:
                    !state.isPasswordVisible, // Bloc state for visibility
                isPassword: true,
                errorText: !state.password.isPure && !state.password.isValid
                    ? "Password must be at least 6 characters."
                    : null,
                onSuffixIconPressed: () => context.read<SignUpBloc>().add(
                  const SignUpEvent.passwordVisibilityToggled(),
                ),
                onChanged: (value) => context.read<SignUpBloc>().add(
                  SignUpEvent.passwordChanged(value),
                ),
                onFieldSubmitted: (_) =>
                    confirmPasswordFocusNode.requestFocus(),
              ),

              AppSpacing.verticalSpaceSmall,

              CustomTextFormField(
                focusNode: confirmPasswordFocusNode,
                textInputAction: TextInputAction.done,
                hintText: 'Confirm Password',
                keyboardType: TextInputType.text,

                obscureText: !state.isPasswordVisible, // same visibility toggle
                isPassword: true,
                errorText:
                    (!state.password.isPure &&
                        state.password.value != state.passwordConfirm.value)
                    ? "Passwords do not match."
                    : null,
                onSuffixIconPressed: () => context.read<SignUpBloc>().add(
                  const SignUpEvent.passwordVisibilityToggled(),
                ),
                onChanged: (value) => context.read<SignUpBloc>().add(
                  SignUpEvent.confirmPasswordChanged(value),
                ),
              ),

              AppSpacing.verticalSpaceLarge,
            ],
          ),
        );
      },
    );
  }
}
