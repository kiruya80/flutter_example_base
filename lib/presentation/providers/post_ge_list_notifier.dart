import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/providers/post_repository_provider.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../../utils/print_log.dart';

part 'post_ge_list_notifier.g.dart';

@riverpod
class PostListNotifier extends _$PostListNotifier {
  late final PostRepository _repository;

  ///
  /// ref.invalidate(postListNotifierProvider);
  /// → 이걸 사용하면 build()가 다시 실행되어 API도 다시 호출됩니다.
  /// (일종의 프로바이더 리셋 기능)
  @override
  FutureOr<List<Post>> build() async {
    QcLog.d('build 초기화');
    _repository = ref.read(postRepositoryProvider);
    return await _fetchPosts();
  }

  Future<List<Post>> _fetchPosts() async {
    try {
      final posts = await _repository.getPosts();
      await Future.delayed(Duration(seconds: 1)); // 테스트용 지연
      return posts;
    } catch (e, st) {
      // build()에서 예외 발생 시 상태가 AsyncError가 됨
      rethrow;
    }
  }

  Future<void> refreshPosts() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await _fetchPosts());
  }

  void resetPosts() {
    state = const AsyncData([]); // 상태 초기화
  }
}
