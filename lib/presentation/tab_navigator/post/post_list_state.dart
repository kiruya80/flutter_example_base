import '../../../core/error/failures.dart';
import '../../../domain/post/entities/post.dart';
import '../../../app/base/base_ui_status.dart';

///
///
///
class PostListState extends BaseUiStatus {
  @override
  final bool isLoading;
  @override
  final Failure? error;
  @override
  final String? navigateTo;

  final List<Post> posts;

    PostListState({
    this.isLoading = false,
    this.error,
    this.navigateTo,
    this.posts = const [],
  });

  PostListState copyWith({
    bool? isLoading,
    Failure? error,
    String? navigateTo,
    List<Post>? posts,
  }) {
    return PostListState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      navigateTo: navigateTo,
      posts: posts ?? this.posts,
    );
  }

  factory PostListState.initial() =>   PostListState(posts: [], isLoading: false, error: null);
  // final List<Post> posts;
  //
  // PostListState({required this.posts, super.isLoading, super.error});
  //
  // factory PostListState.initial() => PostListState(posts: [], isLoading: false, error: null);
  //
  // PostListState copyWith({List<Post>? posts, bool? isLoading, Failure? error}) {
  //   return PostListState(
  //     posts: posts ?? this.posts,
  //     isLoading: isLoading ?? this.isLoading,
  //     error: error ?? this.error,
  //   );
  // }

}
