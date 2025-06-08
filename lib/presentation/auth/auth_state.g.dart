// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthState _$AuthStateFromJson(Map<String, dynamic> json) => _AuthState(
  isLoggedIn: json['isLoggedIn'] as bool?,
  user:
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
  errorMessage: json['errorMessage'] as String?,
  isLoading: json['isLoading'] as bool?,
  error:
      json['error'] == null
          ? null
          : Failure.fromJson(json['error'] as Map<String, dynamic>),
  navigateTo:
      json['navigateTo'] == null
          ? null
          : RouteInfo.fromJson(json['navigateTo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthStateToJson(_AuthState instance) =>
    <String, dynamic>{
      'isLoggedIn': instance.isLoggedIn,
      'user': instance.user,
      'errorMessage': instance.errorMessage,
      'isLoading': instance.isLoading,
      'error': instance.error,
      'navigateTo': instance.navigateTo,
    };
