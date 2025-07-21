import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_example_base/presentation/tab_navigator/post/post_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers/viewmodel/post_viewmodel_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/common_utils.dart';
import '../../../shared/mixin/error_listener_mixin.dart';
import '../../../shared/mixin/loading_listener_mixin.dart';
import '../../../shared/mixin/navigation_listener_mixin.dart';
import '../../../shared/mixin/scroll_bottom_listener_mixin.dart';
import '../../../shared/state/base_con_state.dart';
import '../../../core/controller/dialog_controller.dart';
import '../../../domain/common/entities/dialog_request.dart';
import '../../../shared/widgets/common/my_sliver_persistent_header_delegate.dart';
import '../../../shared/widgets/common/refresh_more_scrollview.dart';
import '../../../shared/widgets/page/common_edge_page.dart';
import '../../widgets/item_title.dart';

class PostListScreen extends ConsumerStatefulWidget {
  final ScrollController? mainNavScrollController;

  const PostListScreen({super.key, this.mainNavScrollController});

  @override
  ConsumerState<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends BaseConState<PostListScreen>
    with
        ErrorListenerMixin<PostListState, PostListScreen>,
        NavigationListenerMixin<PostListState, PostListScreen>,
        LoadingListenerMixin<PostListState, PostListScreen>,
        ScrollBottomListenerMixin<PostListScreen> {
  // 100개의 샘플 텍스트 리스트 생성
  final items = List.generate(100, (index) => 'Item ${index + 1}');

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
  void onScrollBottomReached() {
    _fetchMore();
  }

  _fetchMore() {
    QcLog.d("📦 _fetchMore");
    Fluttertoast.showToast(msg: "${GoRouterState.of(context).topRoute?.name} 더보기 호출");
  }

  Future<void> _refresh() async {
    // setState(() {
    //   items = [];
    //   netState = NetState.Loading;
    // });
    await Future.delayed(const Duration(seconds: 2));
    // setState(() {
    //   items = List.generate(50, (index) => 'Item ${index + 1}');
    //   netState = NetState.Completed;
    // });
  }

  @override
  Widget build(BuildContext context) {
    // return SimpleEdgeContentPage(
    //   child: _content(),
    //   // controller: widget.mainNavScrollController,
    //   backgroundColor: Theme.of(context).colorScheme.surface,
    //   //   isMoreDataScroll: MoreDataScroll.HAS,
    //   isPhysics: true,
    //   onRefresh: () async {
    //     QcLog.d('onRefresh ======');
    //     _refresh();
    //   },
    // );
    return CommonEdgePage(
      child: refreshScroll(
        safeAreaTop: false,
        safeAreaBottom: false,
        upDisappearHeader: MySliverPersistentHeaderDelegate(
          maxHeight: 80,
          minHeight: 80,
          child: ItemTitle('api & dialog'),
        ),
        fixedHeader: MySliverPersistentHeaderDelegate(maxHeight: 150, minHeight: 85, child: _tab()),
      ),
    );
  }

  _tab() {
    return Container(
      color: Colors.orange,
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        controller: widget.mainNavScrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ElevatedButton(
              child: Text('loadPosts'),
              onPressed: () {
                ref.read(postListViewModelProvider.notifier).loadPosts();
              },
            ),
            ElevatedButton(
              child: Text('일반 dialog'),
              onPressed: () {
                DialogController(ref).enqueue(
                  DialogRequest.confirm(
                    '다이얼로그 띄우기',
                    onCancel: () {
                      QcLog.d('onCancelled');
                    },
                    onConfirm: () {
                      QcLog.d('onConfirm');
                    },
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('error dialog'),
              onPressed: () {
                ref.read(postListViewModelProvider.notifier).dialogLoadError();
              },
            ),
            ElevatedButton(
              child: Text('Delayed dialog'),
              onPressed: () {
                ref.read(postListViewModelProvider.notifier).dialogDelayed();
              },
            ),
            ElevatedButton(
              child: Text('custom dialog'),
              onPressed: () {
                CommonUtils.isTablet(context);

                DialogController(ref).enqueue(
                  DialogRequest.custom(
                    ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(child: Text('${index + 1}')),
                          title: Text(items[index]),
                          subtitle: Text('This is item number ${index + 1}'),
                        );
                      },
                    ),
                    onCancel: () {
                      QcLog.d('onCancelled');
                    },
                    onConfirm: () {
                      QcLog.d('onConfirm');
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  refreshScroll({
    SliverPersistentHeaderDelegate? upDisappearHeader,
    SliverPersistentHeaderDelegate? fixedHeader,
    double? top,
    double? bottom,

    bool? safeAreaTop,
    bool? safeAreaBottom,
  }) {
    final state = ref.watch(postListViewModelProvider);
    return RefreshMoreScrollview(
      safeAreaTop: safeAreaTop,
      safeAreaBottom: safeAreaBottom,
      itemCount: state.posts.length,
      // isMoreDataScroll: _isLastPage(),
      netState: NetState.Completed,
      // emptyMsg: claimSelectionViewModel?.selectedTab.emptyMsg,
      onRefresh: () async {
        QcLog.d('onRefresh ======');
        _refresh();
      },
      onBottom: () async {
        // if (claimSelectionViewModel?.isLoad == false &&
        //     claimSelectionViewModel?.historyList.state == NetState.Completed &&
        //     claimSelectionViewModel?.historyList.isNextPage == true) {
        //   await claimSelectionViewModel?.requestHistoryList(isNext: true);
        // }
      },
      upDisappearHeader: upDisappearHeader,
      fixedHeader: fixedHeader,
      sliverChildBuilder: (context, index) {
        final post = state.posts[index];
        return ListTile(title: Text(post.title ?? ''), subtitle: Text(post.body ?? ''));
      },
    );
  }

  _content2() {
    final state = ref.watch(postListViewModelProvider);
    QcLog.d('state ===== ${state.toString()}');

    return Column(
      children: [
        ItemTitle('api & dialog'),

        /// 상단 선택 메뉴들
        Container(
          height: 100,
          child: SingleChildScrollView(
            controller: widget.mainNavScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ElevatedButton(
                  child: Text('loadPosts'),
                  onPressed: () {
                    ref.read(postListViewModelProvider.notifier).loadPosts();
                  },
                ),
                ElevatedButton(
                  child: Text('일반 dialog'),
                  onPressed: () {
                    DialogController(ref).enqueue(
                      DialogRequest.confirm(
                        '다이얼로그 띄우기',
                        onCancel: () {
                          QcLog.d('onCancelled');
                        },
                        onConfirm: () {
                          QcLog.d('onConfirm');
                        },
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text('error dialog'),
                  onPressed: () {
                    ref.read(postListViewModelProvider.notifier).dialogLoadError();
                  },
                ),
                ElevatedButton(
                  child: Text('Delayed dialog'),
                  onPressed: () {
                    ref.read(postListViewModelProvider.notifier).dialogDelayed();
                  },
                ),
                ElevatedButton(
                  child: Text('custom dialog'),
                  onPressed: () {
                    CommonUtils.isTablet(context);

                    DialogController(ref).enqueue(
                      DialogRequest.custom(
                        ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(child: Text('${index + 1}')),
                              title: Text(items[index]),
                              subtitle: Text('This is item number ${index + 1}'),
                            );
                          },
                        ),
                        onCancel: () {
                          QcLog.d('onCancelled');
                        },
                        onConfirm: () {
                          QcLog.d('onConfirm');
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),

        // Expanded(
        //   child:
        state.isLoading == true
            ? Container()
            : state.error != null
            ? Center(child: Text('Error: ${state.error?.message}'))
            : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ListTile(title: Text(post.title ?? ''), subtitle: Text(post.body ?? ''));
              },
            ),
        // ),
      ],
      // floatingActionButton: FloatingActionButton(
      //   heroTag: 'fab_tab1',
      //   onPressed: () {
      //     final state = ref.read(authViewModelProvider);
      //     if (state.isLoggedIn == true) {
      //       // context.push('/postAdd');
      //       context.pushNamed(AppRoutesInfo.postAdd.name);
      //     } else {
      //       // context.push('/login');
      //       context.pushNamed(AppRoutesInfo.login.name);
      //     }
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
