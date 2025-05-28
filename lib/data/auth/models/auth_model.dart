import 'package:json_annotation/json_annotation.dart';
import '../../../domain/auth/entities/user.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel {
  // final int? id;
  // final String? email;
  // final String? name;
  //
  // AuthModel({
  //     this.id,
  //     this.email,
  //     this.name,
  // });
  final int? id;
  final String? title;
  final String? body;
  @JsonKey(name: 'userId')
  final int? userId;

  AuthModel({
    this.id,
    this.title,
    this.body,
    this.userId,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  User toEntity() {
    // return User(id: id, email: email, name: name);
    return User(id: id, title: title, body: body, userId: userId);
  }
}
