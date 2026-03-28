import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/presentation/widget/button.dart';
import 'package:maternal_triage/presentation/widget/custom_text_form_field.dart';
import 'package:maternal_triage/router/app_routes.dart';
import 'package:maternal_triage/services/toast_services.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';
  @override
  Widget build(BuildContext context) {
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final obscurePassword = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return Scaffold(
        backgroundColor: AppColors.darkGreen,
        body: BlocBuilder<AuthBloc, AuthState>(buildWhen: (previous, current) {
          return _loginBuildWhen(context, previous, current);
        }, builder: (context, state) {
          return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                          ),
                          const Center(
                            child: Text(
                              'Login to Your Account',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          AppSpacing.verticalSpaceSmall,
                          CustomTextFormField(
                            focusNode: emailFocusNode,
                            hintText: 'Email',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            fillColor: AppColors.white,
                            onChanged: (value) => context.read<AuthBloc>().add(
                                  AuthEvent.emailChanged(value),
                                ),
                            errorText:
                                !state.email.isPure && state.email.isNotValid
                                    ? "Please enter a valid email address"
                                    : null,
                          ),
                          AppSpacing.verticalSpaceSmall,
                          CustomTextFormField(
                            focusNode: passwordFocusNode,
                            textInputAction: TextInputAction.send,
                            hintText: 'Password',
                            keyboardType: TextInputType.text,
                            fillColor: AppColors.white,
                            obscureText: !obscurePassword.value,
                            isPassword: true,
                            onChanged: (value) => context
                                .read<AuthBloc>()
                                .add(AuthEvent.passwordChanged(value)),
                            onFieldSubmitted: (_) => context
                                .read<AuthBloc>()
                                .add(const AuthEvent.login()),
                          ),
                          AppSpacing.verticalSpaceLarge,
                          Button(
                            'Login',
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                    const AuthEvent.login(),
                                  );
                            },
                            busy: state.loginStatus ==
                                FormzSubmissionStatus.inProgress,
                          ),
                          AppSpacing.verticalSpaceHuge,
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () =>
                                  context.go(AppRoutes.forgotPassword),
                              child: const Text('Forgot Password?'),
                            ),
                          )
                        ],
                      ))));
        }));
  }

  _loginBuildWhen(
    BuildContext context,
    AuthState previous,
    AuthState current,
  ) {
    if (previous.loginStatus != current.loginStatus &&
        current.loginStatus.isSuccess) {
      ToastService.toast('Welcome!');
    }

    if (previous.errorMessage != current.errorMessage &&
        current.errorMessage != null) {
      ToastService.toast(
        current.errorMessage ?? 'Something went wrong',
        ToastType.error,
      );
      return true;
    }
    if (previous.email != current.email ||
        previous.password != current.password) {
      return true;
    }

    return false;
  }
}
