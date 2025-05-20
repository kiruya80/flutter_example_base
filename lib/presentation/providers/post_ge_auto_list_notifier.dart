import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/error/failures.dart';
import '../../data/providers/post_repository_provider.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../../utils/print_log.dart';

part 'post_ge_auto_list_notifier.g.dart';

///
/// 초기값으로 api 호출
///
/// Future<AsyncValue<...>>
/// ❌ 직접 state = ... 불가능
/// ✅ AsyncNotifier에서 초기 로딩 상태 포함한 패턴
///
/// Future<void> 또는 void
/// ✅ state = ... 직접 조작 가능
/// ✅ AsyncNotifier에서 상태 수동으로 관리할 때 사용
///
/// 초기에 데이터를 로딩하고 이후에 state를 변경하려면
///
/// @override
// Future<void> build() async {
//   state = const AsyncValue.loading(); // ✅ 가능해짐
//   try {
//     final result = await _repository.getPosts();
//     state = AsyncValue.data(result);
//   } catch (e, st) {
//     state = AsyncValue.error(e, st);
//   }
// }
///
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

  void resetPosts()   {
    // Either<Failure, List<Post>> emptyPostListResult = Right(<Post>[]);
    // // Either 값을 확인하는 방법
    // emptyPostListResult.fold(
    //       (failure) {
    //     print('실패: $failure');
    //   },
    //       (postList) {
    //     print('성공 (빈 리스트): $postList'); // 출력: 성공 (빈 리스트): []
    //     print('리스트 타입: ${postList.runtimeType}'); // 출력: 리스트 타입: List<Post>
    //   },
    // );
    // state =   AsyncData(Right([]) as AsyncValue<Either<Failure, List<Post>>>);
    // state = AsyncValue.data(Right<List<Post>>([]));
    // state = AsyncValue.data<Either<Failure, List<Post>>>(Right<List<Post>>([]));
    // state = AsyncValue.data(Right(<Post>[]));
    // state =   AsyncValue.data(Right(<Post>[]));
    // state =   AsyncValue.data(Right([]));
    // state =   AsyncValue.guard(() => Right(<Post>[]));
  }

  Future<void> refreshPosts() async {
    /// 1번 작성법
    // try {
    //   state = const AsyncValue.loading();
    //   state = AsyncValue.data(await fetchPosts());
    // } catch (e, st) {
    //   state = AsyncValue.error(e, st);
    // }

    /// 2번 AsyncValue.guard를 이용하는 방법
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => fetchPosts());
  }
}
