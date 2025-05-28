import 'package:flutter_example_base/domain/post/usecases/delete_post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/failures.dart';
import '../../domain/post/usecases/get_posts.dart';
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
class PostListViewModel extends StateNotifier<PostListState> {
  final GetPosts getPosts;
  final DeletePost deletePost;

  PostListViewModel(this.getPosts, this.deletePost) : super(PostListState.initial()) {
    loadPosts();
  }

  Future<void> loadPosts() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await getPosts();
    result.fold(
      (Failure failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (posts) {
        state = state.copyWith(isLoading: false, posts: posts);
      },
    );
  }
}
