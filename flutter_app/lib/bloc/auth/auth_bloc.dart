import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:formz/formz.dart';
import 'package:maternal_triage/enums/validator_error.dart';
import 'package:email_validator/email_validator.dart';
import 'package:maternal_triage/models/doctor_model.dart';
import 'package:maternal_triage/services/firebase_doctor_service.dart';
import 'package:maternal_triage/services/persistence_services.dart';
import '../../services/logging_helper.dart';
part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  final PersistenceService _persistenceService;
  final DoctorService _doctorService;
  StreamSubscription<User?>? _authStateSubscription;
  Timer? _sessionTimer;
  static const _sessionTimeout = Duration(minutes: 30);

  AuthBloc(
    FirebaseAuth? firebaseAuth,
    PersistenceService? persistence,
    DoctorService? doctorService,
  ) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _persistenceService = persistence ?? PersistenceService(),
      _doctorService = doctorService ?? DoctorService(),
      super(const AuthState()) {
    on<_AuthEvent>(_onInit);
    on<_EmailChanged>(_onEmailChanged);
    on<_PasswordChanged>(_onPasswordChanged);
    on<_Login>(_onLogin);
    on<_LoginSuccessful>(_onLoginSuccessful);
    on<_LoginFailed>(_onLoginFailed);
    on<_ErrorMessage>(_onErrorMessage);

    on<_ForgotPassword>(_onForgotPassword);
    on<_ForgotPasswordSuccessful>(_onForgotPasswordSuccessful);
    on<_ForgotPasswordFailed>(_onForgotPasswordFailed);

    on<_LogoutRequested>(_onLogoutRequested);
    on<_UserChanged>(_onUserChanged);
    on<_SessionExpired>(_onSessionExpired);

    _authStateSubscription = _firebaseAuth.authStateChanges().listen((user) {
      add(const AuthEvent.userChanged());
    });
  }
  Future<void> _onInit(_AuthEvent event, Emitter<AuthState> emit) async {
    final isSignedIn = await _persistenceService.getSignInStatus();
    final onboardingComplete = await _persistenceService
        .getOnboardingComplete();
    if (isSignedIn) {
      final email = await _persistenceService.getUserEmail();
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          userEmail: email,
          onboardingComplete: onboardingComplete,
        ),
      );
    } else {
      emit(
        state.copyWith(
          onboardingComplete: onboardingComplete,
          status: FormzSubmissionStatus.initial,
        ),
      );
    }
  }

  void _onEmailChanged(_EmailChanged event, Emitter<AuthState> emit) {
    final email = EmailFormz.dirty(event.email);

    emit(
      state.copyWith(
        email: email.isValid ? email : EmailFormz.pure(event.email),
      ),
    );
  }

  void _onPasswordChanged(_PasswordChanged event, Emitter<AuthState> emit) {
    final password = PasswordFormz.dirty(event.password);
    emit(
      state.copyWith(
        password: password.isValid
            ? password
            : PasswordFormz.pure(event.password),
        status: FormzSubmissionStatus.initial,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onLogin(_Login event, Emitter<AuthState> emit) async {
    if (state.loginStatus == FormzSubmissionStatus.inProgress) return;
    if (!state.isLoginFormValid) {
      emit(
        state.copyWith(
          email: EmailFormz.dirty(state.email.value),
          password: PasswordFormz.dirty(state.password.value),
          errorMessage: 'Please fill in all fields correctly.',
        ),
      );
      return;
    }
    emit(state.copyWith(loginStatus: FormzSubmissionStatus.inProgress));

    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: state.email.value.trim(),
        password: state.password.value,
      );
      final user = credential.user;
      if (user == null) {
        add(
          const AuthEvent.loginFailed(
            'Authentication failed. Please try again.',
          ),
        );
        return;
      }
      final doctor = await _doctorService.getDoctor(user.uid);
      if (doctor == null) {
        add(
          const AuthEvent.loginFailed(
            'User data not found. Please contact support.',
          ),
        );
        return;
      }
      await _persistenceService.saveSignInStatus(true);
      await _persistenceService.saveUserEmail(user.email ?? '');
      await PersistenceService().saveUserName(doctor.name);
      await PersistenceService().saveUserRole(doctor.role);

      logInfo('Login successful for: ${user.email}');
      add(const AuthEvent.loginSuccessful());
    } on FirebaseAuthException catch (e) {
      logError(e, null);
      add(AuthEvent.loginFailed(_mapFirebaseError(e)));
    } catch (e, st) {
      logError(e, st);
      add(const AuthEvent.loginFailed('An unexpected error occurred.'));
    }
  }

  void _onLoginSuccessful(_LoginSuccessful event, Emitter<AuthState> emit) {
    _startSessionTimer();
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.success,
        userEmail: _firebaseAuth.currentUser?.email,
        errorMessage: null,
      ),
    );
  }

  void _onLoginFailed(_LoginFailed event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: event.message ?? 'Login failed. Please try again.',
      ),
    );
    add(_ErrorMessage(event.message));
  }

  void _onErrorMessage(_ErrorMessage event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        errorMessage: event.message,
        status: FormzSubmissionStatus.failure,
      ),
    );
  }

  Future<void> _onForgotPassword(
    _ForgotPassword event,
    Emitter<AuthState> emit,
  ) async {
    if (state.forgotPasswordStatus == FormzSubmissionStatus.inProgress) return;

    if (!state.email.isValid) {
      emit(
        state.copyWith(
          email: EmailFormz.dirty(state.email.value),
          errorMessage: 'Please enter a valid email first.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(forgotPasswordStatus: FormzSubmissionStatus.inProgress),
    );

    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: state.email.value.trim(),
      );
      logInfo('Password reset email sent to: ${state.email.value}');
      add(const AuthEvent.forgotPasswordSuccessful());
    } on FirebaseAuthException catch (e) {
      logError(e, null);
      add(AuthEvent.forgotPasswordFailed(_mapFirebaseError(e)));
    } catch (e, st) {
      logError(e, st);
      add(const AuthEvent.forgotPasswordFailed('Failed to send reset email.'));
    }
  }

  void _onForgotPasswordSuccessful(
    _ForgotPasswordSuccessful event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(status: FormzSubmissionStatus.success, errorMessage: null),
    );
  }

  void _onForgotPasswordFailed(
    _ForgotPasswordFailed event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: event.message ?? 'Failed to send reset email.',
      ),
    );
  }

  Future<void> _onLogoutRequested(
    _LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    _cancelSessionTimer();
    try {
      await _firebaseAuth.signOut();
      await _persistenceService.signOut();
    } catch (e, st) {
      logError(e, st);
    }

    emit(const AuthState());
  }

  void _onUserChanged(_UserChanged event, Emitter<AuthState> emit) {
    final user = _firebaseAuth.currentUser;

    if (state.loginStatus == FormzSubmissionStatus.inProgress) return;
    if (state.status == FormzSubmissionStatus.inProgress) return;

    if (user == null && state.status == FormzSubmissionStatus.success) {
      emit(const AuthState());
    }
  }

  void _startSessionTimer() {
    _cancelSessionTimer();
    _sessionTimer = Timer(_sessionTimeout, () {
      add(const AuthEvent.sessionExpired());
    });
  }

  void _cancelSessionTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = null;
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This account has been disabled. Contact admin.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      default:
        return e.message ?? 'An error occurred. Please try again.';
    }
  }

  Future<void> _onSessionExpired(
    _SessionExpired event,
    Emitter<AuthState> emit,
  ) async {
    _cancelSessionTimer();
    logInfo('Session expired — forcing logout.');

    try {
      await _firebaseAuth.signOut();
      await _persistenceService.signOut();
    } catch (e, st) {
      logError(e, st);
    }

    emit(
      state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: 'Your session has expired. Please log in again.',
        userEmail: null,
      ),
    );
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    _cancelSessionTimer();
    return super.close();
  }
}
