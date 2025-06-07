import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_example_base/presentation/tab_navigator/post/post_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers/viewmodel/auth_viewmodel_providers.dart';
import '../../../app/providers/viewmodel/post_viewmodel_providers.dart';
import '../../../app/routes/app_routes_info.dart';
import '../../../shared/mixin/error_listener_mixin.dart';
import '../../../shared/mixin/loading_listener_mixin.dart';
import '../../../shared/mixin/navigation_listener_mixin.dart';
import '../../../shared/state/base_con_state.dart';
import '../../../core/controller/dialog_controller.dart';
import '../../../domain/common/entities/dialog_request.dart';
import '../../widgets/item_title.dart';

class PostListScreen extends ConsumerStatefulWidget {
  const PostListScreen({super.key});

  @override
  ConsumerState<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends BaseConState<PostListScreen>
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
      // ref.read(postListViewModelProvider.notifier).loadPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postListViewModelProvider);
    QcLog.d('state ===== ${state.toString()}');

    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: SafeArea(
        child: Column(
          children: [
            ItemTitle('api & dialog'),
            Expanded(
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
                          return ListTile(
                            title: Text(post.title ?? ''),
                            subtitle: Text(post.body ?? ''),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              DialogController(ref).enqueue(
                DialogRequest(
                  type: DialogType.confirm,
                  title: "일반",
                  message: '다이얼로그 띄우기',
                  onCancelled: () {
                    QcLog.d('onCancelled');
                  },
                  onConfirmed: () {
                    QcLog.d('onConfirmed');
                  },
                ),
              );
            },
            child: Text('일반 dialog', textAlign: TextAlign.center),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              ref.read(postListViewModelProvider.notifier).dialogLoadError();
            },
            child: Text('error dialog', textAlign: TextAlign.center),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              ref.read(postListViewModelProvider.notifier).dialogDelayed();
            },
            child: Text('dialog Delayed', textAlign: TextAlign.center),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              ref.read(postListViewModelProvider.notifier).loadPosts();
            },
            child: Text('Reload', textAlign: TextAlign.center),
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
