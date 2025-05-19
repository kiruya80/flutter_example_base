import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/error/failures.dart';
import '../../data/providers/post_repository_provider.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../../utils/print_log.dart';

part 'post_ge_list_notifier.g.dart';

@riverpod
class PostGeListNotifier extends _$PostGeListNotifier {
  late final PostRepository _repository;

  ///
  /// ref.invalidate(postListNotifierProvider);
  /// → 이걸 사용하면 build()가 다시 실행되어 API도 다시 호출됩니다.
  /// (일종의 프로바이더 리셋 기능)
  ///
  @override
  AsyncValue<Either<Failure, List<Post>>> build() {
    _repository = ref.read(postRepositoryProvider);
    // return const AsyncValue.loading(); // 초기값
    return const AsyncValue.data(Right(<Post>[])); // 초기값으로 빈 Post 리스트
  }

  /// 데이터를 가져오는 메서드
  Future<void> fetchPosts() async {
    state = const AsyncValue.loading();
    try {
      final postsOrFailure = await _repository.getPosts();
      state = AsyncValue.data(postsOrFailure); // Either<Failure, List<Post>>
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 초기화 메서드
  void resetPosts() {
    state = const AsyncValue.data(Right(<Post>[]));
  }

  /// 새로고침 메서드
  Future<void> refreshPosts() async {
    try {
      state = const AsyncValue.loading();
      final postsOrFailure = await _repository.getPosts();
      state = AsyncValue.data(postsOrFailure);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
