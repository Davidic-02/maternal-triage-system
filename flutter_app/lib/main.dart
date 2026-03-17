import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maternal_triage/bloc/assessment/assessment_bloc.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/firebase_options.dart';
import 'package:maternal_triage/router/app_routes.dart';
import 'package:maternal_triage/services/persistence_services.dart';
import 'presentation/screens/data_entry_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/onboarding/login_screen.dart';
import 'presentation/screens/result_screen.dart';
import 'presentation/screens/onboarding/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final assessmentBloc = AssessmentBloc();
  await assessmentBloc.initialise();

  runApp(MaternalTriageApp(assessmentBloc: assessmentBloc));
}

class MaternalTriageApp extends StatelessWidget {
  final AssessmentBloc assessmentBloc;

  const MaternalTriageApp({
    super.key,
    required this.assessmentBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) =>
                AuthBloc(FirebaseAuth.instance, PersistenceService()),
          ),
          BlocProvider<AssessmentBloc>.value(value: assessmentBloc),
        ],
        child: Builder(
          builder: (context) {
            final appRouter = AppRouter(
              authBloc: context.read<AuthBloc>(),
              assessmentBloc: context.read<AssessmentBloc>(),
            );

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter.router,
            );
          },
        ));
  }
}
