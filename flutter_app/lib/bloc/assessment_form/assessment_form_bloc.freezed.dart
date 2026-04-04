// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assessment_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AssessmentFormState {

// ── section 1 — basic identification ──────────────────────
 String get patientNameOrId; NumericFieldFormz get age; String get gestationalAge;// optional — not ML feature
// ── section 2 — vital signs ────────────────────────────────
 NumericFieldFormz get systolicBP; NumericFieldFormz get diastolicBP; NumericFieldFormz get heartRate; String get fetalHeartRate;// optional — not ML feature
 NumericFieldFormz get bloodSugar; NumericFieldFormz get bodyTemp; String get weight;// optional
 String get height;// optional
// ── section 3 — danger signs ───────────────────────────────
 bool get blurredVision; bool get vaginalBleeding; bool get severeSwelling; bool get reducedFetalMovement;// ── section 4 — medical history ────────────────────────────
 bool get previousComplications; bool get preexistingDiabetes; bool get gestationalDiabetes; bool get hypertension; String get mentalHealthStatus;// ── submission ─────────────────────────────────────────────
 FormzSubmissionStatus get status; String? get errorMessage;
/// Create a copy of AssessmentFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssessmentFormStateCopyWith<AssessmentFormState> get copyWith => _$AssessmentFormStateCopyWithImpl<AssessmentFormState>(this as AssessmentFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssessmentFormState&&(identical(other.patientNameOrId, patientNameOrId) || other.patientNameOrId == patientNameOrId)&&(identical(other.age, age) || other.age == age)&&(identical(other.gestationalAge, gestationalAge) || other.gestationalAge == gestationalAge)&&(identical(other.systolicBP, systolicBP) || other.systolicBP == systolicBP)&&(identical(other.diastolicBP, diastolicBP) || other.diastolicBP == diastolicBP)&&(identical(other.heartRate, heartRate) || other.heartRate == heartRate)&&(identical(other.fetalHeartRate, fetalHeartRate) || other.fetalHeartRate == fetalHeartRate)&&(identical(other.bloodSugar, bloodSugar) || other.bloodSugar == bloodSugar)&&(identical(other.bodyTemp, bodyTemp) || other.bodyTemp == bodyTemp)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.height, height) || other.height == height)&&(identical(other.blurredVision, blurredVision) || other.blurredVision == blurredVision)&&(identical(other.vaginalBleeding, vaginalBleeding) || other.vaginalBleeding == vaginalBleeding)&&(identical(other.severeSwelling, severeSwelling) || other.severeSwelling == severeSwelling)&&(identical(other.reducedFetalMovement, reducedFetalMovement) || other.reducedFetalMovement == reducedFetalMovement)&&(identical(other.previousComplications, previousComplications) || other.previousComplications == previousComplications)&&(identical(other.preexistingDiabetes, preexistingDiabetes) || other.preexistingDiabetes == preexistingDiabetes)&&(identical(other.gestationalDiabetes, gestationalDiabetes) || other.gestationalDiabetes == gestationalDiabetes)&&(identical(other.hypertension, hypertension) || other.hypertension == hypertension)&&(identical(other.mentalHealthStatus, mentalHealthStatus) || other.mentalHealthStatus == mentalHealthStatus)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hashAll([runtimeType,patientNameOrId,age,gestationalAge,systolicBP,diastolicBP,heartRate,fetalHeartRate,bloodSugar,bodyTemp,weight,height,blurredVision,vaginalBleeding,severeSwelling,reducedFetalMovement,previousComplications,preexistingDiabetes,gestationalDiabetes,hypertension,mentalHealthStatus,status,errorMessage]);

@override
String toString() {
  return 'AssessmentFormState(patientNameOrId: $patientNameOrId, age: $age, gestationalAge: $gestationalAge, systolicBP: $systolicBP, diastolicBP: $diastolicBP, heartRate: $heartRate, fetalHeartRate: $fetalHeartRate, bloodSugar: $bloodSugar, bodyTemp: $bodyTemp, weight: $weight, height: $height, blurredVision: $blurredVision, vaginalBleeding: $vaginalBleeding, severeSwelling: $severeSwelling, reducedFetalMovement: $reducedFetalMovement, previousComplications: $previousComplications, preexistingDiabetes: $preexistingDiabetes, gestationalDiabetes: $gestationalDiabetes, hypertension: $hypertension, mentalHealthStatus: $mentalHealthStatus, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AssessmentFormStateCopyWith<$Res>  {
  factory $AssessmentFormStateCopyWith(AssessmentFormState value, $Res Function(AssessmentFormState) _then) = _$AssessmentFormStateCopyWithImpl;
@useResult
$Res call({
 String patientNameOrId, NumericFieldFormz age, String gestationalAge, NumericFieldFormz systolicBP, NumericFieldFormz diastolicBP, NumericFieldFormz heartRate, String fetalHeartRate, NumericFieldFormz bloodSugar, NumericFieldFormz bodyTemp, String weight, String height, bool blurredVision, bool vaginalBleeding, bool severeSwelling, bool reducedFetalMovement, bool previousComplications, bool preexistingDiabetes, bool gestationalDiabetes, bool hypertension, String mentalHealthStatus, FormzSubmissionStatus status, String? errorMessage
});




}
/// @nodoc
class _$AssessmentFormStateCopyWithImpl<$Res>
    implements $AssessmentFormStateCopyWith<$Res> {
  _$AssessmentFormStateCopyWithImpl(this._self, this._then);

  final AssessmentFormState _self;
  final $Res Function(AssessmentFormState) _then;

/// Create a copy of AssessmentFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? patientNameOrId = null,Object? age = null,Object? gestationalAge = null,Object? systolicBP = null,Object? diastolicBP = null,Object? heartRate = null,Object? fetalHeartRate = null,Object? bloodSugar = null,Object? bodyTemp = null,Object? weight = null,Object? height = null,Object? blurredVision = null,Object? vaginalBleeding = null,Object? severeSwelling = null,Object? reducedFetalMovement = null,Object? previousComplications = null,Object? preexistingDiabetes = null,Object? gestationalDiabetes = null,Object? hypertension = null,Object? mentalHealthStatus = null,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
patientNameOrId: null == patientNameOrId ? _self.patientNameOrId : patientNameOrId // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as NumericFieldFormz,gestationalAge: null == gestationalAge ? _self.gestationalAge : gestationalAge // ignore: cast_nullable_to_non_nullable
as String,systolicBP: null == systolicBP ? _self.systolicBP : systolicBP // ignore: cast_nullable_to_non_nullable
as NumericFieldFormz,diastolicBP: null == diastolicBP ? _self.diastolicBP : diastolicBP // ignore: cast_nullable_to_non_nullable
as NumericFieldFormz,heartRate: null == heartRate ? _self.heartRate : heartRate // ignore: cast_nullable_to_non_nullable
as NumericFieldFormz,fetalHeartRate: null == fetalHeartRate ? _self.fetalHeartRate : fetalHeartRate // ignore: cast_nullable_to_non_nullable
as String,bloodSugar: null == bloodSugar ? _self.bloodSugar : bloodSugar // ignore: cast_nullable_to_non_nullable
as NumericFieldFormz,bodyTemp: null == bodyTemp ? _self.bodyTemp : bodyTemp // ignore: cast_nullable_to_non_nullable
as NumericFieldFormz,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as String,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String,blurredVision: null == blurredVision ? _self.blurredVision : blurredVision // ignore: cast_nullable_to_non_nullable
as bool,vaginalBleeding: null == vaginalBleeding ? _self.vaginalBleeding : vaginalBleeding // ignore: cast_nullable_to_non_nullable
as bool,severeSwelling: null == severeSwelling ? _self.severeSwelling : severeSwelling // ignore: cast_nullable_to_non_nullable
as bool,reducedFetalMovement: null == reducedFetalMovement ? _self.reducedFetalMovement : reducedFetalMovement // ignore: cast_nullable_to_non_nullable
as bool,previousComplications: null == previousComplications ? _self.previousComplications : previousComplications // ignore: cast_nullable_to_non_nullable
as bool,preexistingDiabetes: null == preexistingDiabetes ? _self.preexistingDiabetes : preexistingDiabetes // ignore: cast_nullable_to_non_nullable
as bool,gestationalDiabetes: null == gestationalDiabetes ? _self.gestationalDiabetes : gestationalDiabetes // ignore: cast_nullable_to_non_nullable
as bool,hypertension: null == hypertension ? _self.hypertension : hypertension // ignore: cast_nullable_to_non_nullable
as bool,mentalHealthStatus: null == mentalHealthStatus ? _self.mentalHealthStatus : mentalHealthStatus // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AssessmentFormState].
extension AssessmentFormStatePatterns on AssessmentFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssessmentFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssessmentFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssessmentFormState value)  $default,){
final _that = this;
switch (_that) {
case _AssessmentFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssessmentFormState value)?  $default,){
final _that = this;
switch (_that) {
case _AssessmentFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String patientNameOrId,  NumericFieldFormz age,  String gestationalAge,  NumericFieldFormz systolicBP,  NumericFieldFormz diastolicBP,  NumericFieldFormz heartRate,  String fetalHeartRate,  NumericFieldFormz bloodSugar,  NumericFieldFormz bodyTemp,  String weight,  String height,  bool blurredVision,  bool vaginalBleeding,  bool severeSwelling,  bool reducedFetalMovement,  bool previousComplications,  bool preexistingDiabetes,  bool gestationalDiabetes,  bool hypertension,  String mentalHealthStatus,  FormzSubmissionStatus status,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssessmentFormState() when $default != null:
return $default(_that.patientNameOrId,_that.age,_that.gestationalAge,_that.systolicBP,_that.diastolicBP,_that.heartRate,_that.fetalHeartRate,_that.bloodSugar,_that.bodyTemp,_that.weight,_that.height,_that.blurredVision,_that.vaginalBleeding,_that.severeSwelling,_that.reducedFetalMovement,_that.previousComplications,_that.preexistingDiabetes,_that.gestationalDiabetes,_that.hypertension,_that.mentalHealthStatus,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String patientNameOrId,  NumericFieldFormz age,  String gestationalAge,  NumericFieldFormz systolicBP,  NumericFieldFormz diastolicBP,  NumericFieldFormz heartRate,  String fetalHeartRate,  NumericFieldFormz bloodSugar,  NumericFieldFormz bodyTemp,  String weight,  String height,  bool blurredVision,  bool vaginalBleeding,  bool severeSwelling,  bool reducedFetalMovement,  bool previousComplications,  bool preexistingDiabetes,  bool gestationalDiabetes,  bool hypertension,  String mentalHealthStatus,  FormzSubmissionStatus status,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AssessmentFormState():
return $default(_that.patientNameOrId,_that.age,_that.gestationalAge,_that.systolicBP,_that.diastolicBP,_that.heartRate,_that.fetalHeartRate,_that.bloodSugar,_that.bodyTemp,_that.weight,_that.height,_that.blurredVision,_that.vaginalBleeding,_that.severeSwelling,_that.reducedFetalMovement,_that.previousComplications,_that.preexistingDiabetes,_that.gestationalDiabetes,_that.hypertension,_that.mentalHealthStatus,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String patientNameOrId,  NumericFieldFormz age,  String gestationalAge,  NumericFieldFormz systolicBP,  NumericFieldFormz diastolicBP,  NumericFieldFormz heartRate,  String fetalHeartRate,  NumericFieldFormz bloodSugar,  NumericFieldFormz bodyTemp,  String weight,  String height,  bool blurredVision,  bool vaginalBleeding,  bool severeSwelling,  bool reducedFetalMovement,  bool previousComplications,  bool preexistingDiabetes,  bool gestationalDiabetes,  bool hypertension,  String mentalHealthStatus,  FormzSubmissionStatus status,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AssessmentFormState() when $default != null:
return $default(_that.patientNameOrId,_that.age,_that.gestationalAge,_that.systolicBP,_that.diastolicBP,_that.heartRate,_that.fetalHeartRate,_that.bloodSugar,_that.bodyTemp,_that.weight,_that.height,_that.blurredVision,_that.vaginalBleeding,_that.severeSwelling,_that.reducedFetalMovement,_that.previousComplications,_that.preexistingDiabetes,_that.gestationalDiabetes,_that.hypertension,_that.mentalHealthStatus,_that.status,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AssessmentFormState extends AssessmentFormState {
  const _AssessmentFormState({this.patientNameOrId = '', this.age = const NumericFieldFormz.pure(), this.gestationalAge = '', this.systolicBP = const NumericFieldFormz.pure(), this.diastolicBP = const NumericFieldFormz.pure(), this.heartRate = const NumericFieldFormz.pure(), this.fetalHeartRate = '', this.bloodSugar = const NumericFieldFormz.pure(), this.bodyTemp = const NumericFieldFormz.pure(), this.weight = '', this.height = '', this.blurredVision = false, this.vaginalBleeding = false, this.severeSwelling = false, this.reducedFetalMovement = false, this.previousComplications = false, this.preexistingDiabetes = false, this.gestationalDiabetes = false, this.hypertension = false, this.mentalHealthStatus = 'none', this.status = FormzSubmissionStatus.initial, this.errorMessage}): super._();
  

// ── section 1 — basic identification ──────────────────────
@override@JsonKey() final  String patientNameOrId;
@override@JsonKey() final  NumericFieldFormz age;
@override@JsonKey() final  String gestationalAge;
// optional — not ML feature
// ── section 2 — vital signs ────────────────────────────────
@override@JsonKey() final  NumericFieldFormz systolicBP;
@override@JsonKey() final  NumericFieldFormz diastolicBP;
@override@JsonKey() final  NumericFieldFormz heartRate;
@override@JsonKey() final  String fetalHeartRate;
// optional — not ML feature
@override@JsonKey() final  NumericFieldFormz bloodSugar;
@override@JsonKey() final  NumericFieldFormz bodyTemp;
@override@JsonKey() final  String weight;
// optional
@override@JsonKey() final  String height;
// optional
// ── section 3 — danger signs ───────────────────────────────
@override@JsonKey() final  bool blurredVision;
@override@JsonKey() final  bool vaginalBleeding;
@override@JsonKey() final  bool severeSwelling;
@override@JsonKey() final  bool reducedFetalMovement;
// ── section 4 — medical history ────────────────────────────
@override@JsonKey() final  bool previousComplications;
@override@JsonKey() final  bool preexistingDiabetes;
@override@JsonKey() final  bool gestationalDiabetes;
@override@JsonKey() final  bool hypertension;
@override@JsonKey() final  String mentalHealthStatus;
// ── submission ─────────────────────────────────────────────
@override@JsonKey() final  FormzSubmissionStatus status;
@override final  String? errorMessage;

/// Create a copy of AssessmentFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssessmentFormStateCopyWith<_AssessmentFormState> get copyWith => __$AssessmentFormStateCopyWithImpl<_AssessmentFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssessmentFormState&&(identical(other.patientNameOrId, patientNameOrId) || other.patientNameOrId == patientNameOrId)&&(identical(other.age, age) || other.age == age)&&(identical(other.gestationalAge, gestationalAge) || other.gestationalAge == gestationalAge)&&(identical(other.systolicBP, systolicBP) || other.systolicBP == systolicBP)&&(identical(other.diastolicBP, diastolicBP) || other.diastolicBP == diastolicBP)&&(identical(other.heartRate, heartRate) || other.heartRate == heartRate)&&(identical(other.fetalHeartRate, fetalHeartRate) || other.fetalHeartRate == fetalHeartRate)&&(identical(other.bloodSugar, bloodSugar) || other.bloodSugar == bloodSugar)&&(identical(other.bodyTemp, bodyTemp) || other.bodyTemp == bodyTemp)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.height, height) || other.height == height)&&(identical(other.blurredVision, blurredVision) || other.blurredVision == blurredVision)&&(identical(other.vaginalBleeding, vaginalBleeding) || other.vaginalBleeding == vaginalBleeding)&&(identical(other.severeSwelling, severeSwelling) || other.severeSwelling == severeSwelling)&&(identical(other.reducedFetalMovement, reducedFetalMovement) || other.reducedFetalMovement == reducedFetalMovement)&&(identical(other.previousComplications, previousComplications) || other.previousComplications == previousComplications)&&(identical(other.preexistingDiabetes, preexistingDiabetes) || other.preexistingDiabetes == preexistingDiabetes)&&(identical(other.gestationalDiabetes, gestationalDiabetes) || other.gestationalDiabetes == gestationalDiabetes)&&(identical(other.hypertension, hypertension) || other.hypertension == hypertension)&&(identical(other.mentalHealthStatus, mentalHealthStatus) || other.mentalHealthStatus == mentalHealthStatus)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hashAll([runtimeType,patientNameOrId,age,gestationalAge,systolicBP,diastolicBP,heartRate,fetalHeartRate,bloodSugar,bodyTemp,weight,height,blurredVision,vaginalBleeding,severeSwelling,reducedFetalMovement,previousComplications,preexistingDiabetes,gestationalDiabetes,hypertension,mentalHealthStatus,status,errorMessage]);

@override
String toString() {
  return 'AssessmentFormState(patientNameOrId: $patientNameOrId, age: $age, gestationalAge: $gestationalAge, systolicBP: $systolicBP, diastolicBP: $diastolicBP, heartRate: $heartRate, fetalHeartRate: $fetalHeartRate, bloodSugar: $bloodSugar, bodyTemp: $bodyTemp, weight: $weight, height: $height, blurredVision: $blurredVision, vaginalBleeding: $vaginalBleeding, severeSwelling: $severeSwelling, reducedFetalMovement: $reducedFetalMovement, previousComplications: $previousComplications, preexistingDiabetes: $preexistingDiabetes, gestationalDiabetes: $gestationalDiabetes, hypertension: $hypertension, mentalHealthStatus: $mentalHealthStatus, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AssessmentFormStateCopyWith<$Res> implements $AssessmentFormStateCopyWith<$Res> {
  factory _$AssessmentFormStateCopyWith(_AssessmentFormState value, $Res Function(_AssessmentFormState) _then) = __$AssessmentFormStateCopyWithImpl;
@override @useResult
$Res call({
 String patientNameOrId, NumericFieldFormz age, String gestationalAge, NumericFieldFormz systolicBP, NumericFieldFormz diastolicBP, NumericFieldFormz heartRate, String fetalHeartRate, NumericFieldFormz bloodSugar, NumericFieldFormz bodyTemp, String weight, String height, bool blurredVision, bool vaginalBleeding, bool severeSwelling, bool reducedFetalMovement, bool previousComplications, bool preexistingDiabetes, bool gestationalDiabetes, bool hypertension, String mentalHealthStatus, FormzSubmissionStatus status, String? errorMessage
});




}
/// @nodoc
class __$AssessmentFormStateCopyWithImpl<$Res>
    implements _$AssessmentFormStateCopyWith<$Res> {
  __$AssessmentFormStateCopyWithImpl(this._self, this._then);

  final _AssessmentFormState _self;
  final $Res Function(_AssessmentFormState) _then;

/// Create a copy of AssessmentFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? patientNameOrId = null,Object? age = null,Object? gestationalAge = null,Object? systolicBP = null,Object? diastolicBP = null,Object? heartRate = null,Object? fetalHeartRate = null,Object? bloodSugar = null,Object? bodyTemp = null,Object? weight = null,Object? height = null,Object? blurredVision = null,Object? vaginalBleeding = null,Object? severeSwelling = null,Object? reducedFetalMovement = null,Object? previousComplications = null,Object? preexistingDiabetes = null,Object? gestationalDiabetes = null,Object? hypertension = null,Object? mentalHealthStatus = null,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_AssessmentFormState(
patientNameOrId: null == patientNameOrId ? _self.patientNameOrId : patientNameOrId // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as NumericFieldFormz,gestationalAge: null == gestationalAge ? _self.gestationalAge : gestationalAge // ignore: cast_nullable_to_non_nullable
as String,systolicBP: null == systolicBP ? _self.systolicBP : systolicBP // ignore: cast_nullable_to_non_nullable
as NumericFieldFormz,diastolicBP: null == diastolicBP ? _self.diastolicBP : diastolicBP // ignore: cast_nullable_to_non_nullable
as NumericFieldFormz,heartRate: null == heartRate ? _self.heartRate : heartRate // ignore: cast_nullable_to_non_nullable
as NumericFieldFormz,fetalHeartRate: null == fetalHeartRate ? _self.fetalHeartRate : fetalHeartRate // ignore: cast_nullable_to_non_nullable
as String,bloodSugar: null == bloodSugar ? _self.bloodSugar : bloodSugar // ignore: cast_nullable_to_non_nullable
as NumericFieldFormz,bodyTemp: null == bodyTemp ? _self.bodyTemp : bodyTemp // ignore: cast_nullable_to_non_nullable
as NumericFieldFormz,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as String,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String,blurredVision: null == blurredVision ? _self.blurredVision : blurredVision // ignore: cast_nullable_to_non_nullable
as bool,vaginalBleeding: null == vaginalBleeding ? _self.vaginalBleeding : vaginalBleeding // ignore: cast_nullable_to_non_nullable
as bool,severeSwelling: null == severeSwelling ? _self.severeSwelling : severeSwelling // ignore: cast_nullable_to_non_nullable
as bool,reducedFetalMovement: null == reducedFetalMovement ? _self.reducedFetalMovement : reducedFetalMovement // ignore: cast_nullable_to_non_nullable
as bool,previousComplications: null == previousComplications ? _self.previousComplications : previousComplications // ignore: cast_nullable_to_non_nullable
as bool,preexistingDiabetes: null == preexistingDiabetes ? _self.preexistingDiabetes : preexistingDiabetes // ignore: cast_nullable_to_non_nullable
as bool,gestationalDiabetes: null == gestationalDiabetes ? _self.gestationalDiabetes : gestationalDiabetes // ignore: cast_nullable_to_non_nullable
as bool,hypertension: null == hypertension ? _self.hypertension : hypertension // ignore: cast_nullable_to_non_nullable
as bool,mentalHealthStatus: null == mentalHealthStatus ? _self.mentalHealthStatus : mentalHealthStatus // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AssessmentFormEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssessmentFormEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentFormEvent()';
}


}

/// @nodoc
class $AssessmentFormEventCopyWith<$Res>  {
$AssessmentFormEventCopyWith(AssessmentFormEvent _, $Res Function(AssessmentFormEvent) __);
}


/// Adds pattern-matching-related methods to [AssessmentFormEvent].
extension AssessmentFormEventPatterns on AssessmentFormEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _PatientNameOrIdChanged value)?  patientNameOrIdChanged,TResult Function( _AgeChanged value)?  ageChanged,TResult Function( _GestationalAgeChanged value)?  gestationalAgeChanged,TResult Function( _SystolicBPChanged value)?  systolicBPChanged,TResult Function( _DiastolicBPChanged value)?  diastolicBPChanged,TResult Function( _HeartRateChanged value)?  heartRateChanged,TResult Function( _FetalHeartRateChanged value)?  fetalHeartRateChanged,TResult Function( _BloodSugarChanged value)?  bloodSugarChanged,TResult Function( _BodyTempChanged value)?  bodyTempChanged,TResult Function( _WeightChanged value)?  weightChanged,TResult Function( _HeightChanged value)?  heightChanged,TResult Function( _BlurredVisionToggled value)?  blurredVisionToggled,TResult Function( _VaginalBleedingToggled value)?  vaginalBleedingToggled,TResult Function( _SevereSwellingToggled value)?  severeSwellingToggled,TResult Function( _ReducedFetalMovementToggled value)?  reducedFetalMovementToggled,TResult Function( _PreviousComplicationsToggled value)?  previousComplicationsToggled,TResult Function( _PreexistingDiabetesToggled value)?  preexistingDiabetesToggled,TResult Function( _GestationalDiabetesToggled value)?  gestationalDiabetesToggled,TResult Function( _HypertensionToggled value)?  hypertensionToggled,TResult Function( _MentalHealthStatusChanged value)?  mentalHealthStatusChanged,TResult Function( _Submitted value)?  submitted,TResult Function( _Cleared value)?  cleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatientNameOrIdChanged() when patientNameOrIdChanged != null:
return patientNameOrIdChanged(_that);case _AgeChanged() when ageChanged != null:
return ageChanged(_that);case _GestationalAgeChanged() when gestationalAgeChanged != null:
return gestationalAgeChanged(_that);case _SystolicBPChanged() when systolicBPChanged != null:
return systolicBPChanged(_that);case _DiastolicBPChanged() when diastolicBPChanged != null:
return diastolicBPChanged(_that);case _HeartRateChanged() when heartRateChanged != null:
return heartRateChanged(_that);case _FetalHeartRateChanged() when fetalHeartRateChanged != null:
return fetalHeartRateChanged(_that);case _BloodSugarChanged() when bloodSugarChanged != null:
return bloodSugarChanged(_that);case _BodyTempChanged() when bodyTempChanged != null:
return bodyTempChanged(_that);case _WeightChanged() when weightChanged != null:
return weightChanged(_that);case _HeightChanged() when heightChanged != null:
return heightChanged(_that);case _BlurredVisionToggled() when blurredVisionToggled != null:
return blurredVisionToggled(_that);case _VaginalBleedingToggled() when vaginalBleedingToggled != null:
return vaginalBleedingToggled(_that);case _SevereSwellingToggled() when severeSwellingToggled != null:
return severeSwellingToggled(_that);case _ReducedFetalMovementToggled() when reducedFetalMovementToggled != null:
return reducedFetalMovementToggled(_that);case _PreviousComplicationsToggled() when previousComplicationsToggled != null:
return previousComplicationsToggled(_that);case _PreexistingDiabetesToggled() when preexistingDiabetesToggled != null:
return preexistingDiabetesToggled(_that);case _GestationalDiabetesToggled() when gestationalDiabetesToggled != null:
return gestationalDiabetesToggled(_that);case _HypertensionToggled() when hypertensionToggled != null:
return hypertensionToggled(_that);case _MentalHealthStatusChanged() when mentalHealthStatusChanged != null:
return mentalHealthStatusChanged(_that);case _Submitted() when submitted != null:
return submitted(_that);case _Cleared() when cleared != null:
return cleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _PatientNameOrIdChanged value)  patientNameOrIdChanged,required TResult Function( _AgeChanged value)  ageChanged,required TResult Function( _GestationalAgeChanged value)  gestationalAgeChanged,required TResult Function( _SystolicBPChanged value)  systolicBPChanged,required TResult Function( _DiastolicBPChanged value)  diastolicBPChanged,required TResult Function( _HeartRateChanged value)  heartRateChanged,required TResult Function( _FetalHeartRateChanged value)  fetalHeartRateChanged,required TResult Function( _BloodSugarChanged value)  bloodSugarChanged,required TResult Function( _BodyTempChanged value)  bodyTempChanged,required TResult Function( _WeightChanged value)  weightChanged,required TResult Function( _HeightChanged value)  heightChanged,required TResult Function( _BlurredVisionToggled value)  blurredVisionToggled,required TResult Function( _VaginalBleedingToggled value)  vaginalBleedingToggled,required TResult Function( _SevereSwellingToggled value)  severeSwellingToggled,required TResult Function( _ReducedFetalMovementToggled value)  reducedFetalMovementToggled,required TResult Function( _PreviousComplicationsToggled value)  previousComplicationsToggled,required TResult Function( _PreexistingDiabetesToggled value)  preexistingDiabetesToggled,required TResult Function( _GestationalDiabetesToggled value)  gestationalDiabetesToggled,required TResult Function( _HypertensionToggled value)  hypertensionToggled,required TResult Function( _MentalHealthStatusChanged value)  mentalHealthStatusChanged,required TResult Function( _Submitted value)  submitted,required TResult Function( _Cleared value)  cleared,}){
final _that = this;
switch (_that) {
case _PatientNameOrIdChanged():
return patientNameOrIdChanged(_that);case _AgeChanged():
return ageChanged(_that);case _GestationalAgeChanged():
return gestationalAgeChanged(_that);case _SystolicBPChanged():
return systolicBPChanged(_that);case _DiastolicBPChanged():
return diastolicBPChanged(_that);case _HeartRateChanged():
return heartRateChanged(_that);case _FetalHeartRateChanged():
return fetalHeartRateChanged(_that);case _BloodSugarChanged():
return bloodSugarChanged(_that);case _BodyTempChanged():
return bodyTempChanged(_that);case _WeightChanged():
return weightChanged(_that);case _HeightChanged():
return heightChanged(_that);case _BlurredVisionToggled():
return blurredVisionToggled(_that);case _VaginalBleedingToggled():
return vaginalBleedingToggled(_that);case _SevereSwellingToggled():
return severeSwellingToggled(_that);case _ReducedFetalMovementToggled():
return reducedFetalMovementToggled(_that);case _PreviousComplicationsToggled():
return previousComplicationsToggled(_that);case _PreexistingDiabetesToggled():
return preexistingDiabetesToggled(_that);case _GestationalDiabetesToggled():
return gestationalDiabetesToggled(_that);case _HypertensionToggled():
return hypertensionToggled(_that);case _MentalHealthStatusChanged():
return mentalHealthStatusChanged(_that);case _Submitted():
return submitted(_that);case _Cleared():
return cleared(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _PatientNameOrIdChanged value)?  patientNameOrIdChanged,TResult? Function( _AgeChanged value)?  ageChanged,TResult? Function( _GestationalAgeChanged value)?  gestationalAgeChanged,TResult? Function( _SystolicBPChanged value)?  systolicBPChanged,TResult? Function( _DiastolicBPChanged value)?  diastolicBPChanged,TResult? Function( _HeartRateChanged value)?  heartRateChanged,TResult? Function( _FetalHeartRateChanged value)?  fetalHeartRateChanged,TResult? Function( _BloodSugarChanged value)?  bloodSugarChanged,TResult? Function( _BodyTempChanged value)?  bodyTempChanged,TResult? Function( _WeightChanged value)?  weightChanged,TResult? Function( _HeightChanged value)?  heightChanged,TResult? Function( _BlurredVisionToggled value)?  blurredVisionToggled,TResult? Function( _VaginalBleedingToggled value)?  vaginalBleedingToggled,TResult? Function( _SevereSwellingToggled value)?  severeSwellingToggled,TResult? Function( _ReducedFetalMovementToggled value)?  reducedFetalMovementToggled,TResult? Function( _PreviousComplicationsToggled value)?  previousComplicationsToggled,TResult? Function( _PreexistingDiabetesToggled value)?  preexistingDiabetesToggled,TResult? Function( _GestationalDiabetesToggled value)?  gestationalDiabetesToggled,TResult? Function( _HypertensionToggled value)?  hypertensionToggled,TResult? Function( _MentalHealthStatusChanged value)?  mentalHealthStatusChanged,TResult? Function( _Submitted value)?  submitted,TResult? Function( _Cleared value)?  cleared,}){
final _that = this;
switch (_that) {
case _PatientNameOrIdChanged() when patientNameOrIdChanged != null:
return patientNameOrIdChanged(_that);case _AgeChanged() when ageChanged != null:
return ageChanged(_that);case _GestationalAgeChanged() when gestationalAgeChanged != null:
return gestationalAgeChanged(_that);case _SystolicBPChanged() when systolicBPChanged != null:
return systolicBPChanged(_that);case _DiastolicBPChanged() when diastolicBPChanged != null:
return diastolicBPChanged(_that);case _HeartRateChanged() when heartRateChanged != null:
return heartRateChanged(_that);case _FetalHeartRateChanged() when fetalHeartRateChanged != null:
return fetalHeartRateChanged(_that);case _BloodSugarChanged() when bloodSugarChanged != null:
return bloodSugarChanged(_that);case _BodyTempChanged() when bodyTempChanged != null:
return bodyTempChanged(_that);case _WeightChanged() when weightChanged != null:
return weightChanged(_that);case _HeightChanged() when heightChanged != null:
return heightChanged(_that);case _BlurredVisionToggled() when blurredVisionToggled != null:
return blurredVisionToggled(_that);case _VaginalBleedingToggled() when vaginalBleedingToggled != null:
return vaginalBleedingToggled(_that);case _SevereSwellingToggled() when severeSwellingToggled != null:
return severeSwellingToggled(_that);case _ReducedFetalMovementToggled() when reducedFetalMovementToggled != null:
return reducedFetalMovementToggled(_that);case _PreviousComplicationsToggled() when previousComplicationsToggled != null:
return previousComplicationsToggled(_that);case _PreexistingDiabetesToggled() when preexistingDiabetesToggled != null:
return preexistingDiabetesToggled(_that);case _GestationalDiabetesToggled() when gestationalDiabetesToggled != null:
return gestationalDiabetesToggled(_that);case _HypertensionToggled() when hypertensionToggled != null:
return hypertensionToggled(_that);case _MentalHealthStatusChanged() when mentalHealthStatusChanged != null:
return mentalHealthStatusChanged(_that);case _Submitted() when submitted != null:
return submitted(_that);case _Cleared() when cleared != null:
return cleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String value)?  patientNameOrIdChanged,TResult Function( String value)?  ageChanged,TResult Function( String value)?  gestationalAgeChanged,TResult Function( String value)?  systolicBPChanged,TResult Function( String value)?  diastolicBPChanged,TResult Function( String value)?  heartRateChanged,TResult Function( String value)?  fetalHeartRateChanged,TResult Function( String value)?  bloodSugarChanged,TResult Function( String value)?  bodyTempChanged,TResult Function( String value)?  weightChanged,TResult Function( String value)?  heightChanged,TResult Function()?  blurredVisionToggled,TResult Function()?  vaginalBleedingToggled,TResult Function()?  severeSwellingToggled,TResult Function()?  reducedFetalMovementToggled,TResult Function()?  previousComplicationsToggled,TResult Function()?  preexistingDiabetesToggled,TResult Function()?  gestationalDiabetesToggled,TResult Function()?  hypertensionToggled,TResult Function( String value)?  mentalHealthStatusChanged,TResult Function()?  submitted,TResult Function()?  cleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatientNameOrIdChanged() when patientNameOrIdChanged != null:
return patientNameOrIdChanged(_that.value);case _AgeChanged() when ageChanged != null:
return ageChanged(_that.value);case _GestationalAgeChanged() when gestationalAgeChanged != null:
return gestationalAgeChanged(_that.value);case _SystolicBPChanged() when systolicBPChanged != null:
return systolicBPChanged(_that.value);case _DiastolicBPChanged() when diastolicBPChanged != null:
return diastolicBPChanged(_that.value);case _HeartRateChanged() when heartRateChanged != null:
return heartRateChanged(_that.value);case _FetalHeartRateChanged() when fetalHeartRateChanged != null:
return fetalHeartRateChanged(_that.value);case _BloodSugarChanged() when bloodSugarChanged != null:
return bloodSugarChanged(_that.value);case _BodyTempChanged() when bodyTempChanged != null:
return bodyTempChanged(_that.value);case _WeightChanged() when weightChanged != null:
return weightChanged(_that.value);case _HeightChanged() when heightChanged != null:
return heightChanged(_that.value);case _BlurredVisionToggled() when blurredVisionToggled != null:
return blurredVisionToggled();case _VaginalBleedingToggled() when vaginalBleedingToggled != null:
return vaginalBleedingToggled();case _SevereSwellingToggled() when severeSwellingToggled != null:
return severeSwellingToggled();case _ReducedFetalMovementToggled() when reducedFetalMovementToggled != null:
return reducedFetalMovementToggled();case _PreviousComplicationsToggled() when previousComplicationsToggled != null:
return previousComplicationsToggled();case _PreexistingDiabetesToggled() when preexistingDiabetesToggled != null:
return preexistingDiabetesToggled();case _GestationalDiabetesToggled() when gestationalDiabetesToggled != null:
return gestationalDiabetesToggled();case _HypertensionToggled() when hypertensionToggled != null:
return hypertensionToggled();case _MentalHealthStatusChanged() when mentalHealthStatusChanged != null:
return mentalHealthStatusChanged(_that.value);case _Submitted() when submitted != null:
return submitted();case _Cleared() when cleared != null:
return cleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String value)  patientNameOrIdChanged,required TResult Function( String value)  ageChanged,required TResult Function( String value)  gestationalAgeChanged,required TResult Function( String value)  systolicBPChanged,required TResult Function( String value)  diastolicBPChanged,required TResult Function( String value)  heartRateChanged,required TResult Function( String value)  fetalHeartRateChanged,required TResult Function( String value)  bloodSugarChanged,required TResult Function( String value)  bodyTempChanged,required TResult Function( String value)  weightChanged,required TResult Function( String value)  heightChanged,required TResult Function()  blurredVisionToggled,required TResult Function()  vaginalBleedingToggled,required TResult Function()  severeSwellingToggled,required TResult Function()  reducedFetalMovementToggled,required TResult Function()  previousComplicationsToggled,required TResult Function()  preexistingDiabetesToggled,required TResult Function()  gestationalDiabetesToggled,required TResult Function()  hypertensionToggled,required TResult Function( String value)  mentalHealthStatusChanged,required TResult Function()  submitted,required TResult Function()  cleared,}) {final _that = this;
switch (_that) {
case _PatientNameOrIdChanged():
return patientNameOrIdChanged(_that.value);case _AgeChanged():
return ageChanged(_that.value);case _GestationalAgeChanged():
return gestationalAgeChanged(_that.value);case _SystolicBPChanged():
return systolicBPChanged(_that.value);case _DiastolicBPChanged():
return diastolicBPChanged(_that.value);case _HeartRateChanged():
return heartRateChanged(_that.value);case _FetalHeartRateChanged():
return fetalHeartRateChanged(_that.value);case _BloodSugarChanged():
return bloodSugarChanged(_that.value);case _BodyTempChanged():
return bodyTempChanged(_that.value);case _WeightChanged():
return weightChanged(_that.value);case _HeightChanged():
return heightChanged(_that.value);case _BlurredVisionToggled():
return blurredVisionToggled();case _VaginalBleedingToggled():
return vaginalBleedingToggled();case _SevereSwellingToggled():
return severeSwellingToggled();case _ReducedFetalMovementToggled():
return reducedFetalMovementToggled();case _PreviousComplicationsToggled():
return previousComplicationsToggled();case _PreexistingDiabetesToggled():
return preexistingDiabetesToggled();case _GestationalDiabetesToggled():
return gestationalDiabetesToggled();case _HypertensionToggled():
return hypertensionToggled();case _MentalHealthStatusChanged():
return mentalHealthStatusChanged(_that.value);case _Submitted():
return submitted();case _Cleared():
return cleared();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String value)?  patientNameOrIdChanged,TResult? Function( String value)?  ageChanged,TResult? Function( String value)?  gestationalAgeChanged,TResult? Function( String value)?  systolicBPChanged,TResult? Function( String value)?  diastolicBPChanged,TResult? Function( String value)?  heartRateChanged,TResult? Function( String value)?  fetalHeartRateChanged,TResult? Function( String value)?  bloodSugarChanged,TResult? Function( String value)?  bodyTempChanged,TResult? Function( String value)?  weightChanged,TResult? Function( String value)?  heightChanged,TResult? Function()?  blurredVisionToggled,TResult? Function()?  vaginalBleedingToggled,TResult? Function()?  severeSwellingToggled,TResult? Function()?  reducedFetalMovementToggled,TResult? Function()?  previousComplicationsToggled,TResult? Function()?  preexistingDiabetesToggled,TResult? Function()?  gestationalDiabetesToggled,TResult? Function()?  hypertensionToggled,TResult? Function( String value)?  mentalHealthStatusChanged,TResult? Function()?  submitted,TResult? Function()?  cleared,}) {final _that = this;
switch (_that) {
case _PatientNameOrIdChanged() when patientNameOrIdChanged != null:
return patientNameOrIdChanged(_that.value);case _AgeChanged() when ageChanged != null:
return ageChanged(_that.value);case _GestationalAgeChanged() when gestationalAgeChanged != null:
return gestationalAgeChanged(_that.value);case _SystolicBPChanged() when systolicBPChanged != null:
return systolicBPChanged(_that.value);case _DiastolicBPChanged() when diastolicBPChanged != null:
return diastolicBPChanged(_that.value);case _HeartRateChanged() when heartRateChanged != null:
return heartRateChanged(_that.value);case _FetalHeartRateChanged() when fetalHeartRateChanged != null:
return fetalHeartRateChanged(_that.value);case _BloodSugarChanged() when bloodSugarChanged != null:
return bloodSugarChanged(_that.value);case _BodyTempChanged() when bodyTempChanged != null:
return bodyTempChanged(_that.value);case _WeightChanged() when weightChanged != null:
return weightChanged(_that.value);case _HeightChanged() when heightChanged != null:
return heightChanged(_that.value);case _BlurredVisionToggled() when blurredVisionToggled != null:
return blurredVisionToggled();case _VaginalBleedingToggled() when vaginalBleedingToggled != null:
return vaginalBleedingToggled();case _SevereSwellingToggled() when severeSwellingToggled != null:
return severeSwellingToggled();case _ReducedFetalMovementToggled() when reducedFetalMovementToggled != null:
return reducedFetalMovementToggled();case _PreviousComplicationsToggled() when previousComplicationsToggled != null:
return previousComplicationsToggled();case _PreexistingDiabetesToggled() when preexistingDiabetesToggled != null:
return preexistingDiabetesToggled();case _GestationalDiabetesToggled() when gestationalDiabetesToggled != null:
return gestationalDiabetesToggled();case _HypertensionToggled() when hypertensionToggled != null:
return hypertensionToggled();case _MentalHealthStatusChanged() when mentalHealthStatusChanged != null:
return mentalHealthStatusChanged(_that.value);case _Submitted() when submitted != null:
return submitted();case _Cleared() when cleared != null:
return cleared();case _:
  return null;

}
}

}

/// @nodoc


class _PatientNameOrIdChanged implements AssessmentFormEvent {
  const _PatientNameOrIdChanged(this.value);
  

 final  String value;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientNameOrIdChangedCopyWith<_PatientNameOrIdChanged> get copyWith => __$PatientNameOrIdChangedCopyWithImpl<_PatientNameOrIdChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientNameOrIdChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AssessmentFormEvent.patientNameOrIdChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$PatientNameOrIdChangedCopyWith<$Res> implements $AssessmentFormEventCopyWith<$Res> {
  factory _$PatientNameOrIdChangedCopyWith(_PatientNameOrIdChanged value, $Res Function(_PatientNameOrIdChanged) _then) = __$PatientNameOrIdChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$PatientNameOrIdChangedCopyWithImpl<$Res>
    implements _$PatientNameOrIdChangedCopyWith<$Res> {
  __$PatientNameOrIdChangedCopyWithImpl(this._self, this._then);

  final _PatientNameOrIdChanged _self;
  final $Res Function(_PatientNameOrIdChanged) _then;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_PatientNameOrIdChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AgeChanged implements AssessmentFormEvent {
  const _AgeChanged(this.value);
  

 final  String value;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgeChangedCopyWith<_AgeChanged> get copyWith => __$AgeChangedCopyWithImpl<_AgeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgeChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AssessmentFormEvent.ageChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$AgeChangedCopyWith<$Res> implements $AssessmentFormEventCopyWith<$Res> {
  factory _$AgeChangedCopyWith(_AgeChanged value, $Res Function(_AgeChanged) _then) = __$AgeChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$AgeChangedCopyWithImpl<$Res>
    implements _$AgeChangedCopyWith<$Res> {
  __$AgeChangedCopyWithImpl(this._self, this._then);

  final _AgeChanged _self;
  final $Res Function(_AgeChanged) _then;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_AgeChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GestationalAgeChanged implements AssessmentFormEvent {
  const _GestationalAgeChanged(this.value);
  

 final  String value;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GestationalAgeChangedCopyWith<_GestationalAgeChanged> get copyWith => __$GestationalAgeChangedCopyWithImpl<_GestationalAgeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GestationalAgeChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AssessmentFormEvent.gestationalAgeChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$GestationalAgeChangedCopyWith<$Res> implements $AssessmentFormEventCopyWith<$Res> {
  factory _$GestationalAgeChangedCopyWith(_GestationalAgeChanged value, $Res Function(_GestationalAgeChanged) _then) = __$GestationalAgeChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$GestationalAgeChangedCopyWithImpl<$Res>
    implements _$GestationalAgeChangedCopyWith<$Res> {
  __$GestationalAgeChangedCopyWithImpl(this._self, this._then);

  final _GestationalAgeChanged _self;
  final $Res Function(_GestationalAgeChanged) _then;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_GestationalAgeChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SystolicBPChanged implements AssessmentFormEvent {
  const _SystolicBPChanged(this.value);
  

 final  String value;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SystolicBPChangedCopyWith<_SystolicBPChanged> get copyWith => __$SystolicBPChangedCopyWithImpl<_SystolicBPChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SystolicBPChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AssessmentFormEvent.systolicBPChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$SystolicBPChangedCopyWith<$Res> implements $AssessmentFormEventCopyWith<$Res> {
  factory _$SystolicBPChangedCopyWith(_SystolicBPChanged value, $Res Function(_SystolicBPChanged) _then) = __$SystolicBPChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$SystolicBPChangedCopyWithImpl<$Res>
    implements _$SystolicBPChangedCopyWith<$Res> {
  __$SystolicBPChangedCopyWithImpl(this._self, this._then);

  final _SystolicBPChanged _self;
  final $Res Function(_SystolicBPChanged) _then;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_SystolicBPChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DiastolicBPChanged implements AssessmentFormEvent {
  const _DiastolicBPChanged(this.value);
  

 final  String value;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiastolicBPChangedCopyWith<_DiastolicBPChanged> get copyWith => __$DiastolicBPChangedCopyWithImpl<_DiastolicBPChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiastolicBPChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AssessmentFormEvent.diastolicBPChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$DiastolicBPChangedCopyWith<$Res> implements $AssessmentFormEventCopyWith<$Res> {
  factory _$DiastolicBPChangedCopyWith(_DiastolicBPChanged value, $Res Function(_DiastolicBPChanged) _then) = __$DiastolicBPChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$DiastolicBPChangedCopyWithImpl<$Res>
    implements _$DiastolicBPChangedCopyWith<$Res> {
  __$DiastolicBPChangedCopyWithImpl(this._self, this._then);

  final _DiastolicBPChanged _self;
  final $Res Function(_DiastolicBPChanged) _then;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_DiastolicBPChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _HeartRateChanged implements AssessmentFormEvent {
  const _HeartRateChanged(this.value);
  

 final  String value;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeartRateChangedCopyWith<_HeartRateChanged> get copyWith => __$HeartRateChangedCopyWithImpl<_HeartRateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeartRateChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AssessmentFormEvent.heartRateChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$HeartRateChangedCopyWith<$Res> implements $AssessmentFormEventCopyWith<$Res> {
  factory _$HeartRateChangedCopyWith(_HeartRateChanged value, $Res Function(_HeartRateChanged) _then) = __$HeartRateChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$HeartRateChangedCopyWithImpl<$Res>
    implements _$HeartRateChangedCopyWith<$Res> {
  __$HeartRateChangedCopyWithImpl(this._self, this._then);

  final _HeartRateChanged _self;
  final $Res Function(_HeartRateChanged) _then;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_HeartRateChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FetalHeartRateChanged implements AssessmentFormEvent {
  const _FetalHeartRateChanged(this.value);
  

 final  String value;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetalHeartRateChangedCopyWith<_FetalHeartRateChanged> get copyWith => __$FetalHeartRateChangedCopyWithImpl<_FetalHeartRateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetalHeartRateChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AssessmentFormEvent.fetalHeartRateChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$FetalHeartRateChangedCopyWith<$Res> implements $AssessmentFormEventCopyWith<$Res> {
  factory _$FetalHeartRateChangedCopyWith(_FetalHeartRateChanged value, $Res Function(_FetalHeartRateChanged) _then) = __$FetalHeartRateChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$FetalHeartRateChangedCopyWithImpl<$Res>
    implements _$FetalHeartRateChangedCopyWith<$Res> {
  __$FetalHeartRateChangedCopyWithImpl(this._self, this._then);

  final _FetalHeartRateChanged _self;
  final $Res Function(_FetalHeartRateChanged) _then;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_FetalHeartRateChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _BloodSugarChanged implements AssessmentFormEvent {
  const _BloodSugarChanged(this.value);
  

 final  String value;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BloodSugarChangedCopyWith<_BloodSugarChanged> get copyWith => __$BloodSugarChangedCopyWithImpl<_BloodSugarChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BloodSugarChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AssessmentFormEvent.bloodSugarChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$BloodSugarChangedCopyWith<$Res> implements $AssessmentFormEventCopyWith<$Res> {
  factory _$BloodSugarChangedCopyWith(_BloodSugarChanged value, $Res Function(_BloodSugarChanged) _then) = __$BloodSugarChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$BloodSugarChangedCopyWithImpl<$Res>
    implements _$BloodSugarChangedCopyWith<$Res> {
  __$BloodSugarChangedCopyWithImpl(this._self, this._then);

  final _BloodSugarChanged _self;
  final $Res Function(_BloodSugarChanged) _then;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_BloodSugarChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _BodyTempChanged implements AssessmentFormEvent {
  const _BodyTempChanged(this.value);
  

 final  String value;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyTempChangedCopyWith<_BodyTempChanged> get copyWith => __$BodyTempChangedCopyWithImpl<_BodyTempChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyTempChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AssessmentFormEvent.bodyTempChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$BodyTempChangedCopyWith<$Res> implements $AssessmentFormEventCopyWith<$Res> {
  factory _$BodyTempChangedCopyWith(_BodyTempChanged value, $Res Function(_BodyTempChanged) _then) = __$BodyTempChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$BodyTempChangedCopyWithImpl<$Res>
    implements _$BodyTempChangedCopyWith<$Res> {
  __$BodyTempChangedCopyWithImpl(this._self, this._then);

  final _BodyTempChanged _self;
  final $Res Function(_BodyTempChanged) _then;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_BodyTempChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WeightChanged implements AssessmentFormEvent {
  const _WeightChanged(this.value);
  

 final  String value;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeightChangedCopyWith<_WeightChanged> get copyWith => __$WeightChangedCopyWithImpl<_WeightChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeightChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AssessmentFormEvent.weightChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$WeightChangedCopyWith<$Res> implements $AssessmentFormEventCopyWith<$Res> {
  factory _$WeightChangedCopyWith(_WeightChanged value, $Res Function(_WeightChanged) _then) = __$WeightChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$WeightChangedCopyWithImpl<$Res>
    implements _$WeightChangedCopyWith<$Res> {
  __$WeightChangedCopyWithImpl(this._self, this._then);

  final _WeightChanged _self;
  final $Res Function(_WeightChanged) _then;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_WeightChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _HeightChanged implements AssessmentFormEvent {
  const _HeightChanged(this.value);
  

 final  String value;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeightChangedCopyWith<_HeightChanged> get copyWith => __$HeightChangedCopyWithImpl<_HeightChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeightChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AssessmentFormEvent.heightChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$HeightChangedCopyWith<$Res> implements $AssessmentFormEventCopyWith<$Res> {
  factory _$HeightChangedCopyWith(_HeightChanged value, $Res Function(_HeightChanged) _then) = __$HeightChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$HeightChangedCopyWithImpl<$Res>
    implements _$HeightChangedCopyWith<$Res> {
  __$HeightChangedCopyWithImpl(this._self, this._then);

  final _HeightChanged _self;
  final $Res Function(_HeightChanged) _then;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_HeightChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _BlurredVisionToggled implements AssessmentFormEvent {
  const _BlurredVisionToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlurredVisionToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentFormEvent.blurredVisionToggled()';
}


}




/// @nodoc


class _VaginalBleedingToggled implements AssessmentFormEvent {
  const _VaginalBleedingToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VaginalBleedingToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentFormEvent.vaginalBleedingToggled()';
}


}




/// @nodoc


class _SevereSwellingToggled implements AssessmentFormEvent {
  const _SevereSwellingToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SevereSwellingToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentFormEvent.severeSwellingToggled()';
}


}




/// @nodoc


class _ReducedFetalMovementToggled implements AssessmentFormEvent {
  const _ReducedFetalMovementToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReducedFetalMovementToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentFormEvent.reducedFetalMovementToggled()';
}


}




/// @nodoc


class _PreviousComplicationsToggled implements AssessmentFormEvent {
  const _PreviousComplicationsToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreviousComplicationsToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentFormEvent.previousComplicationsToggled()';
}


}




/// @nodoc


class _PreexistingDiabetesToggled implements AssessmentFormEvent {
  const _PreexistingDiabetesToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreexistingDiabetesToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentFormEvent.preexistingDiabetesToggled()';
}


}




/// @nodoc


class _GestationalDiabetesToggled implements AssessmentFormEvent {
  const _GestationalDiabetesToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GestationalDiabetesToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentFormEvent.gestationalDiabetesToggled()';
}


}




/// @nodoc


class _HypertensionToggled implements AssessmentFormEvent {
  const _HypertensionToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypertensionToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentFormEvent.hypertensionToggled()';
}


}




/// @nodoc


class _MentalHealthStatusChanged implements AssessmentFormEvent {
  const _MentalHealthStatusChanged(this.value);
  

 final  String value;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentalHealthStatusChangedCopyWith<_MentalHealthStatusChanged> get copyWith => __$MentalHealthStatusChangedCopyWithImpl<_MentalHealthStatusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentalHealthStatusChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AssessmentFormEvent.mentalHealthStatusChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$MentalHealthStatusChangedCopyWith<$Res> implements $AssessmentFormEventCopyWith<$Res> {
  factory _$MentalHealthStatusChangedCopyWith(_MentalHealthStatusChanged value, $Res Function(_MentalHealthStatusChanged) _then) = __$MentalHealthStatusChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$MentalHealthStatusChangedCopyWithImpl<$Res>
    implements _$MentalHealthStatusChangedCopyWith<$Res> {
  __$MentalHealthStatusChangedCopyWithImpl(this._self, this._then);

  final _MentalHealthStatusChanged _self;
  final $Res Function(_MentalHealthStatusChanged) _then;

/// Create a copy of AssessmentFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_MentalHealthStatusChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Submitted implements AssessmentFormEvent {
  const _Submitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentFormEvent.submitted()';
}


}




/// @nodoc


class _Cleared implements AssessmentFormEvent {
  const _Cleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssessmentFormEvent.cleared()';
}


}




// dart format on
