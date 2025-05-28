import 'package:json_annotation/json_annotation.dart';
import '../../../domain/post/entities/post.dart';

part 'post_model.g.dart';

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
