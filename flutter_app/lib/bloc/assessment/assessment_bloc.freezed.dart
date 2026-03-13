// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assessment_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssessmentEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AssessmentEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AssessmentEvent()';
  }
}

/// @nodoc
class $AssessmentEventCopyWith<$Res> {
  $AssessmentEventCopyWith(
      AssessmentEvent _, $Res Function(AssessmentEvent) __);
}

/// Adds pattern-matching-related methods to [AssessmentEvent].
extension AssessmentEventPatterns on AssessmentEvent {
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
    TResult Function(_AssessmentEvent value)? $default, {
    TResult Function(_RunAssessment value)? runAssessment,
    TResult Function(_ClearAssessment value)? clearAssessment,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AssessmentEvent() when $default != null:
        return $default(_that);
      case _RunAssessment() when runAssessment != null:
        return runAssessment(_that);
      case _ClearAssessment() when clearAssessment != null:
        return clearAssessment(_that);
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
    TResult Function(_AssessmentEvent value) $default, {
    required TResult Function(_RunAssessment value) runAssessment,
    required TResult Function(_ClearAssessment value) clearAssessment,
  }) {
    final _that = this;
    switch (_that) {
      case _AssessmentEvent():
        return $default(_that);
      case _RunAssessment():
        return runAssessment(_that);
      case _ClearAssessment():
        return clearAssessment(_that);
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
    TResult? Function(_AssessmentEvent value)? $default, {
    TResult? Function(_RunAssessment value)? runAssessment,
    TResult? Function(_ClearAssessment value)? clearAssessment,
  }) {
    final _that = this;
    switch (_that) {
      case _AssessmentEvent() when $default != null:
        return $default(_that);
      case _RunAssessment() when runAssessment != null:
        return runAssessment(_that);
      case _ClearAssessment() when clearAssessment != null:
        return clearAssessment(_that);
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
    TResult Function(PatientRecord patientRecord)? runAssessment,
    TResult Function()? clearAssessment,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AssessmentEvent() when $default != null:
        return $default();
      case _RunAssessment() when runAssessment != null:
        return runAssessment(_that.patientRecord);
      case _ClearAssessment() when clearAssessment != null:
        return clearAssessment();
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
    required TResult Function(PatientRecord patientRecord) runAssessment,
    required TResult Function() clearAssessment,
  }) {
    final _that = this;
    switch (_that) {
      case _AssessmentEvent():
        return $default();
      case _RunAssessment():
        return runAssessment(_that.patientRecord);
      case _ClearAssessment():
        return clearAssessment();
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
    TResult? Function(PatientRecord patientRecord)? runAssessment,
    TResult? Function()? clearAssessment,
  }) {
    final _that = this;
    switch (_that) {
      case _AssessmentEvent() when $default != null:
        return $default();
      case _RunAssessment() when runAssessment != null:
        return runAssessment(_that.patientRecord);
      case _ClearAssessment() when clearAssessment != null:
        return clearAssessment();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AssessmentEvent implements AssessmentEvent {
  const _AssessmentEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _AssessmentEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AssessmentEvent()';
  }
}

/// @nodoc

class _RunAssessment implements AssessmentEvent {
  const _RunAssessment(this.patientRecord);

  final PatientRecord patientRecord;

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RunAssessmentCopyWith<_RunAssessment> get copyWith =>
      __$RunAssessmentCopyWithImpl<_RunAssessment>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RunAssessment &&
            (identical(other.patientRecord, patientRecord) ||
                other.patientRecord == patientRecord));
  }

  @override
  int get hashCode => Object.hash(runtimeType, patientRecord);

  @override
  String toString() {
    return 'AssessmentEvent.runAssessment(patientRecord: $patientRecord)';
  }
}

/// @nodoc
abstract mixin class _$RunAssessmentCopyWith<$Res>
    implements $AssessmentEventCopyWith<$Res> {
  factory _$RunAssessmentCopyWith(
          _RunAssessment value, $Res Function(_RunAssessment) _then) =
      __$RunAssessmentCopyWithImpl;
  @useResult
  $Res call({PatientRecord patientRecord});
}

/// @nodoc
class __$RunAssessmentCopyWithImpl<$Res>
    implements _$RunAssessmentCopyWith<$Res> {
  __$RunAssessmentCopyWithImpl(this._self, this._then);

  final _RunAssessment _self;
  final $Res Function(_RunAssessment) _then;

  /// Create a copy of AssessmentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? patientRecord = null,
  }) {
    return _then(_RunAssessment(
      null == patientRecord
          ? _self.patientRecord
          : patientRecord // ignore: cast_nullable_to_non_nullable
              as PatientRecord,
    ));
  }
}

/// @nodoc

class _ClearAssessment implements AssessmentEvent {
  const _ClearAssessment();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ClearAssessment);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AssessmentEvent.clearAssessment()';
  }
}

/// @nodoc
mixin _$AssessmentState {
  PatientRecord? get record;
  RiskResult? get result;
  FormzSubmissionStatus get status;
  String? get errorMessage;

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssessmentStateCopyWith<AssessmentState> get copyWith =>
      _$AssessmentStateCopyWithImpl<AssessmentState>(
          this as AssessmentState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AssessmentState &&
            (identical(other.record, record) || other.record == record) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, record, result, status, errorMessage);

  @override
  String toString() {
    return 'AssessmentState(record: $record, result: $result, status: $status, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $AssessmentStateCopyWith<$Res> {
  factory $AssessmentStateCopyWith(
          AssessmentState value, $Res Function(AssessmentState) _then) =
      _$AssessmentStateCopyWithImpl;
  @useResult
  $Res call(
      {PatientRecord? record,
      RiskResult? result,
      FormzSubmissionStatus status,
      String? errorMessage});
}

/// @nodoc
class _$AssessmentStateCopyWithImpl<$Res>
    implements $AssessmentStateCopyWith<$Res> {
  _$AssessmentStateCopyWithImpl(this._self, this._then);

  final AssessmentState _self;
  final $Res Function(AssessmentState) _then;

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? record = freezed,
    Object? result = freezed,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      record: freezed == record
          ? _self.record
          : record // ignore: cast_nullable_to_non_nullable
              as PatientRecord?,
      result: freezed == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as RiskResult?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AssessmentState].
extension AssessmentStatePatterns on AssessmentState {
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
    TResult Function(_AssessmentState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AssessmentState() when $default != null:
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
    TResult Function(_AssessmentState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssessmentState():
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
    TResult? Function(_AssessmentState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssessmentState() when $default != null:
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
    TResult Function(PatientRecord? record, RiskResult? result,
            FormzSubmissionStatus status, String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AssessmentState() when $default != null:
        return $default(
            _that.record, _that.result, _that.status, _that.errorMessage);
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
    TResult Function(PatientRecord? record, RiskResult? result,
            FormzSubmissionStatus status, String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssessmentState():
        return $default(
            _that.record, _that.result, _that.status, _that.errorMessage);
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
    TResult? Function(PatientRecord? record, RiskResult? result,
            FormzSubmissionStatus status, String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssessmentState() when $default != null:
        return $default(
            _that.record, _that.result, _that.status, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AssessmentState extends AssessmentState {
  const _AssessmentState(
      {this.record,
      this.result,
      this.status = FormzSubmissionStatus.initial,
      this.errorMessage})
      : super._();

  @override
  final PatientRecord? record;
  @override
  final RiskResult? result;
  @override
  @JsonKey()
  final FormzSubmissionStatus status;
  @override
  final String? errorMessage;

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AssessmentStateCopyWith<_AssessmentState> get copyWith =>
      __$AssessmentStateCopyWithImpl<_AssessmentState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AssessmentState &&
            (identical(other.record, record) || other.record == record) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, record, result, status, errorMessage);

  @override
  String toString() {
    return 'AssessmentState(record: $record, result: $result, status: $status, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$AssessmentStateCopyWith<$Res>
    implements $AssessmentStateCopyWith<$Res> {
  factory _$AssessmentStateCopyWith(
          _AssessmentState value, $Res Function(_AssessmentState) _then) =
      __$AssessmentStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {PatientRecord? record,
      RiskResult? result,
      FormzSubmissionStatus status,
      String? errorMessage});
}

/// @nodoc
class __$AssessmentStateCopyWithImpl<$Res>
    implements _$AssessmentStateCopyWith<$Res> {
  __$AssessmentStateCopyWithImpl(this._self, this._then);

  final _AssessmentState _self;
  final $Res Function(_AssessmentState) _then;

  /// Create a copy of AssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? record = freezed,
    Object? result = freezed,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_AssessmentState(
      record: freezed == record
          ? _self.record
          : record // ignore: cast_nullable_to_non_nullable
              as PatientRecord?,
      result: freezed == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as RiskResult?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
