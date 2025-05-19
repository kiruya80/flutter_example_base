import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/providers/post_repository_provider.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../../utils/print_log.dart';

part 'post_ge_auto_list_notifier.g.dart';

@riverpod
class PostGeAutoListNotifier extends _$PostGeAutoListNotifier {
  late final PostRepository _repository;

  @override
  AsyncValue<List<Post>> build() {
    _repository = ref.read(postRepositoryProvider);
    return const AsyncValue.data([]); // ✅ 초기값만 설정
  }


  Future<void> fetchPosts() async {
    try {
      state = const AsyncValue.loading();
      final posts = await _repository.getPosts();
      await Future.delayed(Duration(seconds: 1));
      state = AsyncValue.data(posts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<List<Post>> _loadPosts() async {
    final posts = await _repository.getPosts();
    await Future.delayed(Duration(seconds: 1));
    return posts;
  }

  Future<void> refreshPosts() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadPosts());
  }

  void resetPosts() {
    state = const AsyncData([]); // 상태 초기화
  }
}
