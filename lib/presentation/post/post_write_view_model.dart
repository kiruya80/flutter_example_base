import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/failures.dart';
import '../../domain/post/entities/post.dart';
import '../../domain/post/usecases/create_post.dart';
import 'post_write_state.dart';

class PostWriteViewModel extends StateNotifier<PostWriteState> {
  final CreatePost createPost;

  PostWriteViewModel(this.createPost) : super(PostWriteState.initial());

  Future<bool> submit(String title, String body) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // final userId = await SharedPrefsUtil.getUserId();
    // if (userId == null) {
    //   state = state.copyWith(isLoading: false, errorMessage: '로그인이 필요합니다.');
    //   return false;
    // }

    final result = await createPost(Post(id: 123, userId: 9999, title: title, body: body));
    return result.fold(
      (Failure failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }
}

class SharedPrefsUtil {}
