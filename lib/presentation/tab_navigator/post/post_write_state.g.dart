// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_write_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostWriteState _$PostWriteStateFromJson(Map<String, dynamic> json) => _PostWriteState(
  isLoading: json['isLoading'] as bool?,
  error: json['error'] == null ? null : Failure.fromJson(json['error'] as Map<String, dynamic>),
  navigateTo:
      json['navigateTo'] == null
          ? null
          : RouteInfo.fromJson(json['navigateTo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PostWriteStateToJson(_PostWriteState instance) => <String, dynamic>{
  'isLoading': instance.isLoading,
  'error': instance.error,
  'navigateTo': instance.navigateTo,
};
