import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/presentation/widget/button.dart';
import 'package:maternal_triage/services/toast_services.dart';

class PendingApprovalScreen extends StatelessWidget {
  static const routeName = '/pending-approval';

  const PendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.doctorStatus != current.doctorStatus,
      listener: (context, state) {
        if (state.doctorStatus == 'approved') {
          // sign out first
          context.read<AuthBloc>().add(const AuthEvent.logoutRequested());
          ToastService.toast('🎉 Account approved! Please login to continue.');
          context.go('/login');
        }
        if (state.doctorStatus == "rejected") {
          context.read<AuthBloc>().add(const AuthEvent.logoutRequested());
          ToastService.toast(
            'Account rejected. Contact your administrator.',
            ToastType.error,
          );
          context.go('/login');
        }
      },

      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.9, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    builder: (context, scale, child) {
                      return Transform.scale(scale: scale, child: child);
                    },
                    child: Lottie.asset(
                      'assets/animations/No_Data.json',
                      height: 180,
                    ),
                  ),
                  AppSpacing.verticalSpaceLarge,
                  const Text(
                    'Account Pending Approval',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  AppSpacing.verticalSpaceMedium,
                  const Text(
                    'Your account is under review by the admin. '
                    'You will be notified here once a decision is made.',
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
      ),
    );
  }
}

//enum DoctorStatus { pending, approved, rejected }
