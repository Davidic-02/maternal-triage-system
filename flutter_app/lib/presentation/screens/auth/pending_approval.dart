import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/constant/app_colors.dart';
import 'package:maternal_triage/constant/app_spacing.dart';
import 'package:maternal_triage/presentation/widget/button.dart';

class PendingApprovalScreen extends StatelessWidget {
  static const routeName = '/pending-approval';
  const PendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.hourglass_top_rounded,
                size: 80,
                color: AppColors.primaryGreen,
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
                'You will be automatically redirected once approved.',
                style: TextStyle(color: AppColors.greyColor),
                textAlign: TextAlign.center,
              ),
              AppSpacing.verticalSpaceLarge,
              // logout button
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
    );
  }
}
