import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/post/providers/post_repository_provider.dart';
import '../../../domain/post/usecases/create_post.dart';
import '../../../domain/post/usecases/delete_post.dart';
import '../../../domain/post/usecases/get_posts.dart';

/// create, update, delete, getPosts usecase
///
// postRepositoryProvider도 data 레이어에서 정의돼 있어야 함
final getPostsUseCaseProvider = Provider<GetPosts>((ref) {
  return GetPosts(ref.watch(postRepositoryProvider));
});

final createPostUseCaseProvider = Provider<CreatePost>((ref) {
  return CreatePost(ref.watch(postRepositoryProvider));
});

final deletePostUseCaseProvider = Provider<DeletePost>((ref) {
  return DeletePost(ref.watch(postRepositoryProvider));
});
