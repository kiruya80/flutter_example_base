import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.g.dart';

part 'post_model.freezed.dart';

@freezed
abstract class PostModel with _$PostModel {
  const factory PostModel({required int? id, String? title, String? body, int? userId}) =
      _PostModel;

  /// fromJson 생성자
  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
}
