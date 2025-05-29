import 'package:freezed_annotation/freezed_annotation.dart';

// part 'post.freezed.dart';
// part 'post.g.dart';
//
// @freezed
// @JsonSerializable()
// class Post with _$Post {
//   const factory Post({
//     required int id,
//     required String title,
//     required String body,
//     required int userId,
//   }) = _Post;
//
//   factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
// }

class Post {
  final int? id;
  final String? title;
  final String? body;
  final int? userId;

  Post({
    this.id,
    this.title,
    this.body,
    this.userId,
  });
}
