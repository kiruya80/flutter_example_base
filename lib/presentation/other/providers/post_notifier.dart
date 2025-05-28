import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/post/repositories/post_repository.dart';

part 'post_notifier.g.dart';

@riverpod
class PostNotifier extends _$PostNotifier {
  late final PostRepository _repository;

  @override
  Future<void> build() async {
    state = const AsyncValue.loading(); // ✅ 가능해짐
    try {
      final result = await _repository.getPosts();
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void resetPosts() {
    state = const AsyncValue.data([]);
  }
}
