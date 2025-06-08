// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_write_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostWriteState {

 bool? get isLoading; Failure? get error; RouteInfo? get navigateTo;
/// Create a copy of PostWriteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostWriteStateCopyWith<PostWriteState> get copyWith => _$PostWriteStateCopyWithImpl<PostWriteState>(this as PostWriteState, _$identity);

  /// Serializes this PostWriteState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostWriteState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.navigateTo, navigateTo) || other.navigateTo == navigateTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,error,navigateTo);

@override
String toString() {
  return 'PostWriteState(isLoading: $isLoading, error: $error, navigateTo: $navigateTo)';
}


}

/// @nodoc
abstract mixin class $PostWriteStateCopyWith<$Res>  {
  factory $PostWriteStateCopyWith(PostWriteState value, $Res Function(PostWriteState) _then) = _$PostWriteStateCopyWithImpl;
@useResult
$Res call({
 bool? isLoading, Failure? error, RouteInfo? navigateTo
});


$FailureCopyWith<$Res>? get error;$RouteInfoCopyWith<$Res>? get navigateTo;

}
/// @nodoc
class _$PostWriteStateCopyWithImpl<$Res>
    implements $PostWriteStateCopyWith<$Res> {
  _$PostWriteStateCopyWithImpl(this._self, this._then);

  final PostWriteState _self;
  final $Res Function(PostWriteState) _then;

/// Create a copy of PostWriteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = freezed,Object? error = freezed,Object? navigateTo = freezed,}) {
  return _then(_self.copyWith(
isLoading: freezed == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Failure?,navigateTo: freezed == navigateTo ? _self.navigateTo : navigateTo // ignore: cast_nullable_to_non_nullable
as RouteInfo?,
  ));
}
/// Create a copy of PostWriteState
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
}/// Create a copy of PostWriteState
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

class _PostWriteState implements PostWriteState {
  const _PostWriteState({this.isLoading, this.error, this.navigateTo});
  factory _PostWriteState.fromJson(Map<String, dynamic> json) => _$PostWriteStateFromJson(json);

@override final  bool? isLoading;
@override final  Failure? error;
@override final  RouteInfo? navigateTo;

/// Create a copy of PostWriteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostWriteStateCopyWith<_PostWriteState> get copyWith => __$PostWriteStateCopyWithImpl<_PostWriteState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostWriteStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostWriteState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.navigateTo, navigateTo) || other.navigateTo == navigateTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,error,navigateTo);

@override
String toString() {
  return 'PostWriteState(isLoading: $isLoading, error: $error, navigateTo: $navigateTo)';
}


}

/// @nodoc
abstract mixin class _$PostWriteStateCopyWith<$Res> implements $PostWriteStateCopyWith<$Res> {
  factory _$PostWriteStateCopyWith(_PostWriteState value, $Res Function(_PostWriteState) _then) = __$PostWriteStateCopyWithImpl;
@override @useResult
$Res call({
 bool? isLoading, Failure? error, RouteInfo? navigateTo
});


@override $FailureCopyWith<$Res>? get error;@override $RouteInfoCopyWith<$Res>? get navigateTo;

}
/// @nodoc
class __$PostWriteStateCopyWithImpl<$Res>
    implements _$PostWriteStateCopyWith<$Res> {
  __$PostWriteStateCopyWithImpl(this._self, this._then);

  final _PostWriteState _self;
  final $Res Function(_PostWriteState) _then;

/// Create a copy of PostWriteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = freezed,Object? error = freezed,Object? navigateTo = freezed,}) {
  return _then(_PostWriteState(
isLoading: freezed == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Failure?,navigateTo: freezed == navigateTo ? _self.navigateTo : navigateTo // ignore: cast_nullable_to_non_nullable
as RouteInfo?,
  ));
}

/// Create a copy of PostWriteState
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
}/// Create a copy of PostWriteState
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
