import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/print_log.dart';
import '../providers/post_list_notifier.dart';


class PostListScreen extends ConsumerWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    QcLog.d('PostListScreen === ');
    /// AsyncValue<List<Post>> 형태의 상태 값을 가져옴
    final postListAsync = ref.watch(postListNotifierProvider);

    /// PostListNotifier 인스턴스를 가져옴
    final postListNotifier = ref.read(postListNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              postListNotifier.fetchPosts();
            },
          ),
        ],
      ),
      body: postListAsync.when(
        data: (posts) => posts.isEmpty
            ? const Center(child: Text('No posts.'))
            : ListView.builder(
          itemCount: posts.length,
          itemBuilder: (_, index) {
            final post = posts[index];
            QcLog.d('post toJson === ${post.toJson()}');
            return ListTile(
              title: Text(post.title),
              subtitle: Text(post.body),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            onPressed: () => postListNotifier.fetchPosts(),
            icon: const Icon(Icons.download),
            label: const Text('Load'),
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            backgroundColor: Colors.red,
            onPressed: () => postListNotifier.resetPosts(),
            icon: const Icon(Icons.delete),
            label: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}