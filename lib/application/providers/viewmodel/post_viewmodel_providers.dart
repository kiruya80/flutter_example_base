import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../presentation/post/post_list_state.dart';
import '../../../presentation/post/post_list_view_model.dart';
import '../../../presentation/post/post_write_state.dart';
import '../../../presentation/post/post_write_view_model.dart';
import '../usecase/post_usecase_providers.dart';

/// PostListViewModel, PostEditViewModel provider
///
final postListViewModelProvider = StateNotifierProvider<PostListViewModel, PostListState>(
  (ref) {
    final getPosts = ref.watch(getPostsUseCaseProvider);
    final deletePost = ref.watch(deletePostUseCaseProvider);
    return PostListViewModel(getPosts, deletePost);
  },
);

final postWriteViewModelProvider = StateNotifierProvider<PostWriteViewModel, PostWriteState>((ref) {
  final createPost = ref.watch(createPostUseCaseProvider);
  return PostWriteViewModel(createPost);
});
