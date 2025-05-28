class PostWriteState {
  final bool isLoading;
  final String? errorMessage;

  const PostWriteState({
    required this.isLoading,
    this.errorMessage,
  });

  factory PostWriteState.initial() => const PostWriteState(isLoading: false);

  PostWriteState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return PostWriteState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
