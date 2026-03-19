import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/assessment/assessment_bloc.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/presentation/screens/data_entry_screen.dart';
import 'package:maternal_triage/presentation/screens/onboarding/forgot_password_screen.dart';
import 'package:maternal_triage/presentation/screens/onboarding/login_screen.dart';
import 'package:maternal_triage/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:maternal_triage/presentation/screens/result_screen.dart';
import 'package:maternal_triage/screens/onboarding/splash_screen.dart';
import 'package:maternal_triage/services/persistence_services.dart';

class AppRouter {
  final AuthBloc authBloc;
  final AssessmentBloc assessmentBloc;
  final PersistenceService _persistenceService;

  AppRouter({
    required this.authBloc,
    required this.assessmentBloc,
    PersistenceService? persistenceService,
  }) : _persistenceService = persistenceService ?? PersistenceService();

  late final router = GoRouter(
      initialLocation: '/login',
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      redirect: _guard,
      routes: [
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
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: 'forgot-password', // becomes /login/forgot-password
              name: 'forgot-password',
              builder: (context, state) => const ForgotPasswordScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/assessment',
          name: 'assessment',
          builder: (context, state) => const DataEntryScreen(),
        ),
        GoRoute(
          path: '/results',
          name: 'results',
          builder: (context, state) => const ResultScreen(),
        ),
      ]);

  Future<String?> _guard(BuildContext context, GoRouterState state) async {
    final onboardingComplete =
        await _persistenceService.getOnboardingComplete();
    final persistedSignIn = await _persistenceService.getSignInStatus();
    final authStatus = authBloc.state.status;
    final isLoggedIn = (authStatus == FormzSubmissionStatus.success &&
            authBloc.state.userEmail != null) ||
        persistedSignIn;
    ;
    final location = state.matchedLocation;
    final onSplash = location == '/';
    final onOnboarding = location == '/onboarding';
    final onAuthPages =
        location == '/login' || location == '/login/forgot-password';

    if (onSplash) return null;
    if (!onboardingComplete && !onOnboarding) return '/onboarding';
    if (onboardingComplete && !isLoggedIn && !onAuthPages) return '/login';
    if (isLoggedIn && onAuthPages) return '/assessment';
    return null;
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
