// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpEvent()';
}


}

/// @nodoc
class $SignUpEventCopyWith<$Res>  {
$SignUpEventCopyWith(SignUpEvent _, $Res Function(SignUpEvent) __);
}


/// Adds pattern-matching-related methods to [SignUpEvent].
extension SignUpEventPatterns on SignUpEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpEvent value)?  $default,{TResult Function( _NameChanged value)?  nameChanged,TResult Function( _RoleChanged value)?  roleChanged,TResult Function( _EmailChanged value)?  emailChanged,TResult Function( _PasswordChanged value)?  passwordChanged,TResult Function( _ConfirmPasswordChanged value)?  confirmPasswordChanged,TResult Function( _MedicalIdChanged value)?  medicalIdChanged,TResult Function( _ValidateStepOne value)?  validateStepOne,TResult Function( _ValidateStepTwo value)?  validateStepTwo,TResult Function( _StepChanged value)?  stepChanged,TResult Function( _PasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult Function( _Submit value)?  submit,TResult Function( _SubmitSuccessful value)?  submitSuccessful,TResult Function( _SubmitFailed value)?  submitFailed,TResult Function( _ErrorMessage value)?  errorMessage,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpEvent() when $default != null:
return $default(_that);case _NameChanged() when nameChanged != null:
return nameChanged(_that);case _RoleChanged() when roleChanged != null:
return roleChanged(_that);case _EmailChanged() when emailChanged != null:
return emailChanged(_that);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case _ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that);case _MedicalIdChanged() when medicalIdChanged != null:
return medicalIdChanged(_that);case _ValidateStepOne() when validateStepOne != null:
return validateStepOne(_that);case _ValidateStepTwo() when validateStepTwo != null:
return validateStepTwo(_that);case _StepChanged() when stepChanged != null:
return stepChanged(_that);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled(_that);case _Submit() when submit != null:
return submit(_that);case _SubmitSuccessful() when submitSuccessful != null:
return submitSuccessful(_that);case _SubmitFailed() when submitFailed != null:
return submitFailed(_that);case _ErrorMessage() when errorMessage != null:
return errorMessage(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpEvent value)  $default,{required TResult Function( _NameChanged value)  nameChanged,required TResult Function( _RoleChanged value)  roleChanged,required TResult Function( _EmailChanged value)  emailChanged,required TResult Function( _PasswordChanged value)  passwordChanged,required TResult Function( _ConfirmPasswordChanged value)  confirmPasswordChanged,required TResult Function( _MedicalIdChanged value)  medicalIdChanged,required TResult Function( _ValidateStepOne value)  validateStepOne,required TResult Function( _ValidateStepTwo value)  validateStepTwo,required TResult Function( _StepChanged value)  stepChanged,required TResult Function( _PasswordVisibilityToggled value)  passwordVisibilityToggled,required TResult Function( _Submit value)  submit,required TResult Function( _SubmitSuccessful value)  submitSuccessful,required TResult Function( _SubmitFailed value)  submitFailed,required TResult Function( _ErrorMessage value)  errorMessage,}){
final _that = this;
switch (_that) {
case _SignUpEvent():
return $default(_that);case _NameChanged():
return nameChanged(_that);case _RoleChanged():
return roleChanged(_that);case _EmailChanged():
return emailChanged(_that);case _PasswordChanged():
return passwordChanged(_that);case _ConfirmPasswordChanged():
return confirmPasswordChanged(_that);case _MedicalIdChanged():
return medicalIdChanged(_that);case _ValidateStepOne():
return validateStepOne(_that);case _ValidateStepTwo():
return validateStepTwo(_that);case _StepChanged():
return stepChanged(_that);case _PasswordVisibilityToggled():
return passwordVisibilityToggled(_that);case _Submit():
return submit(_that);case _SubmitSuccessful():
return submitSuccessful(_that);case _SubmitFailed():
return submitFailed(_that);case _ErrorMessage():
return errorMessage(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpEvent value)?  $default,{TResult? Function( _NameChanged value)?  nameChanged,TResult? Function( _RoleChanged value)?  roleChanged,TResult? Function( _EmailChanged value)?  emailChanged,TResult? Function( _PasswordChanged value)?  passwordChanged,TResult? Function( _ConfirmPasswordChanged value)?  confirmPasswordChanged,TResult? Function( _MedicalIdChanged value)?  medicalIdChanged,TResult? Function( _ValidateStepOne value)?  validateStepOne,TResult? Function( _ValidateStepTwo value)?  validateStepTwo,TResult? Function( _StepChanged value)?  stepChanged,TResult? Function( _PasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult? Function( _Submit value)?  submit,TResult? Function( _SubmitSuccessful value)?  submitSuccessful,TResult? Function( _SubmitFailed value)?  submitFailed,TResult? Function( _ErrorMessage value)?  errorMessage,}){
final _that = this;
switch (_that) {
case _SignUpEvent() when $default != null:
return $default(_that);case _NameChanged() when nameChanged != null:
return nameChanged(_that);case _RoleChanged() when roleChanged != null:
return roleChanged(_that);case _EmailChanged() when emailChanged != null:
return emailChanged(_that);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case _ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that);case _MedicalIdChanged() when medicalIdChanged != null:
return medicalIdChanged(_that);case _ValidateStepOne() when validateStepOne != null:
return validateStepOne(_that);case _ValidateStepTwo() when validateStepTwo != null:
return validateStepTwo(_that);case _StepChanged() when stepChanged != null:
return stepChanged(_that);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled(_that);case _Submit() when submit != null:
return submit(_that);case _SubmitSuccessful() when submitSuccessful != null:
return submitSuccessful(_that);case _SubmitFailed() when submitFailed != null:
return submitFailed(_that);case _ErrorMessage() when errorMessage != null:
return errorMessage(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function()?  $default,{TResult Function( String name)?  nameChanged,TResult Function( String role)?  roleChanged,TResult Function( String email)?  emailChanged,TResult Function( String password)?  passwordChanged,TResult Function( String value)?  confirmPasswordChanged,TResult Function( String id)?  medicalIdChanged,TResult Function()?  validateStepOne,TResult Function()?  validateStepTwo,TResult Function( int step)?  stepChanged,TResult Function()?  passwordVisibilityToggled,TResult Function()?  submit,TResult Function()?  submitSuccessful,TResult Function( String? message)?  submitFailed,TResult Function( String? message)?  errorMessage,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpEvent() when $default != null:
return $default();case _NameChanged() when nameChanged != null:
return nameChanged(_that.name);case _RoleChanged() when roleChanged != null:
return roleChanged(_that.role);case _EmailChanged() when emailChanged != null:
return emailChanged(_that.email);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that.password);case _ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that.value);case _MedicalIdChanged() when medicalIdChanged != null:
return medicalIdChanged(_that.id);case _ValidateStepOne() when validateStepOne != null:
return validateStepOne();case _ValidateStepTwo() when validateStepTwo != null:
return validateStepTwo();case _StepChanged() when stepChanged != null:
return stepChanged(_that.step);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case _Submit() when submit != null:
return submit();case _SubmitSuccessful() when submitSuccessful != null:
return submitSuccessful();case _SubmitFailed() when submitFailed != null:
return submitFailed(_that.message);case _ErrorMessage() when errorMessage != null:
return errorMessage(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function()  $default,{required TResult Function( String name)  nameChanged,required TResult Function( String role)  roleChanged,required TResult Function( String email)  emailChanged,required TResult Function( String password)  passwordChanged,required TResult Function( String value)  confirmPasswordChanged,required TResult Function( String id)  medicalIdChanged,required TResult Function()  validateStepOne,required TResult Function()  validateStepTwo,required TResult Function( int step)  stepChanged,required TResult Function()  passwordVisibilityToggled,required TResult Function()  submit,required TResult Function()  submitSuccessful,required TResult Function( String? message)  submitFailed,required TResult Function( String? message)  errorMessage,}) {final _that = this;
switch (_that) {
case _SignUpEvent():
return $default();case _NameChanged():
return nameChanged(_that.name);case _RoleChanged():
return roleChanged(_that.role);case _EmailChanged():
return emailChanged(_that.email);case _PasswordChanged():
return passwordChanged(_that.password);case _ConfirmPasswordChanged():
return confirmPasswordChanged(_that.value);case _MedicalIdChanged():
return medicalIdChanged(_that.id);case _ValidateStepOne():
return validateStepOne();case _ValidateStepTwo():
return validateStepTwo();case _StepChanged():
return stepChanged(_that.step);case _PasswordVisibilityToggled():
return passwordVisibilityToggled();case _Submit():
return submit();case _SubmitSuccessful():
return submitSuccessful();case _SubmitFailed():
return submitFailed(_that.message);case _ErrorMessage():
return errorMessage(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function()?  $default,{TResult? Function( String name)?  nameChanged,TResult? Function( String role)?  roleChanged,TResult? Function( String email)?  emailChanged,TResult? Function( String password)?  passwordChanged,TResult? Function( String value)?  confirmPasswordChanged,TResult? Function( String id)?  medicalIdChanged,TResult? Function()?  validateStepOne,TResult? Function()?  validateStepTwo,TResult? Function( int step)?  stepChanged,TResult? Function()?  passwordVisibilityToggled,TResult? Function()?  submit,TResult? Function()?  submitSuccessful,TResult? Function( String? message)?  submitFailed,TResult? Function( String? message)?  errorMessage,}) {final _that = this;
switch (_that) {
case _SignUpEvent() when $default != null:
return $default();case _NameChanged() when nameChanged != null:
return nameChanged(_that.name);case _RoleChanged() when roleChanged != null:
return roleChanged(_that.role);case _EmailChanged() when emailChanged != null:
return emailChanged(_that.email);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that.password);case _ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that.value);case _MedicalIdChanged() when medicalIdChanged != null:
return medicalIdChanged(_that.id);case _ValidateStepOne() when validateStepOne != null:
return validateStepOne();case _ValidateStepTwo() when validateStepTwo != null:
return validateStepTwo();case _StepChanged() when stepChanged != null:
return stepChanged(_that.step);case _PasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case _Submit() when submit != null:
return submit();case _SubmitSuccessful() when submitSuccessful != null:
return submitSuccessful();case _SubmitFailed() when submitFailed != null:
return submitFailed(_that.message);case _ErrorMessage() when errorMessage != null:
return errorMessage(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpEvent implements SignUpEvent {
  const _SignUpEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpEvent()';
}


}




/// @nodoc


class _NameChanged implements SignUpEvent {
  const _NameChanged(this.name);
  

 final  String name;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NameChangedCopyWith<_NameChanged> get copyWith => __$NameChangedCopyWithImpl<_NameChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NameChanged&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'SignUpEvent.nameChanged(name: $name)';
}


}

/// @nodoc
abstract mixin class _$NameChangedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$NameChangedCopyWith(_NameChanged value, $Res Function(_NameChanged) _then) = __$NameChangedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class __$NameChangedCopyWithImpl<$Res>
    implements _$NameChangedCopyWith<$Res> {
  __$NameChangedCopyWithImpl(this._self, this._then);

  final _NameChanged _self;
  final $Res Function(_NameChanged) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_NameChanged(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RoleChanged implements SignUpEvent {
  const _RoleChanged(this.role);
  

 final  String role;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoleChangedCopyWith<_RoleChanged> get copyWith => __$RoleChangedCopyWithImpl<_RoleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoleChanged&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,role);

@override
String toString() {
  return 'SignUpEvent.roleChanged(role: $role)';
}


}

/// @nodoc
abstract mixin class _$RoleChangedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$RoleChangedCopyWith(_RoleChanged value, $Res Function(_RoleChanged) _then) = __$RoleChangedCopyWithImpl;
@useResult
$Res call({
 String role
});




}
/// @nodoc
class __$RoleChangedCopyWithImpl<$Res>
    implements _$RoleChangedCopyWith<$Res> {
  __$RoleChangedCopyWithImpl(this._self, this._then);

  final _RoleChanged _self;
  final $Res Function(_RoleChanged) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? role = null,}) {
  return _then(_RoleChanged(
null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _EmailChanged implements SignUpEvent {
  const _EmailChanged(this.email);
  

 final  String email;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailChangedCopyWith<_EmailChanged> get copyWith => __$EmailChangedCopyWithImpl<_EmailChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailChanged&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'SignUpEvent.emailChanged(email: $email)';
}


}

/// @nodoc
abstract mixin class _$EmailChangedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$EmailChangedCopyWith(_EmailChanged value, $Res Function(_EmailChanged) _then) = __$EmailChangedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$EmailChangedCopyWithImpl<$Res>
    implements _$EmailChangedCopyWith<$Res> {
  __$EmailChangedCopyWithImpl(this._self, this._then);

  final _EmailChanged _self;
  final $Res Function(_EmailChanged) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_EmailChanged(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PasswordChanged implements SignUpEvent {
  const _PasswordChanged(this.password);
  

 final  String password;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordChangedCopyWith<_PasswordChanged> get copyWith => __$PasswordChangedCopyWithImpl<_PasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordChanged&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'SignUpEvent.passwordChanged(password: $password)';
}


}

/// @nodoc
abstract mixin class _$PasswordChangedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$PasswordChangedCopyWith(_PasswordChanged value, $Res Function(_PasswordChanged) _then) = __$PasswordChangedCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class __$PasswordChangedCopyWithImpl<$Res>
    implements _$PasswordChangedCopyWith<$Res> {
  __$PasswordChangedCopyWithImpl(this._self, this._then);

  final _PasswordChanged _self;
  final $Res Function(_PasswordChanged) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(_PasswordChanged(
null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ConfirmPasswordChanged implements SignUpEvent {
  const _ConfirmPasswordChanged(this.value);
  

 final  String value;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmPasswordChangedCopyWith<_ConfirmPasswordChanged> get copyWith => __$ConfirmPasswordChangedCopyWithImpl<_ConfirmPasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmPasswordChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SignUpEvent.confirmPasswordChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$ConfirmPasswordChangedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$ConfirmPasswordChangedCopyWith(_ConfirmPasswordChanged value, $Res Function(_ConfirmPasswordChanged) _then) = __$ConfirmPasswordChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$ConfirmPasswordChangedCopyWithImpl<$Res>
    implements _$ConfirmPasswordChangedCopyWith<$Res> {
  __$ConfirmPasswordChangedCopyWithImpl(this._self, this._then);

  final _ConfirmPasswordChanged _self;
  final $Res Function(_ConfirmPasswordChanged) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_ConfirmPasswordChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MedicalIdChanged implements SignUpEvent {
  const _MedicalIdChanged(this.id);
  

 final  String id;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedicalIdChangedCopyWith<_MedicalIdChanged> get copyWith => __$MedicalIdChangedCopyWithImpl<_MedicalIdChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedicalIdChanged&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'SignUpEvent.medicalIdChanged(id: $id)';
}


}

/// @nodoc
abstract mixin class _$MedicalIdChangedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$MedicalIdChangedCopyWith(_MedicalIdChanged value, $Res Function(_MedicalIdChanged) _then) = __$MedicalIdChangedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$MedicalIdChangedCopyWithImpl<$Res>
    implements _$MedicalIdChangedCopyWith<$Res> {
  __$MedicalIdChangedCopyWithImpl(this._self, this._then);

  final _MedicalIdChanged _self;
  final $Res Function(_MedicalIdChanged) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_MedicalIdChanged(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ValidateStepOne implements SignUpEvent {
  const _ValidateStepOne();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidateStepOne);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpEvent.validateStepOne()';
}


}




/// @nodoc


class _ValidateStepTwo implements SignUpEvent {
  const _ValidateStepTwo();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidateStepTwo);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpEvent.validateStepTwo()';
}


}




/// @nodoc


class _StepChanged implements SignUpEvent {
  const _StepChanged(this.step);
  

 final  int step;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepChangedCopyWith<_StepChanged> get copyWith => __$StepChangedCopyWithImpl<_StepChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepChanged&&(identical(other.step, step) || other.step == step));
}


@override
int get hashCode => Object.hash(runtimeType,step);

@override
String toString() {
  return 'SignUpEvent.stepChanged(step: $step)';
}


}

/// @nodoc
abstract mixin class _$StepChangedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$StepChangedCopyWith(_StepChanged value, $Res Function(_StepChanged) _then) = __$StepChangedCopyWithImpl;
@useResult
$Res call({
 int step
});




}
/// @nodoc
class __$StepChangedCopyWithImpl<$Res>
    implements _$StepChangedCopyWith<$Res> {
  __$StepChangedCopyWithImpl(this._self, this._then);

  final _StepChanged _self;
  final $Res Function(_StepChanged) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? step = null,}) {
  return _then(_StepChanged(
null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _PasswordVisibilityToggled implements SignUpEvent {
  const _PasswordVisibilityToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordVisibilityToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpEvent.passwordVisibilityToggled()';
}


}




/// @nodoc


class _Submit implements SignUpEvent {
  const _Submit();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submit);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpEvent.submit()';
}


}




/// @nodoc


class _SubmitSuccessful implements SignUpEvent {
  const _SubmitSuccessful();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitSuccessful);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpEvent.submitSuccessful()';
}


}




/// @nodoc


class _SubmitFailed implements SignUpEvent {
  const _SubmitFailed([this.message]);
  

 final  String? message;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitFailedCopyWith<_SubmitFailed> get copyWith => __$SubmitFailedCopyWithImpl<_SubmitFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SignUpEvent.submitFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SubmitFailedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$SubmitFailedCopyWith(_SubmitFailed value, $Res Function(_SubmitFailed) _then) = __$SubmitFailedCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$SubmitFailedCopyWithImpl<$Res>
    implements _$SubmitFailedCopyWith<$Res> {
  __$SubmitFailedCopyWithImpl(this._self, this._then);

  final _SubmitFailed _self;
  final $Res Function(_SubmitFailed) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_SubmitFailed(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ErrorMessage implements SignUpEvent {
  const _ErrorMessage([this.message]);
  

 final  String? message;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorMessageCopyWith<_ErrorMessage> get copyWith => __$ErrorMessageCopyWithImpl<_ErrorMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorMessage&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SignUpEvent.errorMessage(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorMessageCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$ErrorMessageCopyWith(_ErrorMessage value, $Res Function(_ErrorMessage) _then) = __$ErrorMessageCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$ErrorMessageCopyWithImpl<$Res>
    implements _$ErrorMessageCopyWith<$Res> {
  __$ErrorMessageCopyWithImpl(this._self, this._then);

  final _ErrorMessage _self;
  final $Res Function(_ErrorMessage) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_ErrorMessage(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SignUpState {

 FormzSubmissionStatus get status; int get currentStep; EmailFormz get email; PasswordFormz get password; PasswordConfirmFormz get passwordConfirm; NameFormz get name; RoleFormz get role; MedicalIdFormz get medicalId; bool get isPasswordVisible; String? get errorMessage;
/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpStateCopyWith<SignUpState> get copyWith => _$SignUpStateCopyWithImpl<SignUpState>(this as SignUpState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState&&(identical(other.status, status) || other.status == status)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirm, passwordConfirm) || other.passwordConfirm == passwordConfirm)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.medicalId, medicalId) || other.medicalId == medicalId)&&(identical(other.isPasswordVisible, isPasswordVisible) || other.isPasswordVisible == isPasswordVisible)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,currentStep,email,password,passwordConfirm,name,role,medicalId,isPasswordVisible,errorMessage);

@override
String toString() {
  return 'SignUpState(status: $status, currentStep: $currentStep, email: $email, password: $password, passwordConfirm: $passwordConfirm, name: $name, role: $role, medicalId: $medicalId, isPasswordVisible: $isPasswordVisible, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SignUpStateCopyWith<$Res>  {
  factory $SignUpStateCopyWith(SignUpState value, $Res Function(SignUpState) _then) = _$SignUpStateCopyWithImpl;
@useResult
$Res call({
 FormzSubmissionStatus status, int currentStep, EmailFormz email, PasswordFormz password, PasswordConfirmFormz passwordConfirm, NameFormz name, RoleFormz role, MedicalIdFormz medicalId, bool isPasswordVisible, String? errorMessage
});




}
/// @nodoc
class _$SignUpStateCopyWithImpl<$Res>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._self, this._then);

  final SignUpState _self;
  final $Res Function(SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? currentStep = null,Object? email = null,Object? password = null,Object? passwordConfirm = null,Object? name = null,Object? role = null,Object? medicalId = null,Object? isPasswordVisible = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as EmailFormz,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as PasswordFormz,passwordConfirm: null == passwordConfirm ? _self.passwordConfirm : passwordConfirm // ignore: cast_nullable_to_non_nullable
as PasswordConfirmFormz,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as NameFormz,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as RoleFormz,medicalId: null == medicalId ? _self.medicalId : medicalId // ignore: cast_nullable_to_non_nullable
as MedicalIdFormz,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SignUpState].
extension SignUpStatePatterns on SignUpState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpState value)  $default,){
final _that = this;
switch (_that) {
case _SignUpState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpState value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FormzSubmissionStatus status,  int currentStep,  EmailFormz email,  PasswordFormz password,  PasswordConfirmFormz passwordConfirm,  NameFormz name,  RoleFormz role,  MedicalIdFormz medicalId,  bool isPasswordVisible,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.status,_that.currentStep,_that.email,_that.password,_that.passwordConfirm,_that.name,_that.role,_that.medicalId,_that.isPasswordVisible,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FormzSubmissionStatus status,  int currentStep,  EmailFormz email,  PasswordFormz password,  PasswordConfirmFormz passwordConfirm,  NameFormz name,  RoleFormz role,  MedicalIdFormz medicalId,  bool isPasswordVisible,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SignUpState():
return $default(_that.status,_that.currentStep,_that.email,_that.password,_that.passwordConfirm,_that.name,_that.role,_that.medicalId,_that.isPasswordVisible,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FormzSubmissionStatus status,  int currentStep,  EmailFormz email,  PasswordFormz password,  PasswordConfirmFormz passwordConfirm,  NameFormz name,  RoleFormz role,  MedicalIdFormz medicalId,  bool isPasswordVisible,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.status,_that.currentStep,_that.email,_that.password,_that.passwordConfirm,_that.name,_that.role,_that.medicalId,_that.isPasswordVisible,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpState extends SignUpState {
  const _SignUpState({this.status = FormzSubmissionStatus.initial, this.currentStep = 0, this.email = const EmailFormz.pure(), this.password = const PasswordFormz.pure(), this.passwordConfirm = const PasswordConfirmFormz.pure(), this.name = const NameFormz.pure(), this.role = const RoleFormz.pure(), this.medicalId = const MedicalIdFormz.pure(), this.isPasswordVisible = false, this.errorMessage}): super._();
  

@override@JsonKey() final  FormzSubmissionStatus status;
@override@JsonKey() final  int currentStep;
@override@JsonKey() final  EmailFormz email;
@override@JsonKey() final  PasswordFormz password;
@override@JsonKey() final  PasswordConfirmFormz passwordConfirm;
@override@JsonKey() final  NameFormz name;
@override@JsonKey() final  RoleFormz role;
@override@JsonKey() final  MedicalIdFormz medicalId;
@override@JsonKey() final  bool isPasswordVisible;
@override final  String? errorMessage;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpStateCopyWith<_SignUpState> get copyWith => __$SignUpStateCopyWithImpl<_SignUpState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpState&&(identical(other.status, status) || other.status == status)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirm, passwordConfirm) || other.passwordConfirm == passwordConfirm)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.medicalId, medicalId) || other.medicalId == medicalId)&&(identical(other.isPasswordVisible, isPasswordVisible) || other.isPasswordVisible == isPasswordVisible)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,currentStep,email,password,passwordConfirm,name,role,medicalId,isPasswordVisible,errorMessage);

@override
String toString() {
  return 'SignUpState(status: $status, currentStep: $currentStep, email: $email, password: $password, passwordConfirm: $passwordConfirm, name: $name, role: $role, medicalId: $medicalId, isPasswordVisible: $isPasswordVisible, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SignUpStateCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory _$SignUpStateCopyWith(_SignUpState value, $Res Function(_SignUpState) _then) = __$SignUpStateCopyWithImpl;
@override @useResult
$Res call({
 FormzSubmissionStatus status, int currentStep, EmailFormz email, PasswordFormz password, PasswordConfirmFormz passwordConfirm, NameFormz name, RoleFormz role, MedicalIdFormz medicalId, bool isPasswordVisible, String? errorMessage
});




}
/// @nodoc
class __$SignUpStateCopyWithImpl<$Res>
    implements _$SignUpStateCopyWith<$Res> {
  __$SignUpStateCopyWithImpl(this._self, this._then);

  final _SignUpState _self;
  final $Res Function(_SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? currentStep = null,Object? email = null,Object? password = null,Object? passwordConfirm = null,Object? name = null,Object? role = null,Object? medicalId = null,Object? isPasswordVisible = null,Object? errorMessage = freezed,}) {
  return _then(_SignUpState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as EmailFormz,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as PasswordFormz,passwordConfirm: null == passwordConfirm ? _self.passwordConfirm : passwordConfirm // ignore: cast_nullable_to_non_nullable
as PasswordConfirmFormz,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as NameFormz,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as RoleFormz,medicalId: null == medicalId ? _self.medicalId : medicalId // ignore: cast_nullable_to_non_nullable
as MedicalIdFormz,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
