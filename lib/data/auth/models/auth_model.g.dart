// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  body: json['body'] as String?,
  userId: (json['userId'] as num?)?.toInt(),
);

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'userId': instance.userId,
};
