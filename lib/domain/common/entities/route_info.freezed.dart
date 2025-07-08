// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RouteInfo {

 String get name; String get path; int? get tabIndex; String? get prefixPath; Map<String, dynamic>? get pathParams; Map<String, dynamic>? get queryParams;
/// Create a copy of RouteInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteInfoCopyWith<RouteInfo> get copyWith => _$RouteInfoCopyWithImpl<RouteInfo>(this as RouteInfo, _$identity);

  /// Serializes this RouteInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path)&&(identical(other.tabIndex, tabIndex) || other.tabIndex == tabIndex)&&(identical(other.prefixPath, prefixPath) || other.prefixPath == prefixPath)&&const DeepCollectionEquality().equals(other.pathParams, pathParams)&&const DeepCollectionEquality().equals(other.queryParams, queryParams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,path,tabIndex,prefixPath,const DeepCollectionEquality().hash(pathParams),const DeepCollectionEquality().hash(queryParams));

@override
String toString() {
  return 'RouteInfo(name: $name, path: $path, tabIndex: $tabIndex, prefixPath: $prefixPath, pathParams: $pathParams, queryParams: $queryParams)';
}


}

/// @nodoc
abstract mixin class $RouteInfoCopyWith<$Res>  {
  factory $RouteInfoCopyWith(RouteInfo value, $Res Function(RouteInfo) _then) = _$RouteInfoCopyWithImpl;
@useResult
$Res call({
 String name, String path, int? tabIndex, String? prefixPath, Map<String, dynamic>? pathParams, Map<String, dynamic>? queryParams
});




}
/// @nodoc
class _$RouteInfoCopyWithImpl<$Res>
    implements $RouteInfoCopyWith<$Res> {
  _$RouteInfoCopyWithImpl(this._self, this._then);

  final RouteInfo _self;
  final $Res Function(RouteInfo) _then;

/// Create a copy of RouteInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? path = null,Object? tabIndex = freezed,Object? prefixPath = freezed,Object? pathParams = freezed,Object? queryParams = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,tabIndex: freezed == tabIndex ? _self.tabIndex : tabIndex // ignore: cast_nullable_to_non_nullable
as int?,prefixPath: freezed == prefixPath ? _self.prefixPath : prefixPath // ignore: cast_nullable_to_non_nullable
as String?,pathParams: freezed == pathParams ? _self.pathParams : pathParams // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,queryParams: freezed == queryParams ? _self.queryParams : queryParams // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RouteInfo implements RouteInfo {
  const _RouteInfo({required this.name, required this.path, this.tabIndex, this.prefixPath, final  Map<String, dynamic>? pathParams, final  Map<String, dynamic>? queryParams}): _pathParams = pathParams,_queryParams = queryParams;
  factory _RouteInfo.fromJson(Map<String, dynamic> json) => _$RouteInfoFromJson(json);

@override final  String name;
@override final  String path;
@override final  int? tabIndex;
@override final  String? prefixPath;
 final  Map<String, dynamic>? _pathParams;
@override Map<String, dynamic>? get pathParams {
  final value = _pathParams;
  if (value == null) return null;
  if (_pathParams is EqualUnmodifiableMapView) return _pathParams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _queryParams;
@override Map<String, dynamic>? get queryParams {
  final value = _queryParams;
  if (value == null) return null;
  if (_queryParams is EqualUnmodifiableMapView) return _queryParams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of RouteInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteInfoCopyWith<_RouteInfo> get copyWith => __$RouteInfoCopyWithImpl<_RouteInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RouteInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path)&&(identical(other.tabIndex, tabIndex) || other.tabIndex == tabIndex)&&(identical(other.prefixPath, prefixPath) || other.prefixPath == prefixPath)&&const DeepCollectionEquality().equals(other._pathParams, _pathParams)&&const DeepCollectionEquality().equals(other._queryParams, _queryParams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,path,tabIndex,prefixPath,const DeepCollectionEquality().hash(_pathParams),const DeepCollectionEquality().hash(_queryParams));

@override
String toString() {
  return 'RouteInfo(name: $name, path: $path, tabIndex: $tabIndex, prefixPath: $prefixPath, pathParams: $pathParams, queryParams: $queryParams)';
}


}

/// @nodoc
abstract mixin class _$RouteInfoCopyWith<$Res> implements $RouteInfoCopyWith<$Res> {
  factory _$RouteInfoCopyWith(_RouteInfo value, $Res Function(_RouteInfo) _then) = __$RouteInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, String path, int? tabIndex, String? prefixPath, Map<String, dynamic>? pathParams, Map<String, dynamic>? queryParams
});




}
/// @nodoc
class __$RouteInfoCopyWithImpl<$Res>
    implements _$RouteInfoCopyWith<$Res> {
  __$RouteInfoCopyWithImpl(this._self, this._then);

  final _RouteInfo _self;
  final $Res Function(_RouteInfo) _then;

/// Create a copy of RouteInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? path = null,Object? tabIndex = freezed,Object? prefixPath = freezed,Object? pathParams = freezed,Object? queryParams = freezed,}) {
  return _then(_RouteInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,tabIndex: freezed == tabIndex ? _self.tabIndex : tabIndex // ignore: cast_nullable_to_non_nullable
as int?,prefixPath: freezed == prefixPath ? _self.prefixPath : prefixPath // ignore: cast_nullable_to_non_nullable
as String?,pathParams: freezed == pathParams ? _self._pathParams : pathParams // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,queryParams: freezed == queryParams ? _self._queryParams : queryParams // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
