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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssessmentEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentEvent()';
}


}

/// @nodoc
class $AssessmentEventCopyWith<$Res>  {
$AssessmentEventCopyWith(AssessmentEvent _, $Res Function(AssessmentEvent) __);
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssessmentEvent value)?  $default,{TResult Function( _ExplanationGenerated value)?  explanationGenerated,TResult Function( _ExplanationFailed value)?  explanationFailed,TResult Function( _RunAssessment value)?  runAssessment,TResult Function( _ClearAssessment value)?  clearAssessment,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssessmentEvent() when $default != null:
return $default(_that);case _ExplanationGenerated() when explanationGenerated != null:
return explanationGenerated(_that);case _ExplanationFailed() when explanationFailed != null:
return explanationFailed(_that);case _RunAssessment() when runAssessment != null:
return runAssessment(_that);case _ClearAssessment() when clearAssessment != null:
return clearAssessment(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssessmentEvent value)  $default,{required TResult Function( _ExplanationGenerated value)  explanationGenerated,required TResult Function( _ExplanationFailed value)  explanationFailed,required TResult Function( _RunAssessment value)  runAssessment,required TResult Function( _ClearAssessment value)  clearAssessment,}){
final _that = this;
switch (_that) {
case _AssessmentEvent():
return $default(_that);case _ExplanationGenerated():
return explanationGenerated(_that);case _ExplanationFailed():
return explanationFailed(_that);case _RunAssessment():
return runAssessment(_that);case _ClearAssessment():
return clearAssessment(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssessmentEvent value)?  $default,{TResult? Function( _ExplanationGenerated value)?  explanationGenerated,TResult? Function( _ExplanationFailed value)?  explanationFailed,TResult? Function( _RunAssessment value)?  runAssessment,TResult? Function( _ClearAssessment value)?  clearAssessment,}){
final _that = this;
switch (_that) {
case _AssessmentEvent() when $default != null:
return $default(_that);case _ExplanationGenerated() when explanationGenerated != null:
return explanationGenerated(_that);case _ExplanationFailed() when explanationFailed != null:
return explanationFailed(_that);case _RunAssessment() when runAssessment != null:
return runAssessment(_that);case _ClearAssessment() when clearAssessment != null:
return clearAssessment(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function()?  $default,{TResult Function( String explanation)?  explanationGenerated,TResult Function()?  explanationFailed,TResult Function( PatientRecord patientRecord)?  runAssessment,TResult Function()?  clearAssessment,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssessmentEvent() when $default != null:
return $default();case _ExplanationGenerated() when explanationGenerated != null:
return explanationGenerated(_that.explanation);case _ExplanationFailed() when explanationFailed != null:
return explanationFailed();case _RunAssessment() when runAssessment != null:
return runAssessment(_that.patientRecord);case _ClearAssessment() when clearAssessment != null:
return clearAssessment();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function()  $default,{required TResult Function( String explanation)  explanationGenerated,required TResult Function()  explanationFailed,required TResult Function( PatientRecord patientRecord)  runAssessment,required TResult Function()  clearAssessment,}) {final _that = this;
switch (_that) {
case _AssessmentEvent():
return $default();case _ExplanationGenerated():
return explanationGenerated(_that.explanation);case _ExplanationFailed():
return explanationFailed();case _RunAssessment():
return runAssessment(_that.patientRecord);case _ClearAssessment():
return clearAssessment();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function()?  $default,{TResult? Function( String explanation)?  explanationGenerated,TResult? Function()?  explanationFailed,TResult? Function( PatientRecord patientRecord)?  runAssessment,TResult? Function()?  clearAssessment,}) {final _that = this;
switch (_that) {
case _AssessmentEvent() when $default != null:
return $default();case _ExplanationGenerated() when explanationGenerated != null:
return explanationGenerated(_that.explanation);case _ExplanationFailed() when explanationFailed != null:
return explanationFailed();case _RunAssessment() when runAssessment != null:
return runAssessment(_that.patientRecord);case _ClearAssessment() when clearAssessment != null:
return clearAssessment();case _:
  return null;

}
}

}

/// @nodoc


class _AssessmentEvent implements AssessmentEvent {
  const _AssessmentEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssessmentEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentEvent()';
}


}




/// @nodoc


class _ExplanationGenerated implements AssessmentEvent {
  const _ExplanationGenerated(this.explanation);
  

 final  String explanation;

/// Create a copy of AssessmentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExplanationGeneratedCopyWith<_ExplanationGenerated> get copyWith => __$ExplanationGeneratedCopyWithImpl<_ExplanationGenerated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExplanationGenerated&&(identical(other.explanation, explanation) || other.explanation == explanation));
}


@override
int get hashCode => Object.hash(runtimeType,explanation);

@override
String toString() {
  return 'AssessmentEvent.explanationGenerated(explanation: $explanation)';
}


}

/// @nodoc
abstract mixin class _$ExplanationGeneratedCopyWith<$Res> implements $AssessmentEventCopyWith<$Res> {
  factory _$ExplanationGeneratedCopyWith(_ExplanationGenerated value, $Res Function(_ExplanationGenerated) _then) = __$ExplanationGeneratedCopyWithImpl;
@useResult
$Res call({
 String explanation
});




}
/// @nodoc
class __$ExplanationGeneratedCopyWithImpl<$Res>
    implements _$ExplanationGeneratedCopyWith<$Res> {
  __$ExplanationGeneratedCopyWithImpl(this._self, this._then);

  final _ExplanationGenerated _self;
  final $Res Function(_ExplanationGenerated) _then;

/// Create a copy of AssessmentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? explanation = null,}) {
  return _then(_ExplanationGenerated(
null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ExplanationFailed implements AssessmentEvent {
  const _ExplanationFailed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExplanationFailed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentEvent.explanationFailed()';
}


}




/// @nodoc


class _RunAssessment implements AssessmentEvent {
  const _RunAssessment(this.patientRecord);
  

 final  PatientRecord patientRecord;

/// Create a copy of AssessmentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RunAssessmentCopyWith<_RunAssessment> get copyWith => __$RunAssessmentCopyWithImpl<_RunAssessment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RunAssessment&&(identical(other.patientRecord, patientRecord) || other.patientRecord == patientRecord));
}


@override
int get hashCode => Object.hash(runtimeType,patientRecord);

@override
String toString() {
  return 'AssessmentEvent.runAssessment(patientRecord: $patientRecord)';
}


}

/// @nodoc
abstract mixin class _$RunAssessmentCopyWith<$Res> implements $AssessmentEventCopyWith<$Res> {
  factory _$RunAssessmentCopyWith(_RunAssessment value, $Res Function(_RunAssessment) _then) = __$RunAssessmentCopyWithImpl;
@useResult
$Res call({
 PatientRecord patientRecord
});


$PatientRecordCopyWith<$Res> get patientRecord;

}
/// @nodoc
class __$RunAssessmentCopyWithImpl<$Res>
    implements _$RunAssessmentCopyWith<$Res> {
  __$RunAssessmentCopyWithImpl(this._self, this._then);

  final _RunAssessment _self;
  final $Res Function(_RunAssessment) _then;

/// Create a copy of AssessmentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? patientRecord = null,}) {
  return _then(_RunAssessment(
null == patientRecord ? _self.patientRecord : patientRecord // ignore: cast_nullable_to_non_nullable
as PatientRecord,
  ));
}

/// Create a copy of AssessmentEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatientRecordCopyWith<$Res> get patientRecord {
  
  return $PatientRecordCopyWith<$Res>(_self.patientRecord, (value) {
    return _then(_self.copyWith(patientRecord: value));
  });
}
}

/// @nodoc


class _ClearAssessment implements AssessmentEvent {
  const _ClearAssessment();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearAssessment);
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

 PatientRecord? get record; RiskResult? get result; String? get clinicalExplanation; bool get isGeneratingExplanation; FormzSubmissionStatus get status; String? get errorMessage;
/// Create a copy of AssessmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssessmentStateCopyWith<AssessmentState> get copyWith => _$AssessmentStateCopyWithImpl<AssessmentState>(this as AssessmentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssessmentState&&(identical(other.record, record) || other.record == record)&&(identical(other.result, result) || other.result == result)&&(identical(other.clinicalExplanation, clinicalExplanation) || other.clinicalExplanation == clinicalExplanation)&&(identical(other.isGeneratingExplanation, isGeneratingExplanation) || other.isGeneratingExplanation == isGeneratingExplanation)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,record,result,clinicalExplanation,isGeneratingExplanation,status,errorMessage);

@override
String toString() {
  return 'AssessmentState(record: $record, result: $result, clinicalExplanation: $clinicalExplanation, isGeneratingExplanation: $isGeneratingExplanation, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AssessmentStateCopyWith<$Res>  {
  factory $AssessmentStateCopyWith(AssessmentState value, $Res Function(AssessmentState) _then) = _$AssessmentStateCopyWithImpl;
@useResult
$Res call({
 PatientRecord? record, RiskResult? result, String? clinicalExplanation, bool isGeneratingExplanation, FormzSubmissionStatus status, String? errorMessage
});


$PatientRecordCopyWith<$Res>? get record;$RiskResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$AssessmentStateCopyWithImpl<$Res>
    implements $AssessmentStateCopyWith<$Res> {
  _$AssessmentStateCopyWithImpl(this._self, this._then);

  final AssessmentState _self;
  final $Res Function(AssessmentState) _then;

/// Create a copy of AssessmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? record = freezed,Object? result = freezed,Object? clinicalExplanation = freezed,Object? isGeneratingExplanation = null,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
record: freezed == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as PatientRecord?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as RiskResult?,clinicalExplanation: freezed == clinicalExplanation ? _self.clinicalExplanation : clinicalExplanation // ignore: cast_nullable_to_non_nullable
as String?,isGeneratingExplanation: null == isGeneratingExplanation ? _self.isGeneratingExplanation : isGeneratingExplanation // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AssessmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatientRecordCopyWith<$Res>? get record {
    if (_self.record == null) {
    return null;
  }

  return $PatientRecordCopyWith<$Res>(_self.record!, (value) {
    return _then(_self.copyWith(record: value));
  });
}/// Create a copy of AssessmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RiskResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $RiskResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssessmentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssessmentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssessmentState value)  $default,){
final _that = this;
switch (_that) {
case _AssessmentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssessmentState value)?  $default,){
final _that = this;
switch (_that) {
case _AssessmentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PatientRecord? record,  RiskResult? result,  String? clinicalExplanation,  bool isGeneratingExplanation,  FormzSubmissionStatus status,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssessmentState() when $default != null:
return $default(_that.record,_that.result,_that.clinicalExplanation,_that.isGeneratingExplanation,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PatientRecord? record,  RiskResult? result,  String? clinicalExplanation,  bool isGeneratingExplanation,  FormzSubmissionStatus status,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AssessmentState():
return $default(_that.record,_that.result,_that.clinicalExplanation,_that.isGeneratingExplanation,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PatientRecord? record,  RiskResult? result,  String? clinicalExplanation,  bool isGeneratingExplanation,  FormzSubmissionStatus status,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AssessmentState() when $default != null:
return $default(_that.record,_that.result,_that.clinicalExplanation,_that.isGeneratingExplanation,_that.status,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AssessmentState extends AssessmentState {
  const _AssessmentState({this.record, this.result, this.clinicalExplanation, this.isGeneratingExplanation = false, this.status = FormzSubmissionStatus.initial, this.errorMessage}): super._();
  

@override final  PatientRecord? record;
@override final  RiskResult? result;
@override final  String? clinicalExplanation;
@override@JsonKey() final  bool isGeneratingExplanation;
@override@JsonKey() final  FormzSubmissionStatus status;
@override final  String? errorMessage;

/// Create a copy of AssessmentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssessmentStateCopyWith<_AssessmentState> get copyWith => __$AssessmentStateCopyWithImpl<_AssessmentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssessmentState&&(identical(other.record, record) || other.record == record)&&(identical(other.result, result) || other.result == result)&&(identical(other.clinicalExplanation, clinicalExplanation) || other.clinicalExplanation == clinicalExplanation)&&(identical(other.isGeneratingExplanation, isGeneratingExplanation) || other.isGeneratingExplanation == isGeneratingExplanation)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,record,result,clinicalExplanation,isGeneratingExplanation,status,errorMessage);

@override
String toString() {
  return 'AssessmentState(record: $record, result: $result, clinicalExplanation: $clinicalExplanation, isGeneratingExplanation: $isGeneratingExplanation, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AssessmentStateCopyWith<$Res> implements $AssessmentStateCopyWith<$Res> {
  factory _$AssessmentStateCopyWith(_AssessmentState value, $Res Function(_AssessmentState) _then) = __$AssessmentStateCopyWithImpl;
@override @useResult
$Res call({
 PatientRecord? record, RiskResult? result, String? clinicalExplanation, bool isGeneratingExplanation, FormzSubmissionStatus status, String? errorMessage
});


@override $PatientRecordCopyWith<$Res>? get record;@override $RiskResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$AssessmentStateCopyWithImpl<$Res>
    implements _$AssessmentStateCopyWith<$Res> {
  __$AssessmentStateCopyWithImpl(this._self, this._then);

  final _AssessmentState _self;
  final $Res Function(_AssessmentState) _then;

/// Create a copy of AssessmentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? record = freezed,Object? result = freezed,Object? clinicalExplanation = freezed,Object? isGeneratingExplanation = null,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_AssessmentState(
record: freezed == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as PatientRecord?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as RiskResult?,clinicalExplanation: freezed == clinicalExplanation ? _self.clinicalExplanation : clinicalExplanation // ignore: cast_nullable_to_non_nullable
as String?,isGeneratingExplanation: null == isGeneratingExplanation ? _self.isGeneratingExplanation : isGeneratingExplanation // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AssessmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatientRecordCopyWith<$Res>? get record {
    if (_self.record == null) {
    return null;
  }

  return $PatientRecordCopyWith<$Res>(_self.record!, (value) {
    return _then(_self.copyWith(record: value));
  });
}/// Create a copy of AssessmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RiskResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $RiskResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
