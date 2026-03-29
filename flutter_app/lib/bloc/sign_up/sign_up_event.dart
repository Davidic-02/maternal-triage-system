part of 'sign_up_bloc.dart';

@freezed
abstract class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent() = _SignUpEvent;
  const factory SignUpEvent.nameChanged(String name) = _NameChanged;
  const factory SignUpEvent.roleChanged(String role) = _RoleChanged;
  const factory SignUpEvent.emailChanged(String email) = _EmailChanged;
  const factory SignUpEvent.passwordChanged(String password) = _PasswordChanged;
  const factory SignUpEvent.confirmPasswordChanged(String value) =
      _ConfirmPasswordChanged;
  const factory SignUpEvent.medicalIdChanged(String id) = _MedicalIdChanged;
  const factory SignUpEvent.validateStepOne() = _ValidateStepOne;
  const factory SignUpEvent.validateStepTwo() = _ValidateStepTwo;
  const factory SignUpEvent.stepChanged(int step) = _StepChanged;
  const factory SignUpEvent.passwordVisibilityToggled() =
      _PasswordVisibilityToggled;
  const factory SignUpEvent.submit() = _Submit;
  const factory SignUpEvent.submitSuccessful() = _SubmitSuccessful;
  const factory SignUpEvent.submitFailed([String? message]) = _SubmitFailed;
  const factory SignUpEvent.errorMessage([String? message]) = _ErrorMessage;
}
