// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent()';
}


}

/// @nodoc
class $OnboardingEventCopyWith<$Res>  {
$OnboardingEventCopyWith(OnboardingEvent _, $Res Function(OnboardingEvent) __);
}


/// Adds pattern-matching-related methods to [OnboardingEvent].
extension OnboardingEventPatterns on OnboardingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _PageChanged value)?  pageChanged,TResult Function( _NextPageRequested value)?  nextPageRequested,TResult Function( _TermsAccepted value)?  termsAccepted,TResult Function( _Completed value)?  completed,TResult Function( _AutoAdvance value)?  autoAdvance,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageChanged() when pageChanged != null:
return pageChanged(_that);case _NextPageRequested() when nextPageRequested != null:
return nextPageRequested(_that);case _TermsAccepted() when termsAccepted != null:
return termsAccepted(_that);case _Completed() when completed != null:
return completed(_that);case _AutoAdvance() when autoAdvance != null:
return autoAdvance(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _PageChanged value)  pageChanged,required TResult Function( _NextPageRequested value)  nextPageRequested,required TResult Function( _TermsAccepted value)  termsAccepted,required TResult Function( _Completed value)  completed,required TResult Function( _AutoAdvance value)  autoAdvance,}){
final _that = this;
switch (_that) {
case _PageChanged():
return pageChanged(_that);case _NextPageRequested():
return nextPageRequested(_that);case _TermsAccepted():
return termsAccepted(_that);case _Completed():
return completed(_that);case _AutoAdvance():
return autoAdvance(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _PageChanged value)?  pageChanged,TResult? Function( _NextPageRequested value)?  nextPageRequested,TResult? Function( _TermsAccepted value)?  termsAccepted,TResult? Function( _Completed value)?  completed,TResult? Function( _AutoAdvance value)?  autoAdvance,}){
final _that = this;
switch (_that) {
case _PageChanged() when pageChanged != null:
return pageChanged(_that);case _NextPageRequested() when nextPageRequested != null:
return nextPageRequested(_that);case _TermsAccepted() when termsAccepted != null:
return termsAccepted(_that);case _Completed() when completed != null:
return completed(_that);case _AutoAdvance() when autoAdvance != null:
return autoAdvance(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page)?  pageChanged,TResult Function()?  nextPageRequested,TResult Function( bool accepted)?  termsAccepted,TResult Function()?  completed,TResult Function()?  autoAdvance,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageChanged() when pageChanged != null:
return pageChanged(_that.page);case _NextPageRequested() when nextPageRequested != null:
return nextPageRequested();case _TermsAccepted() when termsAccepted != null:
return termsAccepted(_that.accepted);case _Completed() when completed != null:
return completed();case _AutoAdvance() when autoAdvance != null:
return autoAdvance();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page)  pageChanged,required TResult Function()  nextPageRequested,required TResult Function( bool accepted)  termsAccepted,required TResult Function()  completed,required TResult Function()  autoAdvance,}) {final _that = this;
switch (_that) {
case _PageChanged():
return pageChanged(_that.page);case _NextPageRequested():
return nextPageRequested();case _TermsAccepted():
return termsAccepted(_that.accepted);case _Completed():
return completed();case _AutoAdvance():
return autoAdvance();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page)?  pageChanged,TResult? Function()?  nextPageRequested,TResult? Function( bool accepted)?  termsAccepted,TResult? Function()?  completed,TResult? Function()?  autoAdvance,}) {final _that = this;
switch (_that) {
case _PageChanged() when pageChanged != null:
return pageChanged(_that.page);case _NextPageRequested() when nextPageRequested != null:
return nextPageRequested();case _TermsAccepted() when termsAccepted != null:
return termsAccepted(_that.accepted);case _Completed() when completed != null:
return completed();case _AutoAdvance() when autoAdvance != null:
return autoAdvance();case _:
  return null;

}
}

}

/// @nodoc


class _PageChanged implements OnboardingEvent {
  const _PageChanged(this.page);
  

 final  int page;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageChangedCopyWith<_PageChanged> get copyWith => __$PageChangedCopyWithImpl<_PageChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageChanged&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,page);

@override
String toString() {
  return 'OnboardingEvent.pageChanged(page: $page)';
}


}

/// @nodoc
abstract mixin class _$PageChangedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$PageChangedCopyWith(_PageChanged value, $Res Function(_PageChanged) _then) = __$PageChangedCopyWithImpl;
@useResult
$Res call({
 int page
});




}
/// @nodoc
class __$PageChangedCopyWithImpl<$Res>
    implements _$PageChangedCopyWith<$Res> {
  __$PageChangedCopyWithImpl(this._self, this._then);

  final _PageChanged _self;
  final $Res Function(_PageChanged) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,}) {
  return _then(_PageChanged(
null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _NextPageRequested implements OnboardingEvent {
  const _NextPageRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NextPageRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.nextPageRequested()';
}


}




/// @nodoc


class _TermsAccepted implements OnboardingEvent {
  const _TermsAccepted(this.accepted);
  

 final  bool accepted;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TermsAcceptedCopyWith<_TermsAccepted> get copyWith => __$TermsAcceptedCopyWithImpl<_TermsAccepted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TermsAccepted&&(identical(other.accepted, accepted) || other.accepted == accepted));
}


@override
int get hashCode => Object.hash(runtimeType,accepted);

@override
String toString() {
  return 'OnboardingEvent.termsAccepted(accepted: $accepted)';
}


}

/// @nodoc
abstract mixin class _$TermsAcceptedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$TermsAcceptedCopyWith(_TermsAccepted value, $Res Function(_TermsAccepted) _then) = __$TermsAcceptedCopyWithImpl;
@useResult
$Res call({
 bool accepted
});




}
/// @nodoc
class __$TermsAcceptedCopyWithImpl<$Res>
    implements _$TermsAcceptedCopyWith<$Res> {
  __$TermsAcceptedCopyWithImpl(this._self, this._then);

  final _TermsAccepted _self;
  final $Res Function(_TermsAccepted) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accepted = null,}) {
  return _then(_TermsAccepted(
null == accepted ? _self.accepted : accepted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Completed implements OnboardingEvent {
  const _Completed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Completed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.completed()';
}


}




/// @nodoc


class _AutoAdvance implements OnboardingEvent {
  const _AutoAdvance();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutoAdvance);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.autoAdvance()';
}


}




/// @nodoc
mixin _$OnboardingState {

 int get currentPage; bool get hasAcceptedTerms; bool get isCompleted;
/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStateCopyWith<OnboardingState> get copyWith => _$OnboardingStateCopyWithImpl<OnboardingState>(this as OnboardingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingState&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasAcceptedTerms, hasAcceptedTerms) || other.hasAcceptedTerms == hasAcceptedTerms)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,currentPage,hasAcceptedTerms,isCompleted);

@override
String toString() {
  return 'OnboardingState(currentPage: $currentPage, hasAcceptedTerms: $hasAcceptedTerms, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $OnboardingStateCopyWith<$Res>  {
  factory $OnboardingStateCopyWith(OnboardingState value, $Res Function(OnboardingState) _then) = _$OnboardingStateCopyWithImpl;
@useResult
$Res call({
 int currentPage, bool hasAcceptedTerms, bool isCompleted
});




}
/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._self, this._then);

  final OnboardingState _self;
  final $Res Function(OnboardingState) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPage = null,Object? hasAcceptedTerms = null,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasAcceptedTerms: null == hasAcceptedTerms ? _self.hasAcceptedTerms : hasAcceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingState].
extension OnboardingStatePatterns on OnboardingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingState value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingState value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentPage,  bool hasAcceptedTerms,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that.currentPage,_that.hasAcceptedTerms,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentPage,  bool hasAcceptedTerms,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _OnboardingState():
return $default(_that.currentPage,_that.hasAcceptedTerms,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentPage,  bool hasAcceptedTerms,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that.currentPage,_that.hasAcceptedTerms,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingState implements OnboardingState {
  const _OnboardingState({this.currentPage = 0, this.hasAcceptedTerms = false, this.isCompleted = false});
  

@override@JsonKey() final  int currentPage;
@override@JsonKey() final  bool hasAcceptedTerms;
@override@JsonKey() final  bool isCompleted;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStateCopyWith<_OnboardingState> get copyWith => __$OnboardingStateCopyWithImpl<_OnboardingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingState&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasAcceptedTerms, hasAcceptedTerms) || other.hasAcceptedTerms == hasAcceptedTerms)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,currentPage,hasAcceptedTerms,isCompleted);

@override
String toString() {
  return 'OnboardingState(currentPage: $currentPage, hasAcceptedTerms: $hasAcceptedTerms, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStateCopyWith<$Res> implements $OnboardingStateCopyWith<$Res> {
  factory _$OnboardingStateCopyWith(_OnboardingState value, $Res Function(_OnboardingState) _then) = __$OnboardingStateCopyWithImpl;
@override @useResult
$Res call({
 int currentPage, bool hasAcceptedTerms, bool isCompleted
});




}
/// @nodoc
class __$OnboardingStateCopyWithImpl<$Res>
    implements _$OnboardingStateCopyWith<$Res> {
  __$OnboardingStateCopyWithImpl(this._self, this._then);

  final _OnboardingState _self;
  final $Res Function(_OnboardingState) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPage = null,Object? hasAcceptedTerms = null,Object? isCompleted = null,}) {
  return _then(_OnboardingState(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasAcceptedTerms: null == hasAcceptedTerms ? _self.hasAcceptedTerms : hasAcceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
