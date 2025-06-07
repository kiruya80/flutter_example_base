import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_usual.freezed.dart';

part 'test_usual.g.dart';

@freezed
abstract class TestUsual with _$TestUsual {
  // factory Usual({int a}) = _Usual;
  const factory TestUsual({
    required String id,
    required bool isSelected,
    String? content,
  }) = _TestUsual;

  factory TestUsual.fromJson(Map<String, dynamic> json) =>
      _$TestUsualFromJson(json);
}
