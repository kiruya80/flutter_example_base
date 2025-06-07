import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_person.freezed.dart';
part 'test_person.g.dart';

///
/// freezed_annotation: ^3.0.0
///
/// sealed 또는 abstract
///
/// Person mPerson = Person(age: 1, firstName: 'ffff', lastName: 'lllll');
/// // 값 변경 및 복사
/// var person = mPerson.copyWith(lastName: 'adadadadad');
///
/// // JSON 직렬화
/// final json = mPerson.toJson();
///
/// // 역직렬화
/// final postFromJson = Person.fromJson(json);
///
@freezed
sealed class TestPerson with _$TestPerson {
  const factory TestPerson({
    required String firstName,
    required String lastName,
    required int age,
  }) = _TestPerson;

  factory TestPerson.fromJson(Map<String, dynamic> json) =>
      _$TestPersonFromJson(json);
}
