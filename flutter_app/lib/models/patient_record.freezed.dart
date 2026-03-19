// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatientRecord {
  String? get id;
  double get age;
  double get systolicBP;
  double get diastolicBP;
  double get bloodSugar;
  double get bodyTemp;
  double get heartRate;
  double? get weight;
  double? get height;
  bool get previousComplications;
  bool get preexistingDiabetes;
  bool get gestationalDiabetes;
  String get mentalHealthStatus;
  @TimestampConverter()
  DateTime get createdAt;
  String? get assessedBy;
  String? get hospitalId;

  /// Create a copy of PatientRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PatientRecordCopyWith<PatientRecord> get copyWith =>
      _$PatientRecordCopyWithImpl<PatientRecord>(
          this as PatientRecord, _$identity);

  /// Serializes this PatientRecord to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PatientRecord &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.systolicBP, systolicBP) ||
                other.systolicBP == systolicBP) &&
            (identical(other.diastolicBP, diastolicBP) ||
                other.diastolicBP == diastolicBP) &&
            (identical(other.bloodSugar, bloodSugar) ||
                other.bloodSugar == bloodSugar) &&
            (identical(other.bodyTemp, bodyTemp) ||
                other.bodyTemp == bodyTemp) &&
            (identical(other.heartRate, heartRate) ||
                other.heartRate == heartRate) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.previousComplications, previousComplications) ||
                other.previousComplications == previousComplications) &&
            (identical(other.preexistingDiabetes, preexistingDiabetes) ||
                other.preexistingDiabetes == preexistingDiabetes) &&
            (identical(other.gestationalDiabetes, gestationalDiabetes) ||
                other.gestationalDiabetes == gestationalDiabetes) &&
            (identical(other.mentalHealthStatus, mentalHealthStatus) ||
                other.mentalHealthStatus == mentalHealthStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.assessedBy, assessedBy) ||
                other.assessedBy == assessedBy) &&
            (identical(other.hospitalId, hospitalId) ||
                other.hospitalId == hospitalId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      age,
      systolicBP,
      diastolicBP,
      bloodSugar,
      bodyTemp,
      heartRate,
      weight,
      height,
      previousComplications,
      preexistingDiabetes,
      gestationalDiabetes,
      mentalHealthStatus,
      createdAt,
      assessedBy,
      hospitalId);

  @override
  String toString() {
    return 'PatientRecord(id: $id, age: $age, systolicBP: $systolicBP, diastolicBP: $diastolicBP, bloodSugar: $bloodSugar, bodyTemp: $bodyTemp, heartRate: $heartRate, weight: $weight, height: $height, previousComplications: $previousComplications, preexistingDiabetes: $preexistingDiabetes, gestationalDiabetes: $gestationalDiabetes, mentalHealthStatus: $mentalHealthStatus, createdAt: $createdAt, assessedBy: $assessedBy, hospitalId: $hospitalId)';
  }
}

/// @nodoc
abstract mixin class $PatientRecordCopyWith<$Res> {
  factory $PatientRecordCopyWith(
          PatientRecord value, $Res Function(PatientRecord) _then) =
      _$PatientRecordCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      double age,
      double systolicBP,
      double diastolicBP,
      double bloodSugar,
      double bodyTemp,
      double heartRate,
      double? weight,
      double? height,
      bool previousComplications,
      bool preexistingDiabetes,
      bool gestationalDiabetes,
      String mentalHealthStatus,
      @TimestampConverter() DateTime createdAt,
      String? assessedBy,
      String? hospitalId});
}

/// @nodoc
class _$PatientRecordCopyWithImpl<$Res>
    implements $PatientRecordCopyWith<$Res> {
  _$PatientRecordCopyWithImpl(this._self, this._then);

  final PatientRecord _self;
  final $Res Function(PatientRecord) _then;

  /// Create a copy of PatientRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? age = null,
    Object? systolicBP = null,
    Object? diastolicBP = null,
    Object? bloodSugar = null,
    Object? bodyTemp = null,
    Object? heartRate = null,
    Object? weight = freezed,
    Object? height = freezed,
    Object? previousComplications = null,
    Object? preexistingDiabetes = null,
    Object? gestationalDiabetes = null,
    Object? mentalHealthStatus = null,
    Object? createdAt = null,
    Object? assessedBy = freezed,
    Object? hospitalId = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as double,
      systolicBP: null == systolicBP
          ? _self.systolicBP
          : systolicBP // ignore: cast_nullable_to_non_nullable
              as double,
      diastolicBP: null == diastolicBP
          ? _self.diastolicBP
          : diastolicBP // ignore: cast_nullable_to_non_nullable
              as double,
      bloodSugar: null == bloodSugar
          ? _self.bloodSugar
          : bloodSugar // ignore: cast_nullable_to_non_nullable
              as double,
      bodyTemp: null == bodyTemp
          ? _self.bodyTemp
          : bodyTemp // ignore: cast_nullable_to_non_nullable
              as double,
      heartRate: null == heartRate
          ? _self.heartRate
          : heartRate // ignore: cast_nullable_to_non_nullable
              as double,
      weight: freezed == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      previousComplications: null == previousComplications
          ? _self.previousComplications
          : previousComplications // ignore: cast_nullable_to_non_nullable
              as bool,
      preexistingDiabetes: null == preexistingDiabetes
          ? _self.preexistingDiabetes
          : preexistingDiabetes // ignore: cast_nullable_to_non_nullable
              as bool,
      gestationalDiabetes: null == gestationalDiabetes
          ? _self.gestationalDiabetes
          : gestationalDiabetes // ignore: cast_nullable_to_non_nullable
              as bool,
      mentalHealthStatus: null == mentalHealthStatus
          ? _self.mentalHealthStatus
          : mentalHealthStatus // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assessedBy: freezed == assessedBy
          ? _self.assessedBy
          : assessedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      hospitalId: freezed == hospitalId
          ? _self.hospitalId
          : hospitalId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PatientRecord].
extension PatientRecordPatterns on PatientRecord {
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
    TResult Function(_PatientRecord value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PatientRecord() when $default != null:
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
    TResult Function(_PatientRecord value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientRecord():
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
    TResult? Function(_PatientRecord value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientRecord() when $default != null:
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
            String? id,
            double age,
            double systolicBP,
            double diastolicBP,
            double bloodSugar,
            double bodyTemp,
            double heartRate,
            double? weight,
            double? height,
            bool previousComplications,
            bool preexistingDiabetes,
            bool gestationalDiabetes,
            String mentalHealthStatus,
            @TimestampConverter() DateTime createdAt,
            String? assessedBy,
            String? hospitalId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PatientRecord() when $default != null:
        return $default(
            _that.id,
            _that.age,
            _that.systolicBP,
            _that.diastolicBP,
            _that.bloodSugar,
            _that.bodyTemp,
            _that.heartRate,
            _that.weight,
            _that.height,
            _that.previousComplications,
            _that.preexistingDiabetes,
            _that.gestationalDiabetes,
            _that.mentalHealthStatus,
            _that.createdAt,
            _that.assessedBy,
            _that.hospitalId);
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
            String? id,
            double age,
            double systolicBP,
            double diastolicBP,
            double bloodSugar,
            double bodyTemp,
            double heartRate,
            double? weight,
            double? height,
            bool previousComplications,
            bool preexistingDiabetes,
            bool gestationalDiabetes,
            String mentalHealthStatus,
            @TimestampConverter() DateTime createdAt,
            String? assessedBy,
            String? hospitalId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientRecord():
        return $default(
            _that.id,
            _that.age,
            _that.systolicBP,
            _that.diastolicBP,
            _that.bloodSugar,
            _that.bodyTemp,
            _that.heartRate,
            _that.weight,
            _that.height,
            _that.previousComplications,
            _that.preexistingDiabetes,
            _that.gestationalDiabetes,
            _that.mentalHealthStatus,
            _that.createdAt,
            _that.assessedBy,
            _that.hospitalId);
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
            String? id,
            double age,
            double systolicBP,
            double diastolicBP,
            double bloodSugar,
            double bodyTemp,
            double heartRate,
            double? weight,
            double? height,
            bool previousComplications,
            bool preexistingDiabetes,
            bool gestationalDiabetes,
            String mentalHealthStatus,
            @TimestampConverter() DateTime createdAt,
            String? assessedBy,
            String? hospitalId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientRecord() when $default != null:
        return $default(
            _that.id,
            _that.age,
            _that.systolicBP,
            _that.diastolicBP,
            _that.bloodSugar,
            _that.bodyTemp,
            _that.heartRate,
            _that.weight,
            _that.height,
            _that.previousComplications,
            _that.preexistingDiabetes,
            _that.gestationalDiabetes,
            _that.mentalHealthStatus,
            _that.createdAt,
            _that.assessedBy,
            _that.hospitalId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PatientRecord extends PatientRecord {
  const _PatientRecord(
      {this.id,
      required this.age,
      required this.systolicBP,
      required this.diastolicBP,
      required this.bloodSugar,
      required this.bodyTemp,
      required this.heartRate,
      this.weight,
      this.height,
      this.previousComplications = false,
      this.preexistingDiabetes = false,
      this.gestationalDiabetes = false,
      this.mentalHealthStatus = 'none',
      @TimestampConverter() required this.createdAt,
      this.assessedBy,
      this.hospitalId})
      : super._();
  factory _PatientRecord.fromJson(Map<String, dynamic> json) =>
      _$PatientRecordFromJson(json);

  @override
  final String? id;
  @override
  final double age;
  @override
  final double systolicBP;
  @override
  final double diastolicBP;
  @override
  final double bloodSugar;
  @override
  final double bodyTemp;
  @override
  final double heartRate;
  @override
  final double? weight;
  @override
  final double? height;
  @override
  @JsonKey()
  final bool previousComplications;
  @override
  @JsonKey()
  final bool preexistingDiabetes;
  @override
  @JsonKey()
  final bool gestationalDiabetes;
  @override
  @JsonKey()
  final String mentalHealthStatus;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  final String? assessedBy;
  @override
  final String? hospitalId;

  /// Create a copy of PatientRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PatientRecordCopyWith<_PatientRecord> get copyWith =>
      __$PatientRecordCopyWithImpl<_PatientRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PatientRecordToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PatientRecord &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.systolicBP, systolicBP) ||
                other.systolicBP == systolicBP) &&
            (identical(other.diastolicBP, diastolicBP) ||
                other.diastolicBP == diastolicBP) &&
            (identical(other.bloodSugar, bloodSugar) ||
                other.bloodSugar == bloodSugar) &&
            (identical(other.bodyTemp, bodyTemp) ||
                other.bodyTemp == bodyTemp) &&
            (identical(other.heartRate, heartRate) ||
                other.heartRate == heartRate) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.previousComplications, previousComplications) ||
                other.previousComplications == previousComplications) &&
            (identical(other.preexistingDiabetes, preexistingDiabetes) ||
                other.preexistingDiabetes == preexistingDiabetes) &&
            (identical(other.gestationalDiabetes, gestationalDiabetes) ||
                other.gestationalDiabetes == gestationalDiabetes) &&
            (identical(other.mentalHealthStatus, mentalHealthStatus) ||
                other.mentalHealthStatus == mentalHealthStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.assessedBy, assessedBy) ||
                other.assessedBy == assessedBy) &&
            (identical(other.hospitalId, hospitalId) ||
                other.hospitalId == hospitalId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      age,
      systolicBP,
      diastolicBP,
      bloodSugar,
      bodyTemp,
      heartRate,
      weight,
      height,
      previousComplications,
      preexistingDiabetes,
      gestationalDiabetes,
      mentalHealthStatus,
      createdAt,
      assessedBy,
      hospitalId);

  @override
  String toString() {
    return 'PatientRecord(id: $id, age: $age, systolicBP: $systolicBP, diastolicBP: $diastolicBP, bloodSugar: $bloodSugar, bodyTemp: $bodyTemp, heartRate: $heartRate, weight: $weight, height: $height, previousComplications: $previousComplications, preexistingDiabetes: $preexistingDiabetes, gestationalDiabetes: $gestationalDiabetes, mentalHealthStatus: $mentalHealthStatus, createdAt: $createdAt, assessedBy: $assessedBy, hospitalId: $hospitalId)';
  }
}

/// @nodoc
abstract mixin class _$PatientRecordCopyWith<$Res>
    implements $PatientRecordCopyWith<$Res> {
  factory _$PatientRecordCopyWith(
          _PatientRecord value, $Res Function(_PatientRecord) _then) =
      __$PatientRecordCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      double age,
      double systolicBP,
      double diastolicBP,
      double bloodSugar,
      double bodyTemp,
      double heartRate,
      double? weight,
      double? height,
      bool previousComplications,
      bool preexistingDiabetes,
      bool gestationalDiabetes,
      String mentalHealthStatus,
      @TimestampConverter() DateTime createdAt,
      String? assessedBy,
      String? hospitalId});
}

/// @nodoc
class __$PatientRecordCopyWithImpl<$Res>
    implements _$PatientRecordCopyWith<$Res> {
  __$PatientRecordCopyWithImpl(this._self, this._then);

  final _PatientRecord _self;
  final $Res Function(_PatientRecord) _then;

  /// Create a copy of PatientRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? age = null,
    Object? systolicBP = null,
    Object? diastolicBP = null,
    Object? bloodSugar = null,
    Object? bodyTemp = null,
    Object? heartRate = null,
    Object? weight = freezed,
    Object? height = freezed,
    Object? previousComplications = null,
    Object? preexistingDiabetes = null,
    Object? gestationalDiabetes = null,
    Object? mentalHealthStatus = null,
    Object? createdAt = null,
    Object? assessedBy = freezed,
    Object? hospitalId = freezed,
  }) {
    return _then(_PatientRecord(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as double,
      systolicBP: null == systolicBP
          ? _self.systolicBP
          : systolicBP // ignore: cast_nullable_to_non_nullable
              as double,
      diastolicBP: null == diastolicBP
          ? _self.diastolicBP
          : diastolicBP // ignore: cast_nullable_to_non_nullable
              as double,
      bloodSugar: null == bloodSugar
          ? _self.bloodSugar
          : bloodSugar // ignore: cast_nullable_to_non_nullable
              as double,
      bodyTemp: null == bodyTemp
          ? _self.bodyTemp
          : bodyTemp // ignore: cast_nullable_to_non_nullable
              as double,
      heartRate: null == heartRate
          ? _self.heartRate
          : heartRate // ignore: cast_nullable_to_non_nullable
              as double,
      weight: freezed == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      previousComplications: null == previousComplications
          ? _self.previousComplications
          : previousComplications // ignore: cast_nullable_to_non_nullable
              as bool,
      preexistingDiabetes: null == preexistingDiabetes
          ? _self.preexistingDiabetes
          : preexistingDiabetes // ignore: cast_nullable_to_non_nullable
              as bool,
      gestationalDiabetes: null == gestationalDiabetes
          ? _self.gestationalDiabetes
          : gestationalDiabetes // ignore: cast_nullable_to_non_nullable
              as bool,
      mentalHealthStatus: null == mentalHealthStatus
          ? _self.mentalHealthStatus
          : mentalHealthStatus // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assessedBy: freezed == assessedBy
          ? _self.assessedBy
          : assessedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      hospitalId: freezed == hospitalId
          ? _self.hospitalId
          : hospitalId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
