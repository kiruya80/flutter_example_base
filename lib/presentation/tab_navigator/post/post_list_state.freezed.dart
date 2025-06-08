// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostListState {

 List<Post> get posts; bool? get isLoading; Failure? get error; RouteInfo? get navigateTo;
/// Create a copy of PostListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostListStateCopyWith<PostListState> get copyWith => _$PostListStateCopyWithImpl<PostListState>(this as PostListState, _$identity);

  /// Serializes this PostListState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostListState&&const DeepCollectionEquality().equals(other.posts, posts)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.navigateTo, navigateTo) || other.navigateTo == navigateTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(posts),isLoading,error,navigateTo);

@override
String toString() {
  return 'PostListState(posts: $posts, isLoading: $isLoading, error: $error, navigateTo: $navigateTo)';
}


}

/// @nodoc
abstract mixin class $PostListStateCopyWith<$Res>  {
  factory $PostListStateCopyWith(PostListState value, $Res Function(PostListState) _then) = _$PostListStateCopyWithImpl;
@useResult
$Res call({
 List<Post> posts, bool? isLoading, Failure? error, RouteInfo? navigateTo
});


$FailureCopyWith<$Res>? get error;$RouteInfoCopyWith<$Res>? get navigateTo;

}
/// @nodoc
class _$PostListStateCopyWithImpl<$Res>
    implements $PostListStateCopyWith<$Res> {
  _$PostListStateCopyWithImpl(this._self, this._then);

  final PostListState _self;
  final $Res Function(PostListState) _then;

/// Create a copy of PostListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? posts = null,Object? isLoading = freezed,Object? error = freezed,Object? navigateTo = freezed,}) {
  return _then(_self.copyWith(
posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,isLoading: freezed == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Failure?,navigateTo: freezed == navigateTo ? _self.navigateTo : navigateTo // ignore: cast_nullable_to_non_nullable
as RouteInfo?,
  ));
}
/// Create a copy of PostListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}/// Create a copy of PostListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RouteInfoCopyWith<$Res>? get navigateTo {
    if (_self.navigateTo == null) {
    return null;
  }

  return $RouteInfoCopyWith<$Res>(_self.navigateTo!, (value) {
    return _then(_self.copyWith(navigateTo: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _PostListState implements PostListState {
  const _PostListState({required final  List<Post> posts, this.isLoading, this.error, this.navigateTo}): _posts = posts;
  factory _PostListState.fromJson(Map<String, dynamic> json) => _$PostListStateFromJson(json);

 final  List<Post> _posts;
@override List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override final  bool? isLoading;
@override final  Failure? error;
@override final  RouteInfo? navigateTo;

/// Create a copy of PostListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostListStateCopyWith<_PostListState> get copyWith => __$PostListStateCopyWithImpl<_PostListState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostListStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostListState&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.navigateTo, navigateTo) || other.navigateTo == navigateTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts),isLoading,error,navigateTo);

@override
String toString() {
  return 'PostListState(posts: $posts, isLoading: $isLoading, error: $error, navigateTo: $navigateTo)';
}


}

/// @nodoc
abstract mixin class _$PostListStateCopyWith<$Res> implements $PostListStateCopyWith<$Res> {
  factory _$PostListStateCopyWith(_PostListState value, $Res Function(_PostListState) _then) = __$PostListStateCopyWithImpl;
@override @useResult
$Res call({
 List<Post> posts, bool? isLoading, Failure? error, RouteInfo? navigateTo
});


@override $FailureCopyWith<$Res>? get error;@override $RouteInfoCopyWith<$Res>? get navigateTo;

}
/// @nodoc
class __$PostListStateCopyWithImpl<$Res>
    implements _$PostListStateCopyWith<$Res> {
  __$PostListStateCopyWithImpl(this._self, this._then);

  final _PostListState _self;
  final $Res Function(_PostListState) _then;

/// Create a copy of PostListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? posts = null,Object? isLoading = freezed,Object? error = freezed,Object? navigateTo = freezed,}) {
  return _then(_PostListState(
posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,isLoading: freezed == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Failure?,navigateTo: freezed == navigateTo ? _self.navigateTo : navigateTo // ignore: cast_nullable_to_non_nullable
as RouteInfo?,
  ));
}

/// Create a copy of PostListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}/// Create a copy of PostListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RouteInfoCopyWith<$Res>? get navigateTo {
    if (_self.navigateTo == null) {
    return null;
  }

  return $RouteInfoCopyWith<$Res>(_self.navigateTo!, (value) {
    return _then(_self.copyWith(navigateTo: value));
  });
}
}

// dart format on
