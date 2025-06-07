import 'package:flutter_example_base/data/post/models/post_model.dart';

import '../../../domain/post/entities/post.dart';

/// ✅ Entity → Model 변환
extension PostModelMapper on PostModel {
  Post toEntity() {
    return Post(id: id, title: title, body: body, userId: userId);
  }
}

/// ✅ Model → Entity 변환
extension PostEntityMapper on Post {
  PostModel toModel() {
    return PostModel(id: id, title: title, body: body, userId: userId);
  }
}
