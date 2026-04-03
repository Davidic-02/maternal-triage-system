// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'triage_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TriageEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TriageEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TriageEvent()';
}


}

/// @nodoc
class $TriageEventCopyWith<$Res>  {
$TriageEventCopyWith(TriageEvent _, $Res Function(TriageEvent) __);
}


/// Adds pattern-matching-related methods to [TriageEvent].
extension TriageEventPatterns on TriageEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _FilterChanged value)?  filterChanged,TResult Function( _SearchChanged value)?  searchChanged,TResult Function( _ResolvePatient value)?  resolvePatient,TResult Function( _ActiveQueueUpdated value)?  activeQueueUpdated,TResult Function( _ResolvedTodayUpdated value)?  resolvedTodayUpdated,TResult Function( _ErrorOccurred value)?  errorOccurred,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FilterChanged() when filterChanged != null:
return filterChanged(_that);case _SearchChanged() when searchChanged != null:
return searchChanged(_that);case _ResolvePatient() when resolvePatient != null:
return resolvePatient(_that);case _ActiveQueueUpdated() when activeQueueUpdated != null:
return activeQueueUpdated(_that);case _ResolvedTodayUpdated() when resolvedTodayUpdated != null:
return resolvedTodayUpdated(_that);case _ErrorOccurred() when errorOccurred != null:
return errorOccurred(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _FilterChanged value)  filterChanged,required TResult Function( _SearchChanged value)  searchChanged,required TResult Function( _ResolvePatient value)  resolvePatient,required TResult Function( _ActiveQueueUpdated value)  activeQueueUpdated,required TResult Function( _ResolvedTodayUpdated value)  resolvedTodayUpdated,required TResult Function( _ErrorOccurred value)  errorOccurred,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _FilterChanged():
return filterChanged(_that);case _SearchChanged():
return searchChanged(_that);case _ResolvePatient():
return resolvePatient(_that);case _ActiveQueueUpdated():
return activeQueueUpdated(_that);case _ResolvedTodayUpdated():
return resolvedTodayUpdated(_that);case _ErrorOccurred():
return errorOccurred(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _FilterChanged value)?  filterChanged,TResult? Function( _SearchChanged value)?  searchChanged,TResult? Function( _ResolvePatient value)?  resolvePatient,TResult? Function( _ActiveQueueUpdated value)?  activeQueueUpdated,TResult? Function( _ResolvedTodayUpdated value)?  resolvedTodayUpdated,TResult? Function( _ErrorOccurred value)?  errorOccurred,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FilterChanged() when filterChanged != null:
return filterChanged(_that);case _SearchChanged() when searchChanged != null:
return searchChanged(_that);case _ResolvePatient() when resolvePatient != null:
return resolvePatient(_that);case _ActiveQueueUpdated() when activeQueueUpdated != null:
return activeQueueUpdated(_that);case _ResolvedTodayUpdated() when resolvedTodayUpdated != null:
return resolvedTodayUpdated(_that);case _ErrorOccurred() when errorOccurred != null:
return errorOccurred(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( TriageFilter filter)?  filterChanged,TResult Function( String query)?  searchChanged,TResult Function( String patientId)?  resolvePatient,TResult Function( List<PatientRecord> records)?  activeQueueUpdated,TResult Function( List<PatientRecord> records)?  resolvedTodayUpdated,TResult Function( String message)?  errorOccurred,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case _SearchChanged() when searchChanged != null:
return searchChanged(_that.query);case _ResolvePatient() when resolvePatient != null:
return resolvePatient(_that.patientId);case _ActiveQueueUpdated() when activeQueueUpdated != null:
return activeQueueUpdated(_that.records);case _ResolvedTodayUpdated() when resolvedTodayUpdated != null:
return resolvedTodayUpdated(_that.records);case _ErrorOccurred() when errorOccurred != null:
return errorOccurred(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( TriageFilter filter)  filterChanged,required TResult Function( String query)  searchChanged,required TResult Function( String patientId)  resolvePatient,required TResult Function( List<PatientRecord> records)  activeQueueUpdated,required TResult Function( List<PatientRecord> records)  resolvedTodayUpdated,required TResult Function( String message)  errorOccurred,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _FilterChanged():
return filterChanged(_that.filter);case _SearchChanged():
return searchChanged(_that.query);case _ResolvePatient():
return resolvePatient(_that.patientId);case _ActiveQueueUpdated():
return activeQueueUpdated(_that.records);case _ResolvedTodayUpdated():
return resolvedTodayUpdated(_that.records);case _ErrorOccurred():
return errorOccurred(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( TriageFilter filter)?  filterChanged,TResult? Function( String query)?  searchChanged,TResult? Function( String patientId)?  resolvePatient,TResult? Function( List<PatientRecord> records)?  activeQueueUpdated,TResult? Function( List<PatientRecord> records)?  resolvedTodayUpdated,TResult? Function( String message)?  errorOccurred,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case _SearchChanged() when searchChanged != null:
return searchChanged(_that.query);case _ResolvePatient() when resolvePatient != null:
return resolvePatient(_that.patientId);case _ActiveQueueUpdated() when activeQueueUpdated != null:
return activeQueueUpdated(_that.records);case _ResolvedTodayUpdated() when resolvedTodayUpdated != null:
return resolvedTodayUpdated(_that.records);case _ErrorOccurred() when errorOccurred != null:
return errorOccurred(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements TriageEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TriageEvent.started()';
}


}




/// @nodoc


class _FilterChanged implements TriageEvent {
  const _FilterChanged(this.filter);
  

 final  TriageFilter filter;

/// Create a copy of TriageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterChangedCopyWith<_FilterChanged> get copyWith => __$FilterChangedCopyWithImpl<_FilterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterChanged&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,filter);

@override
String toString() {
  return 'TriageEvent.filterChanged(filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$FilterChangedCopyWith<$Res> implements $TriageEventCopyWith<$Res> {
  factory _$FilterChangedCopyWith(_FilterChanged value, $Res Function(_FilterChanged) _then) = __$FilterChangedCopyWithImpl;
@useResult
$Res call({
 TriageFilter filter
});




}
/// @nodoc
class __$FilterChangedCopyWithImpl<$Res>
    implements _$FilterChangedCopyWith<$Res> {
  __$FilterChangedCopyWithImpl(this._self, this._then);

  final _FilterChanged _self;
  final $Res Function(_FilterChanged) _then;

/// Create a copy of TriageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(_FilterChanged(
null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TriageFilter,
  ));
}


}

/// @nodoc


class _SearchChanged implements TriageEvent {
  const _SearchChanged(this.query);
  

 final  String query;

/// Create a copy of TriageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchChangedCopyWith<_SearchChanged> get copyWith => __$SearchChangedCopyWithImpl<_SearchChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'TriageEvent.searchChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchChangedCopyWith<$Res> implements $TriageEventCopyWith<$Res> {
  factory _$SearchChangedCopyWith(_SearchChanged value, $Res Function(_SearchChanged) _then) = __$SearchChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchChangedCopyWithImpl<$Res>
    implements _$SearchChangedCopyWith<$Res> {
  __$SearchChangedCopyWithImpl(this._self, this._then);

  final _SearchChanged _self;
  final $Res Function(_SearchChanged) _then;

/// Create a copy of TriageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResolvePatient implements TriageEvent {
  const _ResolvePatient(this.patientId);
  

 final  String patientId;

/// Create a copy of TriageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResolvePatientCopyWith<_ResolvePatient> get copyWith => __$ResolvePatientCopyWithImpl<_ResolvePatient>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResolvePatient&&(identical(other.patientId, patientId) || other.patientId == patientId));
}


@override
int get hashCode => Object.hash(runtimeType,patientId);

@override
String toString() {
  return 'TriageEvent.resolvePatient(patientId: $patientId)';
}


}

/// @nodoc
abstract mixin class _$ResolvePatientCopyWith<$Res> implements $TriageEventCopyWith<$Res> {
  factory _$ResolvePatientCopyWith(_ResolvePatient value, $Res Function(_ResolvePatient) _then) = __$ResolvePatientCopyWithImpl;
@useResult
$Res call({
 String patientId
});




}
/// @nodoc
class __$ResolvePatientCopyWithImpl<$Res>
    implements _$ResolvePatientCopyWith<$Res> {
  __$ResolvePatientCopyWithImpl(this._self, this._then);

  final _ResolvePatient _self;
  final $Res Function(_ResolvePatient) _then;

/// Create a copy of TriageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? patientId = null,}) {
  return _then(_ResolvePatient(
null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ActiveQueueUpdated implements TriageEvent {
  const _ActiveQueueUpdated(final  List<PatientRecord> records): _records = records;
  

 final  List<PatientRecord> _records;
 List<PatientRecord> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}


/// Create a copy of TriageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveQueueUpdatedCopyWith<_ActiveQueueUpdated> get copyWith => __$ActiveQueueUpdatedCopyWithImpl<_ActiveQueueUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveQueueUpdated&&const DeepCollectionEquality().equals(other._records, _records));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_records));

@override
String toString() {
  return 'TriageEvent.activeQueueUpdated(records: $records)';
}


}

/// @nodoc
abstract mixin class _$ActiveQueueUpdatedCopyWith<$Res> implements $TriageEventCopyWith<$Res> {
  factory _$ActiveQueueUpdatedCopyWith(_ActiveQueueUpdated value, $Res Function(_ActiveQueueUpdated) _then) = __$ActiveQueueUpdatedCopyWithImpl;
@useResult
$Res call({
 List<PatientRecord> records
});




}
/// @nodoc
class __$ActiveQueueUpdatedCopyWithImpl<$Res>
    implements _$ActiveQueueUpdatedCopyWith<$Res> {
  __$ActiveQueueUpdatedCopyWithImpl(this._self, this._then);

  final _ActiveQueueUpdated _self;
  final $Res Function(_ActiveQueueUpdated) _then;

/// Create a copy of TriageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? records = null,}) {
  return _then(_ActiveQueueUpdated(
null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<PatientRecord>,
  ));
}


}

/// @nodoc


class _ResolvedTodayUpdated implements TriageEvent {
  const _ResolvedTodayUpdated(final  List<PatientRecord> records): _records = records;
  

 final  List<PatientRecord> _records;
 List<PatientRecord> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}


/// Create a copy of TriageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResolvedTodayUpdatedCopyWith<_ResolvedTodayUpdated> get copyWith => __$ResolvedTodayUpdatedCopyWithImpl<_ResolvedTodayUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResolvedTodayUpdated&&const DeepCollectionEquality().equals(other._records, _records));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_records));

@override
String toString() {
  return 'TriageEvent.resolvedTodayUpdated(records: $records)';
}


}

/// @nodoc
abstract mixin class _$ResolvedTodayUpdatedCopyWith<$Res> implements $TriageEventCopyWith<$Res> {
  factory _$ResolvedTodayUpdatedCopyWith(_ResolvedTodayUpdated value, $Res Function(_ResolvedTodayUpdated) _then) = __$ResolvedTodayUpdatedCopyWithImpl;
@useResult
$Res call({
 List<PatientRecord> records
});




}
/// @nodoc
class __$ResolvedTodayUpdatedCopyWithImpl<$Res>
    implements _$ResolvedTodayUpdatedCopyWith<$Res> {
  __$ResolvedTodayUpdatedCopyWithImpl(this._self, this._then);

  final _ResolvedTodayUpdated _self;
  final $Res Function(_ResolvedTodayUpdated) _then;

/// Create a copy of TriageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? records = null,}) {
  return _then(_ResolvedTodayUpdated(
null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<PatientRecord>,
  ));
}


}

/// @nodoc


class _ErrorOccurred implements TriageEvent {
  const _ErrorOccurred(this.message);
  

 final  String message;

/// Create a copy of TriageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorOccurredCopyWith<_ErrorOccurred> get copyWith => __$ErrorOccurredCopyWithImpl<_ErrorOccurred>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorOccurred&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TriageEvent.errorOccurred(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorOccurredCopyWith<$Res> implements $TriageEventCopyWith<$Res> {
  factory _$ErrorOccurredCopyWith(_ErrorOccurred value, $Res Function(_ErrorOccurred) _then) = __$ErrorOccurredCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorOccurredCopyWithImpl<$Res>
    implements _$ErrorOccurredCopyWith<$Res> {
  __$ErrorOccurredCopyWithImpl(this._self, this._then);

  final _ErrorOccurred _self;
  final $Res Function(_ErrorOccurred) _then;

/// Create a copy of TriageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_ErrorOccurred(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TriageState {

 TriageStatus get status; List<PatientRecord> get activeQueue; List<PatientRecord> get resolvedToday; TriageFilter get filter; String get searchQuery; String? get errorMessage;
/// Create a copy of TriageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TriageStateCopyWith<TriageState> get copyWith => _$TriageStateCopyWithImpl<TriageState>(this as TriageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TriageState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.activeQueue, activeQueue)&&const DeepCollectionEquality().equals(other.resolvedToday, resolvedToday)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(activeQueue),const DeepCollectionEquality().hash(resolvedToday),filter,searchQuery,errorMessage);

@override
String toString() {
  return 'TriageState(status: $status, activeQueue: $activeQueue, resolvedToday: $resolvedToday, filter: $filter, searchQuery: $searchQuery, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TriageStateCopyWith<$Res>  {
  factory $TriageStateCopyWith(TriageState value, $Res Function(TriageState) _then) = _$TriageStateCopyWithImpl;
@useResult
$Res call({
 TriageStatus status, List<PatientRecord> activeQueue, List<PatientRecord> resolvedToday, TriageFilter filter, String searchQuery, String? errorMessage
});




}
/// @nodoc
class _$TriageStateCopyWithImpl<$Res>
    implements $TriageStateCopyWith<$Res> {
  _$TriageStateCopyWithImpl(this._self, this._then);

  final TriageState _self;
  final $Res Function(TriageState) _then;

/// Create a copy of TriageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? activeQueue = null,Object? resolvedToday = null,Object? filter = null,Object? searchQuery = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TriageStatus,activeQueue: null == activeQueue ? _self.activeQueue : activeQueue // ignore: cast_nullable_to_non_nullable
as List<PatientRecord>,resolvedToday: null == resolvedToday ? _self.resolvedToday : resolvedToday // ignore: cast_nullable_to_non_nullable
as List<PatientRecord>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TriageFilter,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TriageState].
extension TriageStatePatterns on TriageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TriageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TriageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TriageState value)  $default,){
final _that = this;
switch (_that) {
case _TriageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TriageState value)?  $default,){
final _that = this;
switch (_that) {
case _TriageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TriageStatus status,  List<PatientRecord> activeQueue,  List<PatientRecord> resolvedToday,  TriageFilter filter,  String searchQuery,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TriageState() when $default != null:
return $default(_that.status,_that.activeQueue,_that.resolvedToday,_that.filter,_that.searchQuery,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TriageStatus status,  List<PatientRecord> activeQueue,  List<PatientRecord> resolvedToday,  TriageFilter filter,  String searchQuery,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TriageState():
return $default(_that.status,_that.activeQueue,_that.resolvedToday,_that.filter,_that.searchQuery,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TriageStatus status,  List<PatientRecord> activeQueue,  List<PatientRecord> resolvedToday,  TriageFilter filter,  String searchQuery,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TriageState() when $default != null:
return $default(_that.status,_that.activeQueue,_that.resolvedToday,_that.filter,_that.searchQuery,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TriageState extends TriageState {
  const _TriageState({this.status = TriageStatus.initial, final  List<PatientRecord> activeQueue = const [], final  List<PatientRecord> resolvedToday = const [], this.filter = TriageFilter.all, this.searchQuery = '', this.errorMessage}): _activeQueue = activeQueue,_resolvedToday = resolvedToday,super._();
  

@override@JsonKey() final  TriageStatus status;
 final  List<PatientRecord> _activeQueue;
@override@JsonKey() List<PatientRecord> get activeQueue {
  if (_activeQueue is EqualUnmodifiableListView) return _activeQueue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeQueue);
}

 final  List<PatientRecord> _resolvedToday;
@override@JsonKey() List<PatientRecord> get resolvedToday {
  if (_resolvedToday is EqualUnmodifiableListView) return _resolvedToday;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resolvedToday);
}

@override@JsonKey() final  TriageFilter filter;
@override@JsonKey() final  String searchQuery;
@override final  String? errorMessage;

/// Create a copy of TriageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TriageStateCopyWith<_TriageState> get copyWith => __$TriageStateCopyWithImpl<_TriageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TriageState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._activeQueue, _activeQueue)&&const DeepCollectionEquality().equals(other._resolvedToday, _resolvedToday)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_activeQueue),const DeepCollectionEquality().hash(_resolvedToday),filter,searchQuery,errorMessage);

@override
String toString() {
  return 'TriageState(status: $status, activeQueue: $activeQueue, resolvedToday: $resolvedToday, filter: $filter, searchQuery: $searchQuery, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TriageStateCopyWith<$Res> implements $TriageStateCopyWith<$Res> {
  factory _$TriageStateCopyWith(_TriageState value, $Res Function(_TriageState) _then) = __$TriageStateCopyWithImpl;
@override @useResult
$Res call({
 TriageStatus status, List<PatientRecord> activeQueue, List<PatientRecord> resolvedToday, TriageFilter filter, String searchQuery, String? errorMessage
});




}
/// @nodoc
class __$TriageStateCopyWithImpl<$Res>
    implements _$TriageStateCopyWith<$Res> {
  __$TriageStateCopyWithImpl(this._self, this._then);

  final _TriageState _self;
  final $Res Function(_TriageState) _then;

/// Create a copy of TriageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? activeQueue = null,Object? resolvedToday = null,Object? filter = null,Object? searchQuery = null,Object? errorMessage = freezed,}) {
  return _then(_TriageState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TriageStatus,activeQueue: null == activeQueue ? _self._activeQueue : activeQueue // ignore: cast_nullable_to_non_nullable
as List<PatientRecord>,resolvedToday: null == resolvedToday ? _self._resolvedToday : resolvedToday // ignore: cast_nullable_to_non_nullable
as List<PatientRecord>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TriageFilter,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
