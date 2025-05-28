import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/viewmodel/auth_viewmodel_providers.dart';
import '../../application/providers/viewmodel/post_viewmodel_providers.dart';

class PostListPage extends ConsumerWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postListViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return ListTile(
                      title: Text(post.title ?? ''),
                      subtitle: Text(post.body ?? ''),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final state = ref.read(loginViewModelProvider);
          if (state.isLoggedIn == true) {
            context.push('/write');
          } else {
            context.push('/login');
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
