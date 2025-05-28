import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../domain/post/entities/post.dart';

part 'post_model.g.dart';
// part 'post_model.freezed.dart';

// @freezed
// class PostModel with _$PostModel {
//   const factory PostModel({
//     required int? id,
//     required String? title,
//     required String? body,
//     required int? userId,
//   }) = _PostModel;
//
//   /// fromJson 생성자
//   factory PostModel.fromJson(Map<String, dynamic> json) =>
//       _$PostModelFromJson(json);
//
//   /// ✅ Model → Entity 변환
//   factory PostModel.fromEntity(Post entity) {
//     return PostModel(
//       id: entity.id,
//       title: entity.title,
//       body: entity.body,
//       userId: entity.userId,
//     );
//   }
// }
//
// extension PostModelX on PostModel {
//   /// ✅ Entity로 변환하는 toEntity 확장
//   Post toEntity() => Post(
//     id: id,
//     title: title,
//     body: body,
//     userId: userId,
//   );
// }

@JsonSerializable()
class PostModel {
  final int? id;
  final String? title;
  final String? body;
  @JsonKey(name: 'userId')
  final int? userId;

  PostModel({
      this.id,
      this.title,
      this.body,
      this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  Post toEntity() {
    return Post(id: id, title: title, body: body, userId: userId);
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
      userId: post.userId,
    );
  }
}

// @JsonSerializable()
// class PostModel extends Post {
//   PostModel({
//     required int userId,
//     required int id,
//     required String title,
//     required String body,
//   }) : super(userId: userId, id: id, title: title, body: body);
//
//   factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PostModelToJson(this);
// }
