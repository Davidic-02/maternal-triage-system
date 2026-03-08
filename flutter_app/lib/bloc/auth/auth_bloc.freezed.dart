// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent()';
  }
}

/// @nodoc
class $AuthEventCopyWith<$Res> {
  $AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}

/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthEvent value)? $default, {
    TResult Function(_EmailChanged value)? emailChanged,
    TResult Function(_PasswordChanged value)? passwordChanged,
    TResult Function(_Login value)? login,
    TResult Function(_LoginSuccessful value)? loginSuccessful,
    TResult Function(_LoginFailed value)? loginFailed,
    TResult Function(_ErrorMessage value)? errorMessage,
    TResult Function(_ForgotPassword value)? forgotPassword,
    TResult Function(_ForgotPasswordSuccessful value)? forgotPasswordSuccessful,
    TResult Function(_ForgotPasswordFailed value)? forgotPasswordFailed,
    TResult Function(_LogoutRequested value)? logoutRequested,
    TResult Function(_UserChanged value)? userChanged,
    TResult Function(_SessionExpired value)? sessionExpired,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthEvent() when $default != null:
        return $default(_that);
      case _EmailChanged() when emailChanged != null:
        return emailChanged(_that);
      case _PasswordChanged() when passwordChanged != null:
        return passwordChanged(_that);
      case _Login() when login != null:
        return login(_that);
      case _LoginSuccessful() when loginSuccessful != null:
        return loginSuccessful(_that);
      case _LoginFailed() when loginFailed != null:
        return loginFailed(_that);
      case _ErrorMessage() when errorMessage != null:
        return errorMessage(_that);
      case _ForgotPassword() when forgotPassword != null:
        return forgotPassword(_that);
      case _ForgotPasswordSuccessful() when forgotPasswordSuccessful != null:
        return forgotPasswordSuccessful(_that);
      case _ForgotPasswordFailed() when forgotPasswordFailed != null:
        return forgotPasswordFailed(_that);
      case _LogoutRequested() when logoutRequested != null:
        return logoutRequested(_that);
      case _UserChanged() when userChanged != null:
        return userChanged(_that);
      case _SessionExpired() when sessionExpired != null:
        return sessionExpired(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthEvent value) $default, {
    required TResult Function(_EmailChanged value) emailChanged,
    required TResult Function(_PasswordChanged value) passwordChanged,
    required TResult Function(_Login value) login,
    required TResult Function(_LoginSuccessful value) loginSuccessful,
    required TResult Function(_LoginFailed value) loginFailed,
    required TResult Function(_ErrorMessage value) errorMessage,
    required TResult Function(_ForgotPassword value) forgotPassword,
    required TResult Function(_ForgotPasswordSuccessful value)
        forgotPasswordSuccessful,
    required TResult Function(_ForgotPasswordFailed value) forgotPasswordFailed,
    required TResult Function(_LogoutRequested value) logoutRequested,
    required TResult Function(_UserChanged value) userChanged,
    required TResult Function(_SessionExpired value) sessionExpired,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthEvent():
        return $default(_that);
      case _EmailChanged():
        return emailChanged(_that);
      case _PasswordChanged():
        return passwordChanged(_that);
      case _Login():
        return login(_that);
      case _LoginSuccessful():
        return loginSuccessful(_that);
      case _LoginFailed():
        return loginFailed(_that);
      case _ErrorMessage():
        return errorMessage(_that);
      case _ForgotPassword():
        return forgotPassword(_that);
      case _ForgotPasswordSuccessful():
        return forgotPasswordSuccessful(_that);
      case _ForgotPasswordFailed():
        return forgotPasswordFailed(_that);
      case _LogoutRequested():
        return logoutRequested(_that);
      case _UserChanged():
        return userChanged(_that);
      case _SessionExpired():
        return sessionExpired(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthEvent value)? $default, {
    TResult? Function(_EmailChanged value)? emailChanged,
    TResult? Function(_PasswordChanged value)? passwordChanged,
    TResult? Function(_Login value)? login,
    TResult? Function(_LoginSuccessful value)? loginSuccessful,
    TResult? Function(_LoginFailed value)? loginFailed,
    TResult? Function(_ErrorMessage value)? errorMessage,
    TResult? Function(_ForgotPassword value)? forgotPassword,
    TResult? Function(_ForgotPasswordSuccessful value)?
        forgotPasswordSuccessful,
    TResult? Function(_ForgotPasswordFailed value)? forgotPasswordFailed,
    TResult? Function(_LogoutRequested value)? logoutRequested,
    TResult? Function(_UserChanged value)? userChanged,
    TResult? Function(_SessionExpired value)? sessionExpired,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthEvent() when $default != null:
        return $default(_that);
      case _EmailChanged() when emailChanged != null:
        return emailChanged(_that);
      case _PasswordChanged() when passwordChanged != null:
        return passwordChanged(_that);
      case _Login() when login != null:
        return login(_that);
      case _LoginSuccessful() when loginSuccessful != null:
        return loginSuccessful(_that);
      case _LoginFailed() when loginFailed != null:
        return loginFailed(_that);
      case _ErrorMessage() when errorMessage != null:
        return errorMessage(_that);
      case _ForgotPassword() when forgotPassword != null:
        return forgotPassword(_that);
      case _ForgotPasswordSuccessful() when forgotPasswordSuccessful != null:
        return forgotPasswordSuccessful(_that);
      case _ForgotPasswordFailed() when forgotPasswordFailed != null:
        return forgotPasswordFailed(_that);
      case _LogoutRequested() when logoutRequested != null:
        return logoutRequested(_that);
      case _UserChanged() when userChanged != null:
        return userChanged(_that);
      case _SessionExpired() when sessionExpired != null:
        return sessionExpired(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? login,
    TResult Function()? loginSuccessful,
    TResult Function(String? message)? loginFailed,
    TResult Function(String? message)? errorMessage,
    TResult Function()? forgotPassword,
    TResult Function()? forgotPasswordSuccessful,
    TResult Function(String? message)? forgotPasswordFailed,
    TResult Function()? logoutRequested,
    TResult Function()? userChanged,
    TResult Function()? sessionExpired,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthEvent() when $default != null:
        return $default();
      case _EmailChanged() when emailChanged != null:
        return emailChanged(_that.email);
      case _PasswordChanged() when passwordChanged != null:
        return passwordChanged(_that.password);
      case _Login() when login != null:
        return login();
      case _LoginSuccessful() when loginSuccessful != null:
        return loginSuccessful();
      case _LoginFailed() when loginFailed != null:
        return loginFailed(_that.message);
      case _ErrorMessage() when errorMessage != null:
        return errorMessage(_that.message);
      case _ForgotPassword() when forgotPassword != null:
        return forgotPassword();
      case _ForgotPasswordSuccessful() when forgotPasswordSuccessful != null:
        return forgotPasswordSuccessful();
      case _ForgotPasswordFailed() when forgotPasswordFailed != null:
        return forgotPasswordFailed(_that.message);
      case _LogoutRequested() when logoutRequested != null:
        return logoutRequested();
      case _UserChanged() when userChanged != null:
        return userChanged();
      case _SessionExpired() when sessionExpired != null:
        return sessionExpired();
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() login,
    required TResult Function() loginSuccessful,
    required TResult Function(String? message) loginFailed,
    required TResult Function(String? message) errorMessage,
    required TResult Function() forgotPassword,
    required TResult Function() forgotPasswordSuccessful,
    required TResult Function(String? message) forgotPasswordFailed,
    required TResult Function() logoutRequested,
    required TResult Function() userChanged,
    required TResult Function() sessionExpired,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthEvent():
        return $default();
      case _EmailChanged():
        return emailChanged(_that.email);
      case _PasswordChanged():
        return passwordChanged(_that.password);
      case _Login():
        return login();
      case _LoginSuccessful():
        return loginSuccessful();
      case _LoginFailed():
        return loginFailed(_that.message);
      case _ErrorMessage():
        return errorMessage(_that.message);
      case _ForgotPassword():
        return forgotPassword();
      case _ForgotPasswordSuccessful():
        return forgotPasswordSuccessful();
      case _ForgotPasswordFailed():
        return forgotPasswordFailed(_that.message);
      case _LogoutRequested():
        return logoutRequested();
      case _UserChanged():
        return userChanged();
      case _SessionExpired():
        return sessionExpired();
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function()? login,
    TResult? Function()? loginSuccessful,
    TResult? Function(String? message)? loginFailed,
    TResult? Function(String? message)? errorMessage,
    TResult? Function()? forgotPassword,
    TResult? Function()? forgotPasswordSuccessful,
    TResult? Function(String? message)? forgotPasswordFailed,
    TResult? Function()? logoutRequested,
    TResult? Function()? userChanged,
    TResult? Function()? sessionExpired,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthEvent() when $default != null:
        return $default();
      case _EmailChanged() when emailChanged != null:
        return emailChanged(_that.email);
      case _PasswordChanged() when passwordChanged != null:
        return passwordChanged(_that.password);
      case _Login() when login != null:
        return login();
      case _LoginSuccessful() when loginSuccessful != null:
        return loginSuccessful();
      case _LoginFailed() when loginFailed != null:
        return loginFailed(_that.message);
      case _ErrorMessage() when errorMessage != null:
        return errorMessage(_that.message);
      case _ForgotPassword() when forgotPassword != null:
        return forgotPassword();
      case _ForgotPasswordSuccessful() when forgotPasswordSuccessful != null:
        return forgotPasswordSuccessful();
      case _ForgotPasswordFailed() when forgotPasswordFailed != null:
        return forgotPasswordFailed(_that.message);
      case _LogoutRequested() when logoutRequested != null:
        return logoutRequested();
      case _UserChanged() when userChanged != null:
        return userChanged();
      case _SessionExpired() when sessionExpired != null:
        return sessionExpired();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AuthEvent implements AuthEvent {
  const _AuthEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _AuthEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent()';
  }
}

/// @nodoc

class _EmailChanged implements AuthEvent {
  const _EmailChanged(this.email);

  final String email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmailChangedCopyWith<_EmailChanged> get copyWith =>
      __$EmailChangedCopyWithImpl<_EmailChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmailChanged &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @override
  String toString() {
    return 'AuthEvent.emailChanged(email: $email)';
  }
}

/// @nodoc
abstract mixin class _$EmailChangedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory _$EmailChangedCopyWith(
          _EmailChanged value, $Res Function(_EmailChanged) _then) =
      __$EmailChangedCopyWithImpl;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$EmailChangedCopyWithImpl<$Res>
    implements _$EmailChangedCopyWith<$Res> {
  __$EmailChangedCopyWithImpl(this._self, this._then);

  final _EmailChanged _self;
  final $Res Function(_EmailChanged) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
  }) {
    return _then(_EmailChanged(
      null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _PasswordChanged implements AuthEvent {
  const _PasswordChanged(this.password);

  final String password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PasswordChangedCopyWith<_PasswordChanged> get copyWith =>
      __$PasswordChangedCopyWithImpl<_PasswordChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PasswordChanged &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password);

  @override
  String toString() {
    return 'AuthEvent.passwordChanged(password: $password)';
  }
}

/// @nodoc
abstract mixin class _$PasswordChangedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory _$PasswordChangedCopyWith(
          _PasswordChanged value, $Res Function(_PasswordChanged) _then) =
      __$PasswordChangedCopyWithImpl;
  @useResult
  $Res call({String password});
}

/// @nodoc
class __$PasswordChangedCopyWithImpl<$Res>
    implements _$PasswordChangedCopyWith<$Res> {
  __$PasswordChangedCopyWithImpl(this._self, this._then);

  final _PasswordChanged _self;
  final $Res Function(_PasswordChanged) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? password = null,
  }) {
    return _then(_PasswordChanged(
      null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Login implements AuthEvent {
  const _Login();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Login);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.login()';
  }
}

/// @nodoc

class _LoginSuccessful implements AuthEvent {
  const _LoginSuccessful();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LoginSuccessful);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.loginSuccessful()';
  }
}

/// @nodoc

class _LoginFailed implements AuthEvent {
  const _LoginFailed([this.message]);

  final String? message;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoginFailedCopyWith<_LoginFailed> get copyWith =>
      __$LoginFailedCopyWithImpl<_LoginFailed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginFailed &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AuthEvent.loginFailed(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$LoginFailedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory _$LoginFailedCopyWith(
          _LoginFailed value, $Res Function(_LoginFailed) _then) =
      __$LoginFailedCopyWithImpl;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$LoginFailedCopyWithImpl<$Res> implements _$LoginFailedCopyWith<$Res> {
  __$LoginFailedCopyWithImpl(this._self, this._then);

  final _LoginFailed _self;
  final $Res Function(_LoginFailed) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_LoginFailed(
      freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _ErrorMessage implements AuthEvent {
  const _ErrorMessage([this.message]);

  final String? message;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ErrorMessageCopyWith<_ErrorMessage> get copyWith =>
      __$ErrorMessageCopyWithImpl<_ErrorMessage>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ErrorMessage &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AuthEvent.errorMessage(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorMessageCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory _$ErrorMessageCopyWith(
          _ErrorMessage value, $Res Function(_ErrorMessage) _then) =
      __$ErrorMessageCopyWithImpl;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$ErrorMessageCopyWithImpl<$Res>
    implements _$ErrorMessageCopyWith<$Res> {
  __$ErrorMessageCopyWithImpl(this._self, this._then);

  final _ErrorMessage _self;
  final $Res Function(_ErrorMessage) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_ErrorMessage(
      freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _ForgotPassword implements AuthEvent {
  const _ForgotPassword();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ForgotPassword);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.forgotPassword()';
  }
}

/// @nodoc

class _ForgotPasswordSuccessful implements AuthEvent {
  const _ForgotPasswordSuccessful();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ForgotPasswordSuccessful);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.forgotPasswordSuccessful()';
  }
}

/// @nodoc

class _ForgotPasswordFailed implements AuthEvent {
  const _ForgotPasswordFailed([this.message]);

  final String? message;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ForgotPasswordFailedCopyWith<_ForgotPasswordFailed> get copyWith =>
      __$ForgotPasswordFailedCopyWithImpl<_ForgotPasswordFailed>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ForgotPasswordFailed &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AuthEvent.forgotPasswordFailed(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ForgotPasswordFailedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory _$ForgotPasswordFailedCopyWith(_ForgotPasswordFailed value,
          $Res Function(_ForgotPasswordFailed) _then) =
      __$ForgotPasswordFailedCopyWithImpl;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$ForgotPasswordFailedCopyWithImpl<$Res>
    implements _$ForgotPasswordFailedCopyWith<$Res> {
  __$ForgotPasswordFailedCopyWithImpl(this._self, this._then);

  final _ForgotPasswordFailed _self;
  final $Res Function(_ForgotPasswordFailed) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_ForgotPasswordFailed(
      freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _LogoutRequested implements AuthEvent {
  const _LogoutRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LogoutRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.logoutRequested()';
  }
}

/// @nodoc

class _UserChanged implements AuthEvent {
  const _UserChanged();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _UserChanged);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.userChanged()';
  }
}

/// @nodoc

class _SessionExpired implements AuthEvent {
  const _SessionExpired();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SessionExpired);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.sessionExpired()';
  }
}

/// @nodoc
mixin _$AuthState {
  String? get userEmail;
  EmailFormz get email;
  PasswordFormz get password;
  FormzSubmissionStatus get status;
  FormzSubmissionStatus get loginStatus;
  FormzSubmissionStatus get forgotPasswordStatus;
  String? get errorMessage;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthStateCopyWith<AuthState> get copyWith =>
      _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthState &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.loginStatus, loginStatus) ||
                other.loginStatus == loginStatus) &&
            (identical(other.forgotPasswordStatus, forgotPasswordStatus) ||
                other.forgotPasswordStatus == forgotPasswordStatus) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userEmail, email, password,
      status, loginStatus, forgotPasswordStatus, errorMessage);

  @override
  String toString() {
    return 'AuthState(userEmail: $userEmail, email: $email, password: $password, status: $status, loginStatus: $loginStatus, forgotPasswordStatus: $forgotPasswordStatus, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) =
      _$AuthStateCopyWithImpl;
  @useResult
  $Res call(
      {String? userEmail,
      EmailFormz email,
      PasswordFormz password,
      FormzSubmissionStatus status,
      FormzSubmissionStatus loginStatus,
      FormzSubmissionStatus forgotPasswordStatus,
      String? errorMessage});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userEmail = freezed,
    Object? email = null,
    Object? password = null,
    Object? status = null,
    Object? loginStatus = null,
    Object? forgotPasswordStatus = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      userEmail: freezed == userEmail
          ? _self.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as EmailFormz,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as PasswordFormz,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      loginStatus: null == loginStatus
          ? _self.loginStatus
          : loginStatus // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      forgotPasswordStatus: null == forgotPasswordStatus
          ? _self.forgotPasswordStatus
          : forgotPasswordStatus // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthState() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthState():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthState() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String? userEmail,
            EmailFormz email,
            PasswordFormz password,
            FormzSubmissionStatus status,
            FormzSubmissionStatus loginStatus,
            FormzSubmissionStatus forgotPasswordStatus,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthState() when $default != null:
        return $default(
            _that.userEmail,
            _that.email,
            _that.password,
            _that.status,
            _that.loginStatus,
            _that.forgotPasswordStatus,
            _that.errorMessage);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String? userEmail,
            EmailFormz email,
            PasswordFormz password,
            FormzSubmissionStatus status,
            FormzSubmissionStatus loginStatus,
            FormzSubmissionStatus forgotPasswordStatus,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthState():
        return $default(
            _that.userEmail,
            _that.email,
            _that.password,
            _that.status,
            _that.loginStatus,
            _that.forgotPasswordStatus,
            _that.errorMessage);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String? userEmail,
            EmailFormz email,
            PasswordFormz password,
            FormzSubmissionStatus status,
            FormzSubmissionStatus loginStatus,
            FormzSubmissionStatus forgotPasswordStatus,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthState() when $default != null:
        return $default(
            _that.userEmail,
            _that.email,
            _that.password,
            _that.status,
            _that.loginStatus,
            _that.forgotPasswordStatus,
            _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AuthState extends AuthState {
  const _AuthState(
      {this.userEmail,
      this.email = const EmailFormz.pure(),
      this.password = const PasswordFormz.pure(),
      this.status = FormzSubmissionStatus.initial,
      this.loginStatus = FormzSubmissionStatus.initial,
      this.forgotPasswordStatus = FormzSubmissionStatus.initial,
      this.errorMessage})
      : super._();

  @override
  final String? userEmail;
  @override
  @JsonKey()
  final EmailFormz email;
  @override
  @JsonKey()
  final PasswordFormz password;
  @override
  @JsonKey()
  final FormzSubmissionStatus status;
  @override
  @JsonKey()
  final FormzSubmissionStatus loginStatus;
  @override
  @JsonKey()
  final FormzSubmissionStatus forgotPasswordStatus;
  @override
  final String? errorMessage;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthStateCopyWith<_AuthState> get copyWith =>
      __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthState &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.loginStatus, loginStatus) ||
                other.loginStatus == loginStatus) &&
            (identical(other.forgotPasswordStatus, forgotPasswordStatus) ||
                other.forgotPasswordStatus == forgotPasswordStatus) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userEmail, email, password,
      status, loginStatus, forgotPasswordStatus, errorMessage);

  @override
  String toString() {
    return 'AuthState(userEmail: $userEmail, email: $email, password: $password, status: $status, loginStatus: $loginStatus, forgotPasswordStatus: $forgotPasswordStatus, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(
          _AuthState value, $Res Function(_AuthState) _then) =
      __$AuthStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? userEmail,
      EmailFormz email,
      PasswordFormz password,
      FormzSubmissionStatus status,
      FormzSubmissionStatus loginStatus,
      FormzSubmissionStatus forgotPasswordStatus,
      String? errorMessage});
}

/// @nodoc
class __$AuthStateCopyWithImpl<$Res> implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userEmail = freezed,
    Object? email = null,
    Object? password = null,
    Object? status = null,
    Object? loginStatus = null,
    Object? forgotPasswordStatus = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_AuthState(
      userEmail: freezed == userEmail
          ? _self.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as EmailFormz,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as PasswordFormz,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      loginStatus: null == loginStatus
          ? _self.loginStatus
          : loginStatus // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      forgotPasswordStatus: null == forgotPasswordStatus
          ? _self.forgotPasswordStatus
          : forgotPasswordStatus // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
