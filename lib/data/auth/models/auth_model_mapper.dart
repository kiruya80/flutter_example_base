import 'package:flutter_example_base/data/post/models/post_model.dart';

import '../../../domain/auth/entities/user.dart';
import '../../../domain/post/entities/post.dart';
import 'auth_model.dart';

/// ✅ Entity → Model 변환
extension AuthModelMapper on AuthModel {
  User toEntity() {
    return User(id: id, title: title, body: body, userId: userId);
  }
}

/// ✅ Model → Entity 변환
extension UserEntityMapper on User {
  AuthModel toModel() {
    return AuthModel(id: id, title: title, body: body, userId: userId);
  }
}
