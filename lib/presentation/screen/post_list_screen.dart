import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/print_log.dart';
import '../providers/post_ge_auto_list_notifier.dart';
import '../providers/post_list_notifier.dart';

class PostListScreen extends ConsumerWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    QcLog.d('PostListScreen === ');

    /// 프로바이터 상태 체크
    final postListAsync = ref.watch(postListNotifierProvider);

    /// 프로바이더 내 함수 실행등 위해서
    final postListNotifier = ref.watch(postListNotifierProvider.notifier);

    final postGeAutoListNotifierProvide = ref.watch(postGeAutoListNotifierProvider);

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
      body:
          // postListAsync.when(
          //   loading: () => CircularProgressIndicator(),
          //   error: (e, _) => Text('에러: $e'),
          //   data: (either) => either.fold(
          //         (failure) => Text('실패: ${failure.message}'),
          //         (posts) => ListView.builder(
          //       itemCount: posts.length,
          //       itemBuilder: (_, i) => Text(posts[i].title),
          //     ),
          //   ),
          // ),
          postGeAutoListNotifierProvide.when(
              data: (data) {
                /// data ==== AsyncData<Either<Failure, List<Post>>>
                QcLog.e('data ==== ${data.runtimeType}');
                return data.when(
                    data: (result) {
                      ///  result ==== Right<Failure, List<Post>>
                      QcLog.e('result ==== ${result.runtimeType}');
                      result.fold(
                        (failure) {
                          // Left(Failure)인 경우 실행될 로직
                          print('데이터 가져오기 실패: ${failure.message}');
                          // 실패 UI 업데이트 등
                        },
                        (posts) {
                          // Right(List<Post>)인 경우 실행될 로직
                          print('데이터 가져오기 성공! ${posts.length}개의 게시물');
                          // 성공적으로 가져온 posts를 사용하여 UI 업데이트 등

                          return ListView.builder(
                            itemCount: posts.length,
                            itemBuilder: (_, i) => Text(posts[i].title),
                          );
                        },
                      );
                    },
                    error: (e, e1) => Text('에러 : $e'),
                    loading: () => CircularProgressIndicator());
              },
              error: (e, e1) => Text('에러 : $e'),
              loading: () {
                return CircularProgressIndicator();
              }),

      // postListAsync.when(
      //   data: (posts) => posts.isEmpty
      //       ? const Center(child: Text('No posts.'))
      //       : ListView.builder(
      //     itemCount: posts.length,
      //     itemBuilder: (_, index) {
      //       final post = posts[index];
      //       QcLog.d('post toJson === ${post.toJson()}');
      //       return ListTile(
      //         title: Text(post.title),
      //         subtitle: Text(post.body),
      //       );
      //     },
      //   ),
      //   loading: () => const Center(child: CircularProgressIndicator()),
      //   error: (e, st) => Center(child: Text('Error: $e')),
      // ),
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
              label: const Text('Reset')),
        ],
      ),
    );
  }
}
