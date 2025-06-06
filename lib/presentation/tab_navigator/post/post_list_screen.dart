import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_example_base/presentation/tab_navigator/post/post_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/base/mixin/loading_listener_mixin.dart';
import '../../../app/base/mixin/navigation_listener_mixin.dart';
import '../../../app/providers/viewmodel/auth_viewmodel_providers.dart';
import '../../../app/providers/viewmodel/post_viewmodel_providers.dart';
import '../../../app/routes/app_routes_info.dart';
import '../../../shared/state/base_con_state.dart';
import '../../../app/base/mixin/error_listener_mixin.dart';
import '../../dialog/dialog_controller.dart';
import '../../dialog/dialog_request.dart';

class PostListScreen extends ConsumerStatefulWidget {
  const PostListScreen({super.key});

  @override
  ConsumerState<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState
    extends
        BaseConState<
          PostListScreen
        > // with ErrorListenerMixin, LoadingListenerMixin, NavigationListenerMixin {
    with
        ErrorListenerMixin<PostListState, PostListScreen>,
        NavigationListenerMixin<PostListState, PostListScreen>,
        LoadingListenerMixin<PostListState, PostListScreen> {
  @override
  void initState() {
    super.initState();

    // ✅ 로딩 리스너 등록
    setupErrorListener(ref, postListViewModelProvider);
    setupLoadingListener(ref, postListViewModelProvider);
    setupNavigationListener(ref, postListViewModelProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postListViewModelProvider.notifier).loadPosts();
      // ref.read(postListViewModelProvider.notifier).dialogTest();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postListViewModelProvider);
    QcLog.d('state ===== ${state.isLoading}');

    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: SafeArea(
        child:
            state.isLoading == true
                // ? const Center(child: CircularProgressIndicator())
                ? Container()
                : state.error != null
                ? Center(child: Text('Error: ${state.error?.message}'))
                : ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return ListTile(title: Text(post.title ?? ''), subtitle: Text(post.body ?? ''));
                  },
                ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              DialogController(ref).showDialog(
                DialogRequest(type: DialogType.confirm, title: "일반", message: '다이얼로그 띄우기',
                onCancelled: () {
                  QcLog.d('onCancelled');
                },
                onConfirmed: () {
                  QcLog.d('onConfirmed');
                }),
              );
            },
            child: const Icon(Icons.access_time_rounded),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              ref.read(postListViewModelProvider.notifier).dialogTest();
            },
            child: const Icon(Icons.access_time_rounded),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              ref.read(postListViewModelProvider.notifier).loadPosts();
            },
            child: const Icon(Icons.access_time_rounded),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              final state = ref.read(authViewModelProvider);
              if (state.isLoggedIn == true) {
                // context.push('/postAdd');
                context.pushNamed(AppRoutesInfo.postAdd.name);
              } else {
                // context.push('/login');
                context.pushNamed(AppRoutesInfo.login.name);
              }
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
