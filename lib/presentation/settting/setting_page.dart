import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/print_log.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/mixin/scroll_bottom_listener_mixin.dart';
import '../../shared/state/base_con_state.dart';
import '../../shared/widgets/common/edge_space_widget.dart';
import '../../shared/widgets/common/common_pop_scope_widget.dart';
import '../../shared/widgets/common/refresh_more_scrollview.dart';
import '../../shared/widgets/page/common_edge_page.dart';
import '../../shared/widgets/page/simple_edge_content_page.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends BaseConState<SettingPage>
    with ScrollBottomListenerMixin<SettingPage> {
  var items = List.generate(30, (index) => 'Item ${index + 1}');
  bool? isDark;
  NetState? netState = NetState.Completed;

  @override
  void onScrollBottomReached() {
    _fetchMore();
  }

  _fetchMore() {
    QcLog.d("📦 _fetchMore");
    Fluttertoast.showToast(msg: "${GoRouterState.of(context).topRoute?.name} 더보기 호출");
  }

  Future<void> _refresh() async {
    setState(() {
      items = [];
      netState = NetState.Loading;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      items = List.generate(50, (index) => 'Item ${index + 1}');
      netState = NetState.Completed;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(postListViewModelProvider.notifier).loadPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    QcLog.d('build =====  $isThisPageVisible ');
    // final name = GoRouter.of(context).routeInformationProvider.value.uri.toString();
    // QcLog.d('name =====  $name ');
    // final routeMatchList = GoRouter.of(context).routerDelegate.currentConfiguration;
    // QcLog.d('routeMatchList =====  ${routeMatchList.toString()} ');

    // final matches = GoRouter.of(context).routerDelegate.currentConfiguration.matches;
    // for (final match in matches) {
    //   print('Matched Route : ${match.route.toString()}');
    // }

    // final currentLocation = GoRouter.of(context).location;
    // print('현재 경로: $currentLocation');

    return CommonPopScopeWidget(child: getRefresh());
  }

  _content1() {
    return SimpleEdgeContentPage(
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(onPressed: () {}, child: const Text('Top')),
          ),

          Spacer(),
          ElevatedButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop(); // 뒤로 가기
              }
            },
            child: const Text('Back'),
          ),

          ElevatedButton(
            onPressed: () {
              setState(() {
                isTop = !isTop;
              });
            },
            child: Text('isTop : $isTop ${isTop == false ? '엣지' : '노엣지'}'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isBottom = !isBottom;
              });
            },
            child: Text('isBottom : $isBottom ${isBottom == false ? '엣지' : '노엣지'}'),
          ),
          Spacer(),

          ///
          /// android 15 sdk 35부터
          /// 1. SafeArea 로 감싸지 않거나,
          /// 2. SafeArea(top:false,bottom:false)
          /// 인 경우 바텀네이게이터 또는 스테이터스바 영역을 침범한다
          ///
          /// 침범하지 않게 하려면 SafeArea로 감싸야한다
          ///
          /// ios 홈인디게이터 존재시
          /// 1. SafeArea 로 감싸지 않거나,
          /// 2. SafeArea(top:false,bottom:false)
          /// 인 경우 바텀네이게이터 또는 스테이터스바 영역을 침범한다
          ///
          /// 반대로, SafeArea를 감싸는 경우 하단 홈 인디게이터 색상 이슈가 생길수 있다
          /// >> 홈 인디게이터 영역까지 전체를 다 사용하고 하단 마진을 가지는걸로 색상이슈 해결
          ///
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(onPressed: () {}, child: const Text('Bottom')),
          ),
        ],
      ),
    );
  }

  _content2() {
    return Scaffold(
      // appBar: AppBar(title: Text('Setting')),
      body: SafeArea(
        top: isTop,
        bottom: isBottom,
        child: Container(
          width: double.maxFinite,
          color: Colors.orange,
          child: Column(
            children: [
              BottomEdgeSpaceWidget(isBottom: false, isEdgeToEdge: !isTop),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(onPressed: () {}, child: const Text('Top')),
              ),

              Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop(); // 뒤로 가기
                  }
                },
                child: const Text('Back'),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isTop = !isTop;
                  });
                },
                child: Text('isTop : $isTop ${isTop == false ? '엣지' : '노엣지'}'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isBottom = !isBottom;
                  });
                },
                child: Text('isBottom : $isBottom ${isBottom == false ? '엣지' : '노엣지'}'),
              ),
              Spacer(),

              ///
              /// android 15 sdk 35부터
              /// 1. SafeArea 로 감싸지 않거나,
              /// 2. SafeArea(top:false,bottom:false)
              /// 인 경우 바텀네이게이터 또는 스테이터스바 영역을 침범한다
              ///
              /// 침범하지 않게 하려면 SafeArea로 감싸야한다
              ///
              /// ios 홈인디게이터 존재시
              /// 1. SafeArea 로 감싸지 않거나,
              /// 2. SafeArea(top:false,bottom:false)
              /// 인 경우 바텀네이게이터 또는 스테이터스바 영역을 침범한다
              ///
              /// 반대로, SafeArea를 감싸는 경우 하단 홈 인디게이터 색상 이슈가 생길수 있다
              /// >> 홈 인디게이터 영역까지 전체를 다 사용하고 하단 마진을 가지는걸로 색상이슈 해결
              ///
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(onPressed: () {}, child: const Text('Bottom')),
              ),

              BottomEdgeSpaceWidget(isEdgeToEdge: !isBottom),
            ],
          ),
        ),
      ),
    );
  }

  getRefresh() {
    return CommonEdgePage(
      // safeAreaTop: false,
      // safeAreaBottom: false,

      // child: CommonSafeAreaWidget(
      //     isTop: false,
      //     isBottom: false,
      //     child: refreshScroll()
      // ),
      child: refreshScroll(safeAreaTop: false, safeAreaBottom: false),

      // child:     ListView.builder(
      //   shrinkWrap: true,
      //   padding: EdgeInsets.zero,
      //   physics: const ClampingScrollPhysics(),
      //   itemCount: 50,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       leading: CircleAvatar(child: Text('${index + 1}')),
      //       title: Text('${index}'),
      //       subtitle: Text('This is item number ${index + 1}'),
      //     );
      //   },
      // ),
    );
  }

  ///
  /// refreshScroll
  ///
  refreshScroll({
    SliverPersistentHeaderDelegate? upDisappearHeader,
    SliverPersistentHeaderDelegate? fixedHeader,
    double? top,
    double? bottom,

    bool? safeAreaTop,
    bool? safeAreaBottom,
  }) {
    return RefreshMoreScrollview(
      safeAreaTop: safeAreaTop,
      safeAreaBottom: safeAreaBottom,
      itemCount: items.length,
      // isMoreDataScroll: _isLastPage(),
      netState: netState,
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
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text("${isDark == true ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}"),
              subtitle: Text('This is item number ${index + 1}'),
            ),
            // if (index + 1 == items.length) Container(height: bottom),
          ],
        );
      },
    );
  }
}
