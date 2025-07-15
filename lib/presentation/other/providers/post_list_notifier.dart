import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/failures.dart';
import '../../../data/post/providers/post_repository_provider.dart';
import '../../../domain/post/entities/post.dart';
import '../../../domain/post/repositories/post_repository.dart';

class PostListNotifier extends StateNotifier<AsyncValue<Either<Failure, List<Post>>>> {
  final PostRepository repository;

  PostListNotifier(this.repository) : super(const AsyncLoading()) {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    state = const AsyncLoading();
    final result = await repository.getPosts();
    state = AsyncData(result);
  }

  /// 🔄 데이터 새로고침 (기존 상태 유지하면서 로딩)
  Future<void> refreshPosts() async {
    state = const AsyncLoading();
    try {
      final posts = await repository.getPosts();
      state = AsyncValue.data(posts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 🧹 상태 초기화 (빈 리스트로)
  void resetPosts() {
    state = const AsyncValue.data(Right(<Post>[]));
  }
}

final postListNotifierProvider =
    StateNotifierProvider<PostListNotifier, AsyncValue<Either<Failure, List<Post>>>>((ref) {
      final repo = ref.read(postRepositoryProvider);
      return PostListNotifier(repo);
    });
