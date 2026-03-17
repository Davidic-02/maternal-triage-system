import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/assessment/assessment_bloc.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/presentation/screens/onboarding/login_screen.dart';

class AppRouter {
  final AuthBloc authBloc;
  final AssessmentBloc assessmentBloc;

  AppRouter({required this.authBloc, required this.assessmentBloc});

  late final router = GoRouter(
      initialLocation: '/login',
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      redirect: _guard,
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        )
      ]);

  String? _guard(BuildContext context, GoRouterState state) {
    final authStatus = authBloc.state.status;
    final isLoggedIn = authStatus == FormzSubmissionStatus.success &&
        authBloc.state.userEmail != null;

    final onAuthPages = state.matchedLocation == '/login' ||
        state.matchedLocation == '/forgot-password';

    if (!isLoggedIn && !onAuthPages) return '/login';
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
