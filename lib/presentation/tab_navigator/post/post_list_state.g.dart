// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostListState _$PostListStateFromJson(Map<String, dynamic> json) => _PostListState(
  posts:
      (json['posts'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
  isLoading: json['isLoading'] as bool?,
  error: json['error'] == null ? null : Failure.fromJson(json['error'] as Map<String, dynamic>),
  navigateTo:
      json['navigateTo'] == null
          ? null
          : RouteInfo.fromJson(json['navigateTo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PostListStateToJson(_PostListState instance) => <String, dynamic>{
  'posts': instance.posts,
  'isLoading': instance.isLoading,
  'error': instance.error,
  'navigateTo': instance.navigateTo,
};
