import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maternal_triage/bloc/assessment/assessment_bloc.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/firebase_options.dart';
import 'package:maternal_triage/router/app_router.dart';
import 'package:maternal_triage/services/firebase_doctor_service.dart';
import 'package:maternal_triage/services/persistence_services.dart';
import 'package:maternal_triage/services/theme_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authBloc = AuthBloc(
    FirebaseAuth.instance,
    PersistenceService(),
    DoctorService(),
  )..add(const AuthEvent());

  final assessmentBloc = AssessmentBloc(authBloc: authBloc);
  await assessmentBloc.initialise();

  runApp(MaternalTriageApp(assessmentBloc: assessmentBloc, authBloc: authBloc));
}

class MaternalTriageApp extends StatelessWidget {
  final AuthBloc authBloc;
  final AssessmentBloc assessmentBloc;

  const MaternalTriageApp({
    super.key,
    required this.assessmentBloc,
    required this.authBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: authBloc), // ← reuse existing
        BlocProvider<AssessmentBloc>.value(value: assessmentBloc),
      ],
      child: Builder(
        builder: (context) {
          final appRouter = AppRouter(
            authBloc: context.read<AuthBloc>(),
            assessmentBloc: context.read<AssessmentBloc>(),
            persistenceService: PersistenceService(),
          );

          return ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeService.themeModeNotifier,
            builder: (context, mode, _) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: mode,
                routerConfig: appRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
