import 'package:flutter_example_base/domain/post/usecases/delete_post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/failures.dart';
import '../../../core/utils/print_log.dart';
import '../../../domain/common/entities/route_info.dart';
import '../../../domain/common/params/no_params.dart';
import '../../../domain/post/usecases/get_posts.dart';
import '../../../shared/base/base_view_model.dart';
import 'post_list_state.dart';

///
/// ✅ 정답: 기능의 맥락이 같다면 ViewModel 하나로 관리해도 된다
//
// 🔹 예시: 게시글 목록 화면
// 	•	PostListViewModel에서 아래 모두 수행 가능
// 	•	게시글 목록 조회 (GetPosts)
// 	•	게시글 삭제 (DeletePost)
// 	•	게시글 수정 버튼 눌렀을 때 상태 변경
///
// class PostListViewModel extends StateNotifier<PostListState> {
class PostListViewModel extends BaseViewModel<PostListState> {
  final GetPosts getPosts;
  final DeletePost deletePost;

  PostListViewModel(this.getPosts, this.deletePost) : super(PostListState.initial()) {
    // loadPosts();
  }

  Future<void> loadPosts() async {
    // state = const AsyncLoading();
    // state = state.copyWith(isLoading: true, error: null);
    setLoading(true);

    await Future.delayed(Duration(seconds: 1));

    final result = await getPosts(NoParams());
    QcLog.d('result ===== ${result.runtimeType} , ${result.toString()}');

    result.fold(
      (Failure failure) {
        // setLoading(false);
        state = state.copyWith(isLoading: false, error: failure);
      },
      (posts) {
        state = state.copyWith(isLoading: false, posts: posts);
      },
    );
  }

  Future<void> dialogDelayed() async {
    state = state.copyWith(error: CacheFailure('1번째 에러 1초뒤 팝업 추가'));

    await Future.delayed(Duration(seconds: 1));
    state = state.copyWith(error: ServerFailure('2번째 에러 1초뒤 팝업 추가'));

    await Future.delayed(Duration(seconds: 1));
    state = state.copyWith(error: ServerFailure('3번째 에러 1초뒤 팝업 추가'));
  }

  Future<void> dialogLoadError() async {
    state = state.copyWith(isLoading: true);

    await Future.delayed(Duration(seconds: 3));

    // state = state.copyWith(isLoading: false);
    state = state.copyWith(isLoading: false, error: ServerFailure('ServerFailure 에러'));
    // Future.delayed(Duration(milliseconds: 100), () {
    // state = state.copyWith(error: ServerFailure('ServerFailure 에러'));
    // });
  }

  @override
  PostListState updateState({bool? isLoading, Failure? error, RouteInfo? navigateTo}) {
    return state.copyWith(isLoading: isLoading, error: error, navigateTo: navigateTo);
  }

  // @override
  // PostListUiStatus copyWith({
  //   bool? isLoading,
  //   AppFailure? error,
  //   String? navigation,
  // }) {
  //   return state.copyWith(
  //     isLoading: isLoading,
  //     error: error,
  //     navigation: navigation,
  //   );
  // }
}
