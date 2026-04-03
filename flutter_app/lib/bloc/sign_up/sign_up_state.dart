part of 'sign_up_bloc.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const SignUpState._();
  const factory SignUpState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(0) int currentStep,
    @Default(EmailFormz.pure()) EmailFormz email,
    @Default(PasswordFormz.pure()) PasswordFormz password,
    @Default(PasswordConfirmFormz.pure()) PasswordConfirmFormz passwordConfirm,
    @Default(NameFormz.pure()) NameFormz name,
    @Default(RoleFormz.pure()) RoleFormz role,
    @Default(MedicalIdFormz.pure()) MedicalIdFormz medicalId,
    @Default(false) bool isPasswordVisible,
    String? errorMessage,
  }) = _SignUpState;

  bool get isFormValid =>
      email.isValid &&
      password.isValid &&
      name.isValid &&
      role.isValid &&
      medicalId.isValid;

  bool get isStepOneValid => name.isValid && email.isValid && password.isValid;

  bool get isStepTwoValid => role.isValid && medicalId.isValid;
}

class EmailFormz extends FormzInput<String, ValidationError> {
  const EmailFormz.pure([super.value = '']) : super.pure();
  const EmailFormz.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty;

    if (!EmailValidator.validate(value.trim())) {
      return ValidationError.invalid;
    }

    return null;
  }
}

class PasswordFormz extends FormzInput<String, ValidationError> {
  const PasswordFormz.pure([super.value = '']) : super.pure();
  const PasswordFormz.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty;

    if (value.length < 6) {
      return ValidationError.short;
    }

    return null;
  }
}

class PasswordConfirmFormz extends FormzInput<String, ValidationError> {
  final String password; // need to compare with actual password

  const PasswordConfirmFormz.pure([this.password = '', super.value = ''])
    : super.pure();
  const PasswordConfirmFormz.dirty(this.password, [String value = ''])
    : super.dirty(value);

  @override
  ValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty;
    if (value != password) return ValidationError.invalid; // mismatch
    return null;
  }
}

class NameFormz extends FormzInput<String, ValidationError> {
  const NameFormz.pure([super.value = '']) : super.pure();
  const NameFormz.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty;
    if (value.length < 3) return ValidationError.short;
    return null;
  }
}

class RoleFormz extends FormzInput<String, ValidationError> {
  const RoleFormz.pure([super.value = '']) : super.pure();
  const RoleFormz.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty;
    return null;
  }
}

class MedicalIdFormz extends FormzInput<String, ValidationError> {
  const MedicalIdFormz.pure([super.value = '']) : super.pure();
  const MedicalIdFormz.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty;
    if (value.length < 5) return ValidationError.short;
    return null;
  }
}
