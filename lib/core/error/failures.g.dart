// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Failure _$FailureFromJson(Map<String, dynamic> json) =>
    _Failure(json['message'] as String, code: json['code'] as String?);

Map<String, dynamic> _$FailureToJson(_Failure instance) => <String, dynamic>{
  'message': instance.message,
  'code': instance.code,
};

_CacheFailure _$CacheFailureFromJson(Map<String, dynamic> json) =>
    _CacheFailure(json['message'] as String, code: json['code'] as String?);

Map<String, dynamic> _$CacheFailureToJson(_CacheFailure instance) => <String, dynamic>{
  'message': instance.message,
  'code': instance.code,
};

_ServerFailure _$ServerFailureFromJson(Map<String, dynamic> json) =>
    _ServerFailure(json['message'] as String, code: json['code'] as String?);

Map<String, dynamic> _$ServerFailureToJson(_ServerFailure instance) => <String, dynamic>{
  'message': instance.message,
  'code': instance.code,
};

_CacheException _$CacheExceptionFromJson(Map<String, dynamic> json) =>
    _CacheException(json['message'] as String, code: json['code'] as String?);

Map<String, dynamic> _$CacheExceptionToJson(_CacheException instance) => <String, dynamic>{
  'message': instance.message,
  'code': instance.code,
};
