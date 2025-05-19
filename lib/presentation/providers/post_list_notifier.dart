import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers/post_repository_provider.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';

class PostListNotifier extends StateNotifier<AsyncValue<List<Post>>> {
  final PostRepository repository;

  PostListNotifier(this.repository) : super(const AsyncValue.loading()) {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      state = const AsyncValue.loading();
      final posts = await repository.getPosts();
      await Future.delayed(Duration(seconds: 1));
      state = AsyncValue.data(posts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void resetPosts() {
    state = const AsyncData([]); // 상태 초기화
  }
}

final postListNotifierProvider = StateNotifierProvider<PostListNotifier, AsyncValue<List<Post>>>((
  ref,
) {
  final repo = ref.watch(postRepositoryProvider);
  return PostListNotifier(repo);
});
