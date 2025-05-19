import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/error/failures.dart';
import '../../data/providers/post_repository_provider.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../../utils/print_log.dart';

part 'post_ge_auto_list_notifier.g.dart';

@riverpod
class PostGeAutoListNotifier extends _$PostGeAutoListNotifier {
  late final PostRepository _repository;

  @override
  Future<AsyncValue<Either<Failure, List<Post>>>> build() async {
    _repository = ref.read(postRepositoryProvider);
    return await fetchPosts();
  }

  Future<AsyncValue<Either<Failure, List<Post>>>> fetchPosts() async {
    try {
      final postsOrFailure = await _repository.getPosts();
      QcLog.d('postsOrFailure === ${postsOrFailure.runtimeType}'); /// Right<Failure, List<Post>>
      return AsyncValue.data(postsOrFailure);
    } catch (e, st) {
      return AsyncValue.error(e, st);
    }
  }

  void resetPosts() async {
    Either<Failure, List<Post>> emptyPostListResult = Right(<Post>[]);
    // Either 값을 확인하는 방법
    emptyPostListResult.fold(
          (failure) {
        print('실패: $failure');
      },
          (postList) {
        print('성공 (빈 리스트): $postList'); // 출력: 성공 (빈 리스트): []
        print('리스트 타입: ${postList.runtimeType}'); // 출력: 리스트 타입: List<Post>
      },
    );
    // state = Future.value(AsyncValue.data(Right(<Post>[])));

  }

  Future<void> refreshPosts() async {
    try {
      state = const AsyncValue.loading();
      state = AsyncValue.data(await fetchPosts());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
