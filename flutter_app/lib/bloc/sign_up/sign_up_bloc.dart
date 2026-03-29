import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:formz/formz.dart';
import 'package:maternal_triage/enums/validator_error.dart';
import 'package:maternal_triage/models/doctor_model.dart';
import 'package:maternal_triage/services/firebase_doctor_service.dart';
import '../../services/logging_helper.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';
part 'sign_up_bloc.freezed.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseAuth _firebaseAuth;
  final DoctorService _doctorService;

  SignUpBloc({FirebaseAuth? firebaseAuth, DoctorService? doctorService})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _doctorService = doctorService ?? DoctorService(),

      super(const SignUpState()) {
    on<_NameChanged>(_onNameChanged);
    on<_RoleChanged>(_onRoleChanged);
    on<_EmailChanged>(_onEmailChanged);
    on<_PasswordChanged>(_onPasswordChanged);
    on<_ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<_MedicalIdChanged>(_onMedicalIdChanged);
    on<_ValidateStepOne>(_onValidateStepOne);
    on<_ValidateStepTwo>(_onValidateStepTwo);
    on<_StepChanged>(_onStepChanged);
    on<_PasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<_Submit>(_onSubmit);
    on<_SubmitSuccessful>(_onSubmitSuccessful);
    on<_SubmitFailed>(_onSubmitFailed);
    on<_ErrorMessage>(_onErrorMessage);
  }

  void _onNameChanged(_NameChanged event, Emitter<SignUpState> emit) {
    final name = NameFormz.dirty(event.name);
    emit(
      state.copyWith(name: name.isValid ? name : NameFormz.pure(event.name)),
    );
  }

  void _onRoleChanged(_RoleChanged event, Emitter<SignUpState> emit) {
    final role = RoleFormz.dirty(event.role);
    emit(
      state.copyWith(role: role.isValid ? role : RoleFormz.pure(event.role)),
    );
  }

  void _onMedicalIdChanged(_MedicalIdChanged event, Emitter<SignUpState> emit) {
    final medicalId = MedicalIdFormz.dirty(event.id);
    emit(
      state.copyWith(
        medicalId: medicalId.isValid
            ? medicalId
            : MedicalIdFormz.pure(event.id),
      ),
    );
  }

  void _onEmailChanged(_EmailChanged event, Emitter<SignUpState> emit) {
    final email = EmailFormz.dirty(event.email);

    emit(
      state.copyWith(
        email: email.isValid ? email : EmailFormz.pure(event.email),
      ),
    );
  }

  void _onPasswordChanged(_PasswordChanged event, Emitter<SignUpState> emit) {
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

  void _onConfirmPasswordChanged(
    _ConfirmPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final confirm = PasswordConfirmFormz.dirty(
      state.password.value, // compare to current password
      event.value,
    );

    emit(state.copyWith(passwordConfirm: confirm));
  }

  void _onPasswordVisibilityToggled(
    _PasswordVisibilityToggled event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onStepChanged(_StepChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(currentStep: event.step));
  }

  void _onValidateStepOne(_ValidateStepOne event, Emitter<SignUpState> emit) {
    emit(
      state.copyWith(
        name: NameFormz.dirty(state.name.value),
        email: EmailFormz.dirty(state.email.value),
        password: PasswordFormz.dirty(state.password.value),
      ),
    );
  }

  // validates step 2 — marks all fields dirty to show errors
  void _onValidateStepTwo(_ValidateStepTwo event, Emitter<SignUpState> emit) {
    emit(
      state.copyWith(
        role: RoleFormz.dirty(state.role.value),
        medicalId: MedicalIdFormz.dirty(state.medicalId.value),
      ),
    );
  }

  Future<void> _onSubmit(_Submit event, Emitter<SignUpState> emit) async {
    if (state.status == FormzSubmissionStatus.inProgress) return;

    if (!state.isFormValid) {
      emit(
        state.copyWith(
          email: EmailFormz.dirty(state.email.value),
          password: PasswordFormz.dirty(state.password.value),
          name: NameFormz.dirty(state.name.value),
          role: RoleFormz.dirty(state.role.value),
          medicalId: MedicalIdFormz.dirty(state.medicalId.value),
          errorMessage: 'Please fill in all fields correctly.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: state.email.value.trim(),
        password: state.password.value,
      );

      final user = credential.user;
      if (user == null) {
        add(
          const SignUpEvent.submitFailed(
            'Registration failed. Please try again.',
          ),
        );
        return;
      }
      final doctor = DoctorModel(
        uid: user.uid,
        name: state.name.value.trim(),
        email: state.email.value.trim(),
        role: state.role.value,
        medicalId: state.medicalId.value.trim(),
        status: 'pending',
        createdAt: DateTime.now(),
      );
      await _doctorService.saveDoctor(doctor);

      logInfo('Doctor registered: ${user.email}');
      add(const SignUpEvent.submitSuccessful());
    } on FirebaseAuthException catch (error, trace) {
      logError(error, trace);
      add(SignUpEvent.submitFailed(_mapFirebaseError(error)));
    } catch (error, trace) {
      logError(error, trace);
      add(const SignUpEvent.submitFailed('An unexpected error occurred.'));
    }
  }

  void _onSubmitSuccessful(_SubmitSuccessful event, Emitter<SignUpState> emit) {
    emit(
      state.copyWith(status: FormzSubmissionStatus.success, errorMessage: null),
    );
  }

  void _onSubmitFailed(_SubmitFailed event, Emitter<SignUpState> emit) {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: event.message,
      ),
    );
  }

  void _onErrorMessage(_ErrorMessage event, Emitter<SignUpState> emit) {
    emit(state.copyWith(errorMessage: event.message));
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      default:
        return e.message ?? 'An error occurred. Please try again.';
    }
  }
}
