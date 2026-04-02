import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/assessment/assessment_bloc.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/bloc/triage/triage_bloc.dart';
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
      // ── outside shell ──────────────────────────
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/signUp',
        name: 'signUp',
        builder: (context, state) => const SignUpScreen(),
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
            path: 'login/signUp',
            name: 'login-signUp',
            builder: (context, state) => const SignUpScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/results',
        name: 'results',
        builder: (context, state) => const ResultScreen(),
      ),

      // ── shell ──────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => BlocProvider(
          create: (_) => TriageBloc(authBloc: authBloc), // ← here
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
            builder: (context, state) => const DataEntryScreen(),
          ),
          GoRoute(
            path: '/resources',
            name: 'resources',
            builder: (context, state) => const ResourcesScreen(),
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
    final onSplash = location == '/';
    final onOnboarding = location == '/onboarding';
    final onAuthPages =
        location == '/login' ||
        location == '/login/forgot-password' ||
        location == '/sign-up';
    if (onSplash) return null; // splash always shows once
    if (!onboardingComplete && !onOnboarding) {
      return '/onboarding'; // first-time onboarding
    }
    if (onboardingComplete && !isLoggedIn && !onAuthPages) {
      return '/sign-up'; // force signup/login
    }
    if (isLoggedIn && onAuthPages) {
      return '/login'; // logged-in users redirected to main app
    }
    return null; // default: allow current route
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
