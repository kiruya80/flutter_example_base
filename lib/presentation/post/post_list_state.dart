import '../../domain/post/entities/post.dart';

class PostListState {
  final List<Post> posts;
  final bool isLoading;
  final String? error;

  const PostListState({
    required this.posts,
    required this.isLoading,
    this.error,
  });

  factory PostListState.initial() => const PostListState(
        posts: [],
        isLoading: false,
        error: null,
      );

  PostListState copyWith({
    List<Post>? posts,
    bool? isLoading,
    String? error,
  }) {
    return PostListState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
