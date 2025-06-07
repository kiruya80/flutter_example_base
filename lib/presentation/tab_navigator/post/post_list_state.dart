import '../../../core/error/failures.dart';
import '../../../domain/common/entities/route_info.dart';
import '../../../domain/post/entities/post.dart';
import '../../../shared/base/base_ui_status.dart';

///
///
///
class PostListState extends BaseUiStatus {
  final List<Post> posts;

  const PostListState({
    this.posts = const [],
    super.isLoading,
    super.error,
    super.navigateTo,
  });

  PostListState copyWith({
    List<Post>? posts,

    bool? isLoading,
    Failure? error,
    RouteInfo? navigateTo,
  }) {
    return PostListState(
      posts: posts ?? this.posts,

      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      navigateTo: navigateTo ?? this.navigateTo,
    );
  }

  factory PostListState.initial() =>
      PostListState(posts: [], isLoading: false, error: null);
}
