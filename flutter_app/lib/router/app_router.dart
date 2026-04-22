// lib/router/app_routes.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/assessment/assessment_bloc.dart';
import 'package:maternal_triage/bloc/assessment_form/assessment_form_bloc.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/bloc/sign_up/sign_up_bloc.dart';
import 'package:maternal_triage/bloc/triage/triage_bloc.dart';
import 'package:maternal_triage/presentation/screens/auth/pending_approval.dart';
import 'package:maternal_triage/presentation/screens/auth/rejected_screen.dart';
import 'package:maternal_triage/presentation/screens/auth/sign_up.dart';
import 'package:maternal_triage/presentation/screens/history_screen.dart';
import 'package:maternal_triage/presentation/screens/auth/forgot_password_screen.dart';
import 'package:maternal_triage/presentation/screens/auth/sign_in.dart';
import 'package:maternal_triage/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:maternal_triage/presentation/screens/onboarding/splash_screen.dart';
import 'package:maternal_triage/presentation/screens/patient_detail_screen.dart';
import 'package:maternal_triage/presentation/screens/triadge_screen.dart';
import 'package:maternal_triage/presentation/screens/data_entry_screen.dart';
import 'package:maternal_triage/presentation/screens/resources_screen.dart';
import 'package:maternal_triage/presentation/screens/result_screen.dart';
import 'package:maternal_triage/presentation/widget/main_screen.dart';
import 'package:maternal_triage/services/persistence_services.dart';

class AppRouter {
  final AuthBloc authBloc;
  final AssessmentBloc assessmentBloc;
  final PersistenceService _persistenceService;
  final bool debugFlow;

  AppRouter({
    required this.authBloc,
    required this.assessmentBloc,
    PersistenceService? persistenceService,
    this.debugFlow = false,
  }) : _persistenceService = persistenceService ?? PersistenceService();

  late final router = GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: _guard,
    routes: [
      // ── SPLASH (No guard needed) ──
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // ── ONBOARDING (No guard needed) ──
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // ── AUTH ROUTES (Not guarded) ──
      GoRoute(
        path: '/signUp',
        name: 'signUp',
        builder: (context, state) => BlocProvider(
          create: (_) => SignUpBloc(),
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            path: 'forgot-password',
            name: 'forgot-password',
            builder: (context, state) => const ForgotPasswordScreen(),
          ),
          GoRoute(
            path: 'signUp',
            name: 'login-signUp',
            builder: (context, state) => BlocProvider(
              create: (_) => SignUpBloc(),
              child: const SignUpScreen(),
            ),
          ),
        ],
      ),

      // ── POST-AUTH ROUTES (Guarded) ──
      GoRoute(
        path: '/pending-approval',
        name: 'pending-approval',
        builder: (context, state) => const PendingApprovalScreen(),
      ),
      GoRoute(
        path: '/rejected',
        name: 'rejected',
        builder: (context, state) => const RejectedScreen(),
      ),
      GoRoute(
        path: '/results',
        name: 'results',
        builder: (context, state) => const ResultScreen(),
      ),

      // ── MAIN APP (Shell route) ──
      ShellRoute(
        builder: (context, state, child) => BlocProvider(
          create: (_) => TriageBloc(authBloc: authBloc),
          child: MainScreen(child: child),
        ),
        routes: [
          GoRoute(
            path: '/triage',
            name: 'triage',
            builder: (context, state) => const TriageScreen(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'patient-detail',
                builder: (context, state) =>
                    PatientDetailScreen(patientId: state.pathParameters['id']!),
              ),
            ],
          ),
          GoRoute(
            path: '/assessment',
            name: 'assessment',
            builder: (context, state) => BlocProvider(
              create: (context) => AssessmentFormBloc(
                assessmentBloc: context.read<AssessmentBloc>(),
              ),
              child: const DataEntryScreen(),
            ),
          ),
          GoRoute(
            path: '/resources',
            name: 'resources',
            builder: (context, state) => const EducationalLibraryScreen(),
          ),
          GoRoute(
            path: '/history',
            name: 'history',
            builder: (context, state) => const HistoryScreen(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'history-detail',
                builder: (context, state) =>
                    PatientDetailScreen(patientId: state.pathParameters['id']!),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  Future<String?> _guard(BuildContext context, GoRouterState state) async {
    final onboardingComplete = await _persistenceService
        .getOnboardingComplete();
    final persistedSignIn = await _persistenceService.getSignInStatus();
    final isLoggedIn =
        (authBloc.state.status == FormzSubmissionStatus.success &&
            authBloc.state.userEmail != null) ||
        persistedSignIn;
    final location = state.matchedLocation;

    if (location == '/' ||
        location == '/onboarding' ||
        location == '/signUp' ||
        location == '/login' ||
        location == '/login/forgot-password' ||
        location == '/login/signUp') {
      return null; // Allow these routes always
    }

    // ✅ IF ONBOARDING NOT COMPLETE → GO TO ONBOARDING
    if (!onboardingComplete) {
      return '/onboarding';
    }

    // ✅ IF NOT LOGGED IN → GO TO SIGNUP/LOGIN
    if (!isLoggedIn) {
      return '/login';
    }

    // ✅ IF LOGGED IN, CHECK STATUS
    if (isLoggedIn) {
      final doctorStatus = authBloc.state.doctorStatus;

      // PENDING APPROVAL
      if (doctorStatus == 'pending') {
        if (location != '/pending-approval') {
          return '/pending-approval';
        }
        return null;
      }

      // REJECTED
      if (doctorStatus == 'rejected') {
        if (location != '/rejected') {
          return '/rejected';
        }
        return null;
      }

      // APPROVED → Allow access to main app
      if (doctorStatus == 'approved') {
        return null; // Allow any route
      }
    }

    return null; // Default: allow
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
