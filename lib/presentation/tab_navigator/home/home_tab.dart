import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../app/di/scroll_notifier.dart';
import '../../../app/routes/app_routes_info.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/controller/dialog_controller.dart';
import '../../../core/theme/app_theme_provider.dart';
import '../../../core/utils/print_log.dart';
import '../../../shared/mixin/scroll_bottom_listener_mixin.dart';
import '../../../shared/state/base_con_state.dart';
import '../../../shared/widgets/common/refresh_more_scrollview.dart';
import '../../widgets/item_title.dart';
import '../../widgets/router_move_item.dart';

class HomeTab extends ConsumerStatefulWidget {
  final ScrollController? mainNavScrollController;

  const HomeTab({super.key, this.mainNavScrollController});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends BaseConState<HomeTab> with ScrollBottomListenerMixin {
  bool? isDark;

  // late void Function() _cancelLoadingListener;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // });
  }

  @override
  void onScrollBottomReached() {
    _fetchMore();
  }

  _fetchMore() {
    QcLog.d("📦 _fetchMore");
    Fluttertoast.showToast(msg: "${GoRouterState.of(context).topRoute?.name} 더보기 호출");
  }

  @override
  Widget build(BuildContext context) {
    // QcLog.d('build ===== $isThisPageVisible');
    // CommonUtils.isTablet(context);
    // ref.listen<bool>(  scrollReachedBottomProvider(
    //   GoRouterState.of(context).topRoute?.name ??
    //     GoRouterState.of(context).uri.toString(),
    //     // AppRoutesInfo.tabHome.name
    // ), (prev, next) {
    //   QcLog.d("📦 scrollReachedBottomProvider ==== $prev , $next");
    //   if (next == true) {
    //     _fetchMore();
    //   }
    // });

    final appThemeMode = ref.watch(appThemeModeProvider);
    isDark = appThemeMode == ThemeMode.dark;
    // TestUsual mTestUsual2 = TestUsual(id: '112233', isSelected: false);
    // TestUsual mTestUsual = TestUsual(id: '232323', isSelected: false, content: 'ccccc');
    // QcLog.d('mTestUsual ===== ${mTestUsual.toString()}');
    // var testUsual = mTestUsual.copyWith(content: 'lllllll');
    // QcLog.d('testUsual ===== ${testUsual.toJson()}');
    // JSON 직렬화
    // final json = mTestUsual.toJson();
    // 역직렬화
    // final postFromJson = TestUsual.fromJson(json);
    // QcLog.d('postFromJson ===== ${postFromJson.toJson()}');

    // return SimpleEdgeContentPage(
    //   // content:  _content(),
    //   content: refreshScroll(),
    //   controller: widget.mainNavScrollController,
    //   backgroundColor: Theme.of(context).colorScheme.surface,
    //   //   isMoreDataScroll: MoreDataScroll.HAS,
    // );

    return RefreshMoreScrollview(
      content: _content(),
      controller: widget.mainNavScrollController,
      // emptyMsg: claimSelectionViewModel?.selectedTab.emptyMsg,
      onRefresh: () async {
        QcLog.d('onRefresh ======');
        _refresh();
      },

      onBottom: () async {
        QcLog.d('onBottom ======');
      },
    );
  }

  bool _isRefreshing = false;

  Future<void> _refresh() async {
    DialogController(ref).showLoading();
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isRefreshing = false);
    DialogController(ref).hideLoading();
  }

  final items = List.generate(30, (index) => 'Item ${index + 1}');

  _content() {
    return SingleChildScrollView(
      // physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          ///
          ///
          ///
          ItemTitle('context Go & Push'),

          RouterMoveItem('테마 변경', () {
            QcLog.d('테마변경 === ');
            // final appThemeMode = ref.read(appThemeModeProvider);
            // isDark = appThemeMode == ThemeMode.dark;
            // ref.read(appThemeModeProvider.notifier).state =
            //     (isDark ?? false) ? ThemeMode.light : ThemeMode.dark;

            ref.read(scrollReachedBottomProvider(AppRoutesInfo.tabHome.name).notifier).state = true;
          }),

          RouterMoveItem('go(/home/detail)', () {
            // context.go('${AppTabRoutes.home.path}/${AppTabRoutes.detail.path}'); // context.go('/home/detail');
            //     context.pushNamed('details', pathParameters: {'id': '123'});
            // context.go('/home/detail');

            ref.read(scrollReachedBottomProvider(AppRoutesInfo.tabHome.name).notifier).state =
                false;
          }),

          RouterMoveItem('go(/detail)', () {
            context.go('/detail');
          }, isError: true),

          RouterMoveItem('push(/home/detail)', () {
            context.push('/home/detail');
          }),

          RouterMoveItem('push(/detail)', () {
            context.push('/detail');
          }, isError: true),

          RouterMoveItem('go(/home/homeCard)', () {
            // context.go('${AppTabRoutes.home.path}/${AppTabRoutes.detail.path}'); // context.go('/home/detail');
            //     context.pushNamed('details', pathParameters: {'id': '123'});
            context.go('/home/homeCard');
          }),
          RouterMoveItem('push(/home/homeCard)', () {
            context.push('/home/homeCard');
          }),

          ItemTitle('Setting go & push'),

          /// 스택 리셋 back 불가
          RouterMoveItem('go(/setting) 스택 리셋', () {
            context.go(AppRoutesInfo.setting.path);
          }),

          /// 스택 리셋 back 불가
          RouterMoveItem('goNamed(/setting) 스택 리셋', () {
            context.goNamed(AppRoutesInfo.setting.name);
          }),

          /// 스택 추가 back 가능
          RouterMoveItem('push(/setting) 스택 추가', () {
            context.push(AppRoutesInfo.setting.path);
          }),

          /// 스택 추가 back 가능
          RouterMoveItem('pushNamed(/setting) 스택 추가', () {
            context.pushNamed(AppRoutesInfo.setting.name);
          }),

          // RouterMoveItem('=====', () {}),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            itemCount: 50,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text('${index}'),
                subtitle: Text('This is item number ${index + 1}'),
              );
            },
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   heroTag: 'edgeToEdge',
      //   onPressed: () {
      //     context.pushNamed(AppRoutesInfo.edgeToEdge.name);
      //
      //     ///
      //     // showModalBottomSheet(
      //     //   context: context,
      //     //   backgroundColor: Colors.transparent,
      //     //   builder: (context) {
      //     //     return ClipRRect(
      //     //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      //     //       child: BackdropFilter(
      //     //         filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
      //     //         child: Container(
      //     //           height: 300,
      //     //           color: Colors.white.withOpacity(0.4),
      //     //           child: Center(child: Text('iOS 스타일 시트')),
      //     //         ),
      //     //       ),
      //     //     );
      //     //   },
      //     // );
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  refreshScroll({
    SliverPersistentHeaderDelegate? upDisappearHeader,
    SliverPersistentHeaderDelegate? fixedHeader,
    double? top,
    double? bottom,
  }) {
    return RefreshMoreScrollview(
      itemCount: items.length,
      // isMoreDataScroll: _isLastPage(),
      netState: NetState.Completed,
      // emptyMsg: claimSelectionViewModel?.selectedTab.emptyMsg,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 500));
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
        return Column(
          children: [
            // if (index == 0) Container(height: top),
            ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(isDark == true ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"),
              subtitle: Text('This is item number ${index + 1}'),
            ),
            // if (index + 1 == items.length) Container(height: bottom),
          ],
        );
      },
    );
  }
}
