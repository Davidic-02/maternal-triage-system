// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'education_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EducationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EducationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EducationEvent()';
}


}

/// @nodoc
class $EducationEventCopyWith<$Res>  {
$EducationEventCopyWith(EducationEvent _, $Res Function(EducationEvent) __);
}


/// Adds pattern-matching-related methods to [EducationEvent].
extension EducationEventPatterns on EducationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _TabChanged value)?  tabChanged,TResult Function( _SearchChanged value)?  searchChanged,TResult Function( _Refresh value)?  refresh,TResult Function( _VideoTapped value)?  videoTapped,TResult Function( _Init value)?  init,required TResult orElse(),}){
@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _TabChanged value)?  tabChanged,TResult Function( _SearchChanged value)?  searchChanged,TResult Function( _Refresh value)?  refresh,TResult Function( _Init value)?  init,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TabChanged() when tabChanged != null:
return tabChanged(_that);case _SearchChanged() when searchChanged != null:
return searchChanged(_that);case _Refresh() when refresh != null:
return refresh(_that);case _VideoTapped() when videoTapped != null:
return videoTapped(_that);case _Init() when init != null:
return refresh(_that);case _Init() when init != null:
return init(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _TabChanged value)  tabChanged,required TResult Function( _SearchChanged value)  searchChanged,required TResult Function( _Refresh value)  refresh,required TResult Function( _VideoTapped value)  videoTapped,required TResult Function( _Init value)  init,}){
@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _TabChanged value)  tabChanged,required TResult Function( _SearchChanged value)  searchChanged,required TResult Function( _Refresh value)  refresh,required TResult Function( _Init value)  init,}){
final _that = this;
switch (_that) {
case _TabChanged():
return tabChanged(_that);case _SearchChanged():
return searchChanged(_that);case _Refresh():
return refresh(_that);case _VideoTapped():
return videoTapped(_that);case _Init():
return refresh(_that);case _Init():
return init(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _TabChanged value)?  tabChanged,TResult? Function( _SearchChanged value)?  searchChanged,TResult? Function( _Refresh value)?  refresh,TResult? Function( _VideoTapped value)?  videoTapped,TResult? Function( _Init value)?  init,}){
@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _TabChanged value)?  tabChanged,TResult? Function( _SearchChanged value)?  searchChanged,TResult? Function( _Refresh value)?  refresh,TResult? Function( _Init value)?  init,}){
final _that = this;
switch (_that) {
case _TabChanged() when tabChanged != null:
return tabChanged(_that);case _SearchChanged() when searchChanged != null:
return searchChanged(_that);case _Refresh() when refresh != null:
return refresh(_that);case _VideoTapped() when videoTapped != null:
return videoTapped(_that);case _Init() when init != null:
return refresh(_that);case _Init() when init != null:
return init(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String tab)?  tabChanged,TResult Function( String query)?  searchChanged,TResult Function()?  refresh,TResult Function( String youtubeVideoId)?  videoTapped,TResult Function()?  init,required TResult orElse(),}) {final _that = this;
@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String tab)?  tabChanged,TResult Function( String query)?  searchChanged,TResult Function()?  refresh,TResult Function()?  init,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TabChanged() when tabChanged != null:
return tabChanged(_that.tab);case _SearchChanged() when searchChanged != null:
return searchChanged(_that.query);case _Refresh() when refresh != null:
return refresh();case _VideoTapped() when videoTapped != null:
return videoTapped(_that.youtubeVideoId);case _Init() when init != null:
return refresh();case _Init() when init != null:
return init();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String tab)  tabChanged,required TResult Function( String query)  searchChanged,required TResult Function()  refresh,required TResult Function( String youtubeVideoId)  videoTapped,required TResult Function()  init,}) {final _that = this;
@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String tab)  tabChanged,required TResult Function( String query)  searchChanged,required TResult Function()  refresh,required TResult Function()  init,}) {final _that = this;
switch (_that) {
case _TabChanged():
return tabChanged(_that.tab);case _SearchChanged():
return searchChanged(_that.query);case _Refresh():
return refresh();case _VideoTapped():
return videoTapped(_that.youtubeVideoId);case _Init():
return refresh();case _Init():
return init();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String tab)?  tabChanged,TResult? Function( String query)?  searchChanged,TResult? Function()?  refresh,TResult? Function( String youtubeVideoId)?  videoTapped,TResult? Function()?  init,}) {final _that = this;
@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String tab)?  tabChanged,TResult? Function( String query)?  searchChanged,TResult? Function()?  refresh,TResult? Function()?  init,}) {final _that = this;
switch (_that) {
case _TabChanged() when tabChanged != null:
return tabChanged(_that.tab);case _SearchChanged() when searchChanged != null:
return searchChanged(_that.query);case _Refresh() when refresh != null:
return refresh();case _VideoTapped() when videoTapped != null:
return videoTapped(_that.youtubeVideoId);case _Init() when init != null:
return refresh();case _Init() when init != null:
return init();case _:
  return null;

}
}

}

/// @nodoc


class _TabChanged implements EducationEvent {
  const _TabChanged(this.tab);
  

 final  String tab;

/// Create a copy of EducationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TabChangedCopyWith<_TabChanged> get copyWith => __$TabChangedCopyWithImpl<_TabChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TabChanged&&(identical(other.tab, tab) || other.tab == tab));
}


@override
int get hashCode => Object.hash(runtimeType,tab);

@override
String toString() {
  return 'EducationEvent.tabChanged(tab: $tab)';
}


}

/// @nodoc
abstract mixin class _$TabChangedCopyWith<$Res> implements $EducationEventCopyWith<$Res> {
  factory _$TabChangedCopyWith(_TabChanged value, $Res Function(_TabChanged) _then) = __$TabChangedCopyWithImpl;
@useResult
$Res call({
 String tab
});




}
/// @nodoc
class __$TabChangedCopyWithImpl<$Res>
    implements _$TabChangedCopyWith<$Res> {
  __$TabChangedCopyWithImpl(this._self, this._then);

  final _TabChanged _self;
  final $Res Function(_TabChanged) _then;

/// Create a copy of EducationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tab = null,}) {
  return _then(_TabChanged(
null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SearchChanged implements EducationEvent {
  const _SearchChanged(this.query);
  

 final  String query;

/// Create a copy of EducationEvent
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
  return 'EducationEvent.searchChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchChangedCopyWith<$Res> implements $EducationEventCopyWith<$Res> {
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

/// Create a copy of EducationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Refresh implements EducationEvent {
  const _Refresh();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EducationEvent.refresh()';
}


}




/// @nodoc


class _VideoTapped implements EducationEvent {
  const _VideoTapped(this.youtubeVideoId);
  

 final  String youtubeVideoId;

/// Create a copy of EducationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoTappedCopyWith<_VideoTapped> get copyWith => __$VideoTappedCopyWithImpl<_VideoTapped>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoTapped&&(identical(other.youtubeVideoId, youtubeVideoId) || other.youtubeVideoId == youtubeVideoId));
}


@override
int get hashCode => Object.hash(runtimeType,youtubeVideoId);

@override
String toString() {
  return 'EducationEvent.videoTapped(youtubeVideoId: $youtubeVideoId)';
}


}

/// @nodoc
abstract mixin class _$VideoTappedCopyWith<$Res> implements $EducationEventCopyWith<$Res> {
  factory _$VideoTappedCopyWith(_VideoTapped value, $Res Function(_VideoTapped) _then) = __$VideoTappedCopyWithImpl;
@useResult
$Res call({
 String youtubeVideoId
});




}
/// @nodoc
class __$VideoTappedCopyWithImpl<$Res>
    implements _$VideoTappedCopyWith<$Res> {
  __$VideoTappedCopyWithImpl(this._self, this._then);

  final _VideoTapped _self;
  final $Res Function(_VideoTapped) _then;

/// Create a copy of EducationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? youtubeVideoId = null,}) {
  return _then(_VideoTapped(
null == youtubeVideoId ? _self.youtubeVideoId : youtubeVideoId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Init implements EducationEvent {
  const _Init();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Init);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EducationEvent.init()';
}


}




/// @nodoc
mixin _$EducationState {

 EducationStatus get status; List<EducationVideo> get allVideos; List<EducationGuide> get allGuides; String get selectedTab; String get searchQuery; String? get errorMessage; DateTime? get lastFetched;
/// Create a copy of EducationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EducationStateCopyWith<EducationState> get copyWith => _$EducationStateCopyWithImpl<EducationState>(this as EducationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EducationState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.allVideos, allVideos)&&const DeepCollectionEquality().equals(other.allGuides, allGuides)&&(identical(other.selectedTab, selectedTab) || other.selectedTab == selectedTab)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.lastFetched, lastFetched) || other.lastFetched == lastFetched));
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EducationState&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other.allVideos, allVideos)&&const DeepCollectionEquality().equals(other.allGuides, allGuides)&&(identical(other.selectedTab, selectedTab) || other.selectedTab == selectedTab)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.lastFetched, lastFetched) || other.lastFetched == lastFetched));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(allVideos),const DeepCollectionEquality().hash(allGuides),selectedTab,searchQuery,errorMessage,lastFetched);
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(allVideos),const DeepCollectionEquality().hash(allGuides),selectedTab,searchQuery,errorMessage,lastFetched);

@override
String toString() {
  return 'EducationState(status: $status, allVideos: $allVideos, allGuides: $allGuides, selectedTab: $selectedTab, searchQuery: $searchQuery, errorMessage: $errorMessage, lastFetched: $lastFetched)';
}


}

/// @nodoc
abstract mixin class $EducationStateCopyWith<$Res>  {
  factory $EducationStateCopyWith(EducationState value, $Res Function(EducationState) _then) = _$EducationStateCopyWithImpl;
@useResult
$Res call({
 EducationStatus status, List<EducationVideo> allVideos, List<EducationGuide> allGuides, String selectedTab, String searchQuery, String? errorMessage, DateTime? lastFetched
});




}
/// @nodoc
class _$EducationStateCopyWithImpl<$Res>
    implements $EducationStateCopyWith<$Res> {
  _$EducationStateCopyWithImpl(this._self, this._then);

  final EducationState _self;
  final $Res Function(EducationState) _then;

/// Create a copy of EducationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? allVideos = null,Object? allGuides = null,Object? selectedTab = null,Object? searchQuery = null,Object? errorMessage = freezed,Object? lastFetched = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? allVideos = null,Object? allGuides = null,Object? selectedTab = null,Object? searchQuery = null,Object? errorMessage = freezed,Object? lastFetched = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EducationStatus,allVideos: null == allVideos ? _self.allVideos : allVideos // ignore: cast_nullable_to_non_nullable
as List<EducationVideo>,allGuides: null == allGuides ? _self.allGuides : allGuides // ignore: cast_nullable_to_non_nullable
as List<EducationGuide>,selectedTab: null == selectedTab ? _self.selectedTab : selectedTab // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,lastFetched: freezed == lastFetched ? _self.lastFetched : lastFetched // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EducationState].
extension EducationStatePatterns on EducationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EducationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EducationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EducationState value)  $default,){
final _that = this;
switch (_that) {
case _EducationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EducationState value)?  $default,){
final _that = this;
switch (_that) {
case _EducationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EducationStatus status,  List<EducationVideo> allVideos,  List<EducationGuide> allGuides,  String selectedTab,  String searchQuery,  String? errorMessage,  DateTime? lastFetched)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EducationState() when $default != null:
return $default(_that.status,_that.allVideos,_that.allGuides,_that.selectedTab,_that.searchQuery,_that.errorMessage,_that.lastFetched);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EducationStatus status,  List<EducationVideo> allVideos,  List<EducationGuide> allGuides,  String selectedTab,  String searchQuery,  String? errorMessage,  DateTime? lastFetched)  $default,) {final _that = this;
switch (_that) {
case _EducationState():
return $default(_that.status,_that.allVideos,_that.allGuides,_that.selectedTab,_that.searchQuery,_that.errorMessage,_that.lastFetched);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EducationStatus status,  List<EducationVideo> allVideos,  List<EducationGuide> allGuides,  String selectedTab,  String searchQuery,  String? errorMessage,  DateTime? lastFetched)?  $default,) {final _that = this;
switch (_that) {
case _EducationState() when $default != null:
return $default(_that.status,_that.allVideos,_that.allGuides,_that.selectedTab,_that.searchQuery,_that.errorMessage,_that.lastFetched);case _:
  return null;

}
}

}

/// @nodoc


class _EducationState extends EducationState {
  const _EducationState({this.status = EducationStatus.initial, final  List<EducationVideo> allVideos = const [], final  List<EducationGuide> allGuides = const [], this.selectedTab = 'third', this.searchQuery = '', this.errorMessage, this.lastFetched}): _allVideos = allVideos,_allGuides = allGuides,super._();
  

@override@JsonKey() final  EducationStatus status;
 final  List<EducationVideo> _allVideos;
@override@JsonKey() List<EducationVideo> get allVideos {
  if (_allVideos is EqualUnmodifiableListView) return _allVideos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allVideos);
}

 final  List<EducationGuide> _allGuides;
@override@JsonKey() List<EducationGuide> get allGuides {
  if (_allGuides is EqualUnmodifiableListView) return _allGuides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allGuides);
}

@override@JsonKey() final  String selectedTab;
@override@JsonKey() final  String searchQuery;
@override final  String? errorMessage;
@override final  DateTime? lastFetched;

/// Create a copy of EducationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EducationStateCopyWith<_EducationState> get copyWith => __$EducationStateCopyWithImpl<_EducationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EducationState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._allVideos, _allVideos)&&const DeepCollectionEquality().equals(other._allGuides, _allGuides)&&(identical(other.selectedTab, selectedTab) || other.selectedTab == selectedTab)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.lastFetched, lastFetched) || other.lastFetched == lastFetched));
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EducationState&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other._allVideos, _allVideos)&&const DeepCollectionEquality().equals(other._allGuides, _allGuides)&&(identical(other.selectedTab, selectedTab) || other.selectedTab == selectedTab)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.lastFetched, lastFetched) || other.lastFetched == lastFetched));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_allVideos),const DeepCollectionEquality().hash(_allGuides),selectedTab,searchQuery,errorMessage,lastFetched);
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(_allVideos),const DeepCollectionEquality().hash(_allGuides),selectedTab,searchQuery,errorMessage,lastFetched);

@override
String toString() {
  return 'EducationState(status: $status, allVideos: $allVideos, allGuides: $allGuides, selectedTab: $selectedTab, searchQuery: $searchQuery, errorMessage: $errorMessage, lastFetched: $lastFetched)';
}


}

/// @nodoc
abstract mixin class _$EducationStateCopyWith<$Res> implements $EducationStateCopyWith<$Res> {
  factory _$EducationStateCopyWith(_EducationState value, $Res Function(_EducationState) _then) = __$EducationStateCopyWithImpl;
@override @useResult
$Res call({
 EducationStatus status, List<EducationVideo> allVideos, List<EducationGuide> allGuides, String selectedTab, String searchQuery, String? errorMessage, DateTime? lastFetched
});




}
/// @nodoc
class __$EducationStateCopyWithImpl<$Res>
    implements _$EducationStateCopyWith<$Res> {
  __$EducationStateCopyWithImpl(this._self, this._then);

  final _EducationState _self;
  final $Res Function(_EducationState) _then;

/// Create a copy of EducationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? allVideos = null,Object? allGuides = null,Object? selectedTab = null,Object? searchQuery = null,Object? errorMessage = freezed,Object? lastFetched = freezed,}) {
  return _then(_EducationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? allVideos = null,Object? allGuides = null,Object? selectedTab = null,Object? searchQuery = null,Object? errorMessage = freezed,Object? lastFetched = freezed,}) {
  return _then(_EducationState(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EducationStatus,allVideos: null == allVideos ? _self._allVideos : allVideos // ignore: cast_nullable_to_non_nullable
as List<EducationVideo>,allGuides: null == allGuides ? _self._allGuides : allGuides // ignore: cast_nullable_to_non_nullable
as List<EducationGuide>,selectedTab: null == selectedTab ? _self.selectedTab : selectedTab // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,lastFetched: freezed == lastFetched ? _self.lastFetched : lastFetched // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
