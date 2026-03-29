import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:formz/formz.dart';
import 'package:maternal_triage/enums/validator_error.dart';
import 'package:maternal_triage/models/doctor_model.dart';
import '../../services/logging_helper.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';
part 'sign_up_bloc.freezed.dart';



class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<_NameChanged>(_onNameChanged);
    on<_RoleChanged>(_onRoleChanged);
    on<_EmailChanged>(_onEmailChanged);
    on<_PasswordChanged>(_onPasswordChanged);
    on<_MedicalIdChanged>(_onMedicalIdChanged);
    on<_Submit>(_onSubmit);
    on<_SubmitSuccessful>(_onSubmitSuccessful);
    on<_SubmitFailed>(_onSubmitFailed);
    on<_ErrorMessage>(_onErrorMessage);
  }

