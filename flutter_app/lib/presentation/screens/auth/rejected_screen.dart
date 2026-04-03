import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/presentation/widget/button.dart';
import 'package:maternal_triage/services/toast_services.dart';

class RejectedScreen extends StatelessWidget {
  static const routeName = '/rejected';
  const RejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.doctorStatus != current.doctorStatus,
      listener: (context, state) {
        if (state.doctorStatus == 'approved') {
          context.read<AuthBloc>().add(const AuthEvent.logoutRequested());
          ToastService.toast('🎉 Account approved! Please login to continue.');
          context.go('/login');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cancel_outlined,
                  size: 80,
                  color: AppColors.danger,
                ),
                AppSpacing.verticalSpaceLarge,
                const Text(
                  'Account Rejected',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.verticalSpaceMedium,
                const Text(
                  'Your account application was not approved. '
                  'Please contact your hospital administrator.',
                  style: TextStyle(color: AppColors.greyColor),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.verticalSpaceLarge,
                Button(
                  'Logout',
                  onPressed: () => context.read<AuthBloc>().add(
                    const AuthEvent.logoutRequested(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
