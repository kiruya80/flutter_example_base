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

  /// 	•	API 응답 → UserInfoModel.fromJson()
  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  /// ✅ Model → Entity
  /// 	•	model.toEntity() → UseCase로 전달
  User toEntity() {
    // return User(id: id, email: email, name: name);
    return User(id: id, title: title, body: body, userId: userId);
  }

  // ✅ Entity → Model (선택사항)
  factory AuthModel.fromEntity(User entity) {
    return AuthModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      userId: entity.userId,
    );
  }
}
