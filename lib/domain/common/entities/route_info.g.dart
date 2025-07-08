// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RouteInfo _$RouteInfoFromJson(Map<String, dynamic> json) => _RouteInfo(
  name: json['name'] as String,
  path: json['path'] as String,
  tabIndex: (json['tabIndex'] as num?)?.toInt(),
  prefixPath: json['prefixPath'] as String?,
  pathParams: json['pathParams'] as Map<String, dynamic>?,
  queryParams: json['queryParams'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$RouteInfoToJson(_RouteInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'tabIndex': instance.tabIndex,
      'prefixPath': instance.prefixPath,
      'pathParams': instance.pathParams,
      'queryParams': instance.queryParams,
    };
