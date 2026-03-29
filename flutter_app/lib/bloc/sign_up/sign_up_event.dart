part of 'sign_up_bloc';

@freezed
abstract class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.nameChanged(String name) = _NameChanged;
  const factory RegisterEvent.roleChanged(String role) = _RoleChanged;
  const factory RegisterEvent.emailChanged(String email) = _EmailChanged;
  const factory RegisterEvent.passwordChanged(String password) =
      _PasswordChanged;
  const factory RegisterEvent.medicalIdChanged(String id) = _MedicalIdChanged;
  const factory RegisterEvent.submitted() = _Submitted;
}
