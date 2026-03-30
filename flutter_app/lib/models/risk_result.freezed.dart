// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'risk_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RiskResult {

 int get riskClass; List<double> get probabilities; List<ShapFeature> get shapFeatures;
/// Create a copy of RiskResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RiskResultCopyWith<RiskResult> get copyWith => _$RiskResultCopyWithImpl<RiskResult>(this as RiskResult, _$identity);

  /// Serializes this RiskResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RiskResult&&(identical(other.riskClass, riskClass) || other.riskClass == riskClass)&&const DeepCollectionEquality().equals(other.probabilities, probabilities)&&const DeepCollectionEquality().equals(other.shapFeatures, shapFeatures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,riskClass,const DeepCollectionEquality().hash(probabilities),const DeepCollectionEquality().hash(shapFeatures));

@override
String toString() {
  return 'RiskResult(riskClass: $riskClass, probabilities: $probabilities, shapFeatures: $shapFeatures)';
}


}

/// @nodoc
abstract mixin class $RiskResultCopyWith<$Res>  {
  factory $RiskResultCopyWith(RiskResult value, $Res Function(RiskResult) _then) = _$RiskResultCopyWithImpl;
@useResult
$Res call({
 int riskClass, List<double> probabilities, List<ShapFeature> shapFeatures
});




}
/// @nodoc
class _$RiskResultCopyWithImpl<$Res>
    implements $RiskResultCopyWith<$Res> {
  _$RiskResultCopyWithImpl(this._self, this._then);

  final RiskResult _self;
  final $Res Function(RiskResult) _then;

/// Create a copy of RiskResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? riskClass = null,Object? probabilities = null,Object? shapFeatures = null,}) {
  return _then(_self.copyWith(
riskClass: null == riskClass ? _self.riskClass : riskClass // ignore: cast_nullable_to_non_nullable
as int,probabilities: null == probabilities ? _self.probabilities : probabilities // ignore: cast_nullable_to_non_nullable
as List<double>,shapFeatures: null == shapFeatures ? _self.shapFeatures : shapFeatures // ignore: cast_nullable_to_non_nullable
as List<ShapFeature>,
  ));
}

}


/// Adds pattern-matching-related methods to [RiskResult].
extension RiskResultPatterns on RiskResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RiskResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RiskResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RiskResult value)  $default,){
final _that = this;
switch (_that) {
case _RiskResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RiskResult value)?  $default,){
final _that = this;
switch (_that) {
case _RiskResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int riskClass,  List<double> probabilities,  List<ShapFeature> shapFeatures)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RiskResult() when $default != null:
return $default(_that.riskClass,_that.probabilities,_that.shapFeatures);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int riskClass,  List<double> probabilities,  List<ShapFeature> shapFeatures)  $default,) {final _that = this;
switch (_that) {
case _RiskResult():
return $default(_that.riskClass,_that.probabilities,_that.shapFeatures);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int riskClass,  List<double> probabilities,  List<ShapFeature> shapFeatures)?  $default,) {final _that = this;
switch (_that) {
case _RiskResult() when $default != null:
return $default(_that.riskClass,_that.probabilities,_that.shapFeatures);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RiskResult extends RiskResult {
  const _RiskResult({required this.riskClass, required final  List<double> probabilities, final  List<ShapFeature> shapFeatures = const []}): _probabilities = probabilities,_shapFeatures = shapFeatures,super._();
  factory _RiskResult.fromJson(Map<String, dynamic> json) => _$RiskResultFromJson(json);

@override final  int riskClass;
 final  List<double> _probabilities;
@override List<double> get probabilities {
  if (_probabilities is EqualUnmodifiableListView) return _probabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_probabilities);
}

 final  List<ShapFeature> _shapFeatures;
@override@JsonKey() List<ShapFeature> get shapFeatures {
  if (_shapFeatures is EqualUnmodifiableListView) return _shapFeatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shapFeatures);
}


/// Create a copy of RiskResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RiskResultCopyWith<_RiskResult> get copyWith => __$RiskResultCopyWithImpl<_RiskResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RiskResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RiskResult&&(identical(other.riskClass, riskClass) || other.riskClass == riskClass)&&const DeepCollectionEquality().equals(other._probabilities, _probabilities)&&const DeepCollectionEquality().equals(other._shapFeatures, _shapFeatures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,riskClass,const DeepCollectionEquality().hash(_probabilities),const DeepCollectionEquality().hash(_shapFeatures));

@override
String toString() {
  return 'RiskResult(riskClass: $riskClass, probabilities: $probabilities, shapFeatures: $shapFeatures)';
}


}

/// @nodoc
abstract mixin class _$RiskResultCopyWith<$Res> implements $RiskResultCopyWith<$Res> {
  factory _$RiskResultCopyWith(_RiskResult value, $Res Function(_RiskResult) _then) = __$RiskResultCopyWithImpl;
@override @useResult
$Res call({
 int riskClass, List<double> probabilities, List<ShapFeature> shapFeatures
});




}
/// @nodoc
class __$RiskResultCopyWithImpl<$Res>
    implements _$RiskResultCopyWith<$Res> {
  __$RiskResultCopyWithImpl(this._self, this._then);

  final _RiskResult _self;
  final $Res Function(_RiskResult) _then;

/// Create a copy of RiskResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? riskClass = null,Object? probabilities = null,Object? shapFeatures = null,}) {
  return _then(_RiskResult(
riskClass: null == riskClass ? _self.riskClass : riskClass // ignore: cast_nullable_to_non_nullable
as int,probabilities: null == probabilities ? _self._probabilities : probabilities // ignore: cast_nullable_to_non_nullable
as List<double>,shapFeatures: null == shapFeatures ? _self._shapFeatures : shapFeatures // ignore: cast_nullable_to_non_nullable
as List<ShapFeature>,
  ));
}


}


/// @nodoc
mixin _$ShapFeature {

 String get featureName; double get shapValue;
/// Create a copy of ShapFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShapFeatureCopyWith<ShapFeature> get copyWith => _$ShapFeatureCopyWithImpl<ShapFeature>(this as ShapFeature, _$identity);

  /// Serializes this ShapFeature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShapFeature&&(identical(other.featureName, featureName) || other.featureName == featureName)&&(identical(other.shapValue, shapValue) || other.shapValue == shapValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,featureName,shapValue);

@override
String toString() {
  return 'ShapFeature(featureName: $featureName, shapValue: $shapValue)';
}


}

/// @nodoc
abstract mixin class $ShapFeatureCopyWith<$Res>  {
  factory $ShapFeatureCopyWith(ShapFeature value, $Res Function(ShapFeature) _then) = _$ShapFeatureCopyWithImpl;
@useResult
$Res call({
 String featureName, double shapValue
});




}
/// @nodoc
class _$ShapFeatureCopyWithImpl<$Res>
    implements $ShapFeatureCopyWith<$Res> {
  _$ShapFeatureCopyWithImpl(this._self, this._then);

  final ShapFeature _self;
  final $Res Function(ShapFeature) _then;

/// Create a copy of ShapFeature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? featureName = null,Object? shapValue = null,}) {
  return _then(_self.copyWith(
featureName: null == featureName ? _self.featureName : featureName // ignore: cast_nullable_to_non_nullable
as String,shapValue: null == shapValue ? _self.shapValue : shapValue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ShapFeature].
extension ShapFeaturePatterns on ShapFeature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShapFeature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShapFeature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShapFeature value)  $default,){
final _that = this;
switch (_that) {
case _ShapFeature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShapFeature value)?  $default,){
final _that = this;
switch (_that) {
case _ShapFeature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String featureName,  double shapValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShapFeature() when $default != null:
return $default(_that.featureName,_that.shapValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String featureName,  double shapValue)  $default,) {final _that = this;
switch (_that) {
case _ShapFeature():
return $default(_that.featureName,_that.shapValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String featureName,  double shapValue)?  $default,) {final _that = this;
switch (_that) {
case _ShapFeature() when $default != null:
return $default(_that.featureName,_that.shapValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShapFeature extends ShapFeature {
  const _ShapFeature({required this.featureName, required this.shapValue}): super._();
  factory _ShapFeature.fromJson(Map<String, dynamic> json) => _$ShapFeatureFromJson(json);

@override final  String featureName;
@override final  double shapValue;

/// Create a copy of ShapFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShapFeatureCopyWith<_ShapFeature> get copyWith => __$ShapFeatureCopyWithImpl<_ShapFeature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShapFeatureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShapFeature&&(identical(other.featureName, featureName) || other.featureName == featureName)&&(identical(other.shapValue, shapValue) || other.shapValue == shapValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,featureName,shapValue);

@override
String toString() {
  return 'ShapFeature(featureName: $featureName, shapValue: $shapValue)';
}


}

/// @nodoc
abstract mixin class _$ShapFeatureCopyWith<$Res> implements $ShapFeatureCopyWith<$Res> {
  factory _$ShapFeatureCopyWith(_ShapFeature value, $Res Function(_ShapFeature) _then) = __$ShapFeatureCopyWithImpl;
@override @useResult
$Res call({
 String featureName, double shapValue
});




}
/// @nodoc
class __$ShapFeatureCopyWithImpl<$Res>
    implements _$ShapFeatureCopyWith<$Res> {
  __$ShapFeatureCopyWithImpl(this._self, this._then);

  final _ShapFeature _self;
  final $Res Function(_ShapFeature) _then;

/// Create a copy of ShapFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? featureName = null,Object? shapValue = null,}) {
  return _then(_ShapFeature(
featureName: null == featureName ? _self.featureName : featureName // ignore: cast_nullable_to_non_nullable
as String,shapValue: null == shapValue ? _self.shapValue : shapValue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
