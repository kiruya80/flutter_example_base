// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestPerson _$TestPersonFromJson(Map<String, dynamic> json) => _TestPerson(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  age: (json['age'] as num).toInt(),
);

Map<String, dynamic> _$TestPersonToJson(_TestPerson instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'age': instance.age,
    };
