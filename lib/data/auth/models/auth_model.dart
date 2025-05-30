import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';
part 'auth_model.freezed.dart';

@freezed
abstract class AuthModel with _$AuthModel {
  const factory AuthModel({
    required int? id,
    String? title,
    String? body,
    int? userId,
  }) = _AuthModel;

  /// 	•	API 응답 → UserInfoModel.fromJson()
  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  // /// ✅ Model → Entity
  // /// 	•	model.toEntity() → UseCase로 전달
  // User toEntity() {
  //   // return User(id: id, email: email, name: name);
  //   return User(id: id, title: title, body: body, userId: userId);
  // }
  //
  // // ✅ Entity → Model (선택사항)
  // factory AuthModel.fromEntity(User entity) {
  //   return AuthModel(
  //     id: entity.id,
  //     title: entity.title,
  //     body: entity.body,
  //     userId: entity.userId,
  //   );
  // }
}
