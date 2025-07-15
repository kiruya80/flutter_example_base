import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';
import 'package:flutter_example_base/core/utils/common_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme_provider.dart';
import '../../core/utils/print_log.dart';
import '../../shared/state/base_con_state.dart';
import '../../shared/widgets/common_default_edge_page.dart';
import '../../shared/widgets/common_edge_refresh_scrollview.dart';
import '../../shared/widgets/my_sliver_persistent_header_delegate.dart';
import '../../shared/widgets/refresh_more_scrollview.dart';
import '../tab_navigator/profile/profile_tab.dart';

///
/// 기본에서
/// Scaffold + SafeArea 없음 → “보여지기는 투명처럼 보임”
/// >>> 진짜 Edge-to-Edge가 아니다
/// Scaffold + SafeArea 있음 → 스테이터스영역 존재
///
///  [Edge-to-Edge 설정]
///  Flutter 3.13+이상 버전부터 스테이터스 아래부터 일부 위젯이 붙는다
///  이걸 없애려면  padding: EdgeInsets.zero,  padding: EdgeInsets.only(top: 0),
///   ✅ 적용됨 : ListView , CustomScrollView ,  SingleChildScrollView , GridView
///   ✅ 그이외 위젯들은 스테이터스까지 침범한다
///
///  1. 아이폰
///
///  main애서
///  WidgetsFlutterBinding.ensureInitialized();
///
///   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
///   SystemChrome.setSystemUIOverlayStyle(
///     SystemUiOverlayStyle(
///       statusBarColor: Colors.transparent,
///       systemNavigationBarColor: Colors.transparent,
///       // statusBarIconBrightness: Brightness.light,
///       // systemNavigationBarIconBrightness: Brightness.light,
///     ),
///   );
///
/// page에서
///
///  Scaffold(
///    extendBody: true,
///    extendBodyBehindAppBar: true,
///    body: SafeArea(
///      bottom: false,
///      top: false,
///
///widget.appbar
///
class EdgeToEdgePage extends ConsumerStatefulWidget {
  final String? id;
  final String? type;
  final bool? appbar;

  const EdgeToEdgePage({super.key, this.id, this.type, this.appbar});

  @override
  ConsumerState<EdgeToEdgePage> createState() => _EdgeToEdgePageState();
}

class _EdgeToEdgePageState extends BaseConState<EdgeToEdgePage> {
  // 100개의 샘플 텍스트 리스트 생성
  final items = List.generate(30, (index) => 'Item ${index + 1}');
  bool? isDark;
  NetState? netState = NetState.Paging;


  @override
  Widget build(BuildContext context) {
    QcLog.d('build ==== id : ${widget.id} , type : ${widget.type} , appbar : ${widget.appbar}');
    // CommonUtils.isTablet(context);
    // final statusBarHeight = MediaQuery.of(context).padding.top;
    // final bottomInset = MediaQuery.of(context).padding.bottom;
    // QcLog.d('statusBarHeight === $statusBarHeight , bottomInset === $bottomInset');

    // final primaryColor = Theme.of(context).primaryColor;
    // final primaryColor = Theme.of(context).colorScheme.primary;

    /// theme
    final appThemeMode = ref.watch(appThemeModeProvider);
    isDark = appThemeMode == ThemeMode.dark;
    QcLog.d("앱 테마 : ${isDark == true ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}");

    if (widget.type == EdgeToEdgeType.Default.name) {
      return getDefault();
    } else if (widget.type == EdgeToEdgeType.Common.name) {
      if (widget.appbar == true) {
        return getCommonAppBar();
      } else {
        return getCommon();
      }
      // return getCommon();

    } else if (widget.type == EdgeToEdgeType.Refresh.name) {
      return getRefresh();

    } else if (widget.type == EdgeToEdgeType.CommonRefresh.name) {
      return getCommonRefresh();

    } else if (widget.type == EdgeToEdgeType.CustomScrollView.name) {
      /// CommonEdgeRefreshScrollview
      if (widget.appbar == true) {
        netState = NetState.Paging;
        return getCustomScrollViewAppBar();
      } else {
        return getCustomScrollView();
      }
    // } else if (widget.type == EdgeToEdgeType.iosCupertino.name) {
    //   return getIosCupertino();
    } else {
      return Container();
    }
  }

  ///
  /// Scaffold {
  ///  SafeArea {
  ///
  getDefault() {
    // final statusBarHeight = MediaQuery.of(context).padding.top;
    // final bottomInset = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      // appBar: AppBar(title: const Text('EdgeToEdge'), backgroundColor: Colors.transparent),
      // appBar: AppBar(title: Text("EdgeToEdge")),
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView.builder(
          /// 상하단에 공간
          /// 상단은 스테이터스바 겹치지 않고
          /// 하단은 네비게이션에 가르지 않게
          // padding: EdgeInsets.only(top: statusBarHeight, bottom: bottomInset),
          itemCount: items.length,
          itemBuilder: (_, index) {
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(items[index]),
              subtitle: Text('This is item number ${index + 1}'),
            );
          },
        ),
      ),
      // Container(height: 100,color: Colors.blue,)
    );
  }

  getCommonAppBar() {
    return CommonDefaultEdgePage(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // appBar: Container(height: kToolbarHeight, color: Colors.deepPurple,),
      // appBar: Container(height: kToolbarHeight,),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text('긴 텍스트'),
        ),
      ),
      child: ListView.builder(
        // padding: EdgeInsets.zero,
        /// 상하단에 공간
        /// 상단은 스테이터스바 겹치지 않고
        /// 하단은 네비게이션에 가르지 않게
        itemCount: items.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(items[index]),
            subtitle: Text('This is item number ${index + 1}'),
          );
        },
      ),
    );
  }

  /// ok
  getCommon() {
    return CommonDefaultEdgePage(
      backgroundColor: Theme.of(context).colorScheme.surface,

      child: ListView.builder(
        // padding: EdgeInsets.zero,
        /// 상하단에 공간
        /// 상단은 스테이터스바 겹치지 않고
        /// 하단은 네비게이션에 가르지 않게
        itemCount: items.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(items[index]),
            subtitle: Text('This is item number ${index + 1}'),
          );
        },
      ),
    );
  }

  ///
  /// EdgeToEdge 안에 refresh widget
  ///
  getRefresh() {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return CommonDefaultEdgePage(
      // backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      child: refreshScroll(
        // top: statusBarHeight,
        // bottom: bottomInset,
        // upDisappearHeader: MySliverPersistentHeaderDelegate(
        //   maxHeight: statusBarHeight,
        //   minHeight: 0,
        //   child: Container(
        //     // height: 80,
        //     color: Colors.transparent,
        //   ),
        // ),
      ),
    );
  }

  getCustomScrollView() {
    // return CommonEdgeToEdgePage(
    //   // backgroundColor: Colors.white,
    //   // floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    //   isBlur: true,
    //   child: customScrollView(),
    // );
    return Scaffold(body: customScrollView());
  }


  Widget getCustomScrollViewAppBar() {
    return CommonEdgeRefreshScrollview(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appTitle: 'CustomScrollView appbar',
      itemCount: items.length,
      // isMoreDataScroll: _isLastPage(),
      isMoreDataScroll: MoreDataScroll.HAS,
      netState: NetState.Completed,
      // emptyMsg: claimSelectionViewModel?.selectedTab.emptyMsg,
      onRefresh: () async {
        // setState(() {
        //   netState = NetState.Loading;
        // });
        // await Future.delayed(const Duration(seconds: 2));
        // setState(() {
        //   netState = NetState.Completed;
        // });
        QcLog.d('items 11 ====== ${items.length}');
        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          items.insert(0, 'Refreshed at ${DateTime.now().toIso8601String()}');
        });
        QcLog.d('items 22 ====== ${items.length}');
      },
      onBottom: () async {
        QcLog.d('onBottom ====== ');
        // if (claimSelectionViewModel?.isLoad == false &&
        //     claimSelectionViewModel?.historyList.state == NetState.Completed &&
        //     claimSelectionViewModel?.historyList.isNextPage == true) {
        //   await claimSelectionViewModel?.requestHistoryList(isNext: true);
        // }
      },
      // upDisappearHeader: upDisappearHeader,
      // fixedHeader: fixedHeader,
      sliverChildBuilder: (context, index) {
        return Column(
          children: [
            // if (index == 0) Container(height: top),
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

  getCustomScrollViewAppBar1() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        top: false,
        bottom: false,
        child: CustomScrollView(
          slivers: [
            /// 스크롤시 앱바 영역을 지키거나 올리는 설정 가능
            // SliverAppBar(
            //   expandedHeight: 200,
            //   floating: true,
            //   // 스크롤 방향 반대로 올리면 다시 보여줄지 여부
            //   pinned: true,
            //   // 스크롤 시 상단에 고정될지 여부
            //   // backgroundColor: Colors.transparent,
            //   flexibleSpace: FlexibleSpaceBar(
            //     title: Text('접히는 앱바'),
            //     background: Stack(
            //       fit: StackFit.expand,
            //       children: [
            //         Image.network(
            //           'https://images.unsplash.com/photo-1503264116251-35a269479413?auto=format&fit=crop&w=800&q=80',
            //           fit: BoxFit.cover,
            //         ),
            //         Positioned.fill(
            //           child: BackdropFilter(
            //             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            //             child: Container(color: Colors.white.withOpacitySafe(0.4)),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            /// 높이 고정 앱바
            SliverAppBar(
              expandedHeight: kToolbarHeight,
              // expandedHeight: 200,
              floating: true,
              // 스크롤 방향 반대로 올리면 다시 보여줄지 여부
              pinned: true,
              // 스크롤 시 상단에 고정될지 여부
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('앱바'),
                background: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      height: kToolbarHeight,
                      color: Colors.white.withOpacitySafe(0.4),
                    ),
                  ),
                ),
              ),
            ),

            /// 스크롤시 올라가 사라진다
            // SliverToBoxAdapter(
            //   child: Container(height: 200, color: Colors.deepOrangeAccent),
            // ),

            /// 스크롤시 상단에서 최소높이까지 줄어듬
            // SliverPersistentHeader(
            //   pinned: true,
            //   delegate: MySliverPersistentHeaderDelegate(
            //     maxHeight: 200,
            //     minHeight: 100,
            //     child: Container(
            //       // height: 80,
            //       color: Colors.amber.withOpacitySafe(0.5),
            //     ),
            //   ),
            // ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text("${isDark == true ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}"),
                  subtitle: Text('This is item number ${index + 1}'),
                ),
                childCount: items.length,
              ),
            ),
          ],
          // ),
        ),
      ),
    );
  }

  getCommonRefresh() {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return CommonDefaultEdgePage(
      // backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      isBlur: true,
      child: refreshScroll(
        upDisappearHeader: MySliverPersistentHeaderDelegate(
          maxHeight: statusBarHeight,
          minHeight: 0,
          child: Container(
            // height: 80,
            color: Colors.transparent,
          ),
        ),
        fixedHeader: MySliverPersistentHeaderDelegate(
          maxHeight: 80,
          minHeight: 80,
          child: Container(
            child: const Text('Tile Scrolling Layout'),
            // color: Colors.blue,
          ),
        ),
      ),
    );
  }

  getIosCupertino() {
    /// 2. ios 스타일
    return CupertinoPageScaffold(
      /// 상단 앱바 kNavBarPersistentHeight = 44.0
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Navigation'),
        backgroundColor: Color(0xCCFFFFFF), // 반투명 흰색
        border: null, // 테두리 제거하면 더 깔끔
      ),

      /// 상단 앱바에서 백버튼 제거
      // navigationBar: const CupertinoNavigationBar(
      //   automaticallyImplyLeading: false,
      //   // ⛔ 자동 백버튼 생성 방지
      //   middle: null,
      //   // 타이틀 없음
      //   leading: null,
      //   // 백버튼 없음, 뒤로 이동시 화면이 있는 경우 자동 생성됨
      //   border: null,
      //   // 하단 경계선 없음
      //   backgroundColor: Color(0xCCFFFFFF), // 반투명 + 블러
      // ),
      resizeToAvoidBottomInset: false,
      child: ListView.builder(
        // padding: const EdgeInsets.only(top: 100),
        itemCount: 30,
        itemBuilder:
            (context, index) =>
                Padding(padding: const EdgeInsets.all(16), child: Text('Item $index')),
      ),
      // child: Center(
      //   child: CupertinoButton(
      //     child: const Text('뒤로가기'),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      // ),
    );
  }

  ///
  ///
  ///
  ///

  ///
  /// refreshScroll
  ///
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
              title: Text("${isDark == true ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}"),
              subtitle: Text('This is item number ${index + 1}'),
            ),
            // if (index + 1 == items.length) Container(height: bottom),
          ],
        );
      },
    );
  }

  ///
  /// CustomScrollView
  ///
  customScrollView() {
    return CustomScrollView(
      slivers: [
        /// 스크롤시 앱바 영역을 지키거나 올리는 설정 가능
        // SliverAppBar(
        //   expandedHeight: 200.0,
        //   floating: false,
        //   // 스크롤 방향 반대로 올리면 다시 보여줄지 여부
        //   pinned: true,
        //   // 스크롤 시 상단에 고정될지 여부
        //   // snap: true,     // floating이 true일 때만 사용 가능
        //   backgroundColor: Colors.blue,
        //   flexibleSpace: FlexibleSpaceBar(
        //     title: Text('접히는 앱바'),
        //     background: Image.asset(
        //       'assets/banner.jpg', // 배경 이미지
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        /// 스크롤시 올라가 사라진다
        // SliverToBoxAdapter(child: Container(height: 200,
        //     color: Colors.deepOrangeAccent.withOpacitySafe(0.5))),

        /// 스크롤시 상단에서 최소높이까지 줄어듬
        SliverPersistentHeader(
          pinned: true,
          delegate: MySliverPersistentHeaderDelegate(
            maxHeight: 200,
            minHeight: 100,
            child: Container(
              // height: 80,
              color: Colors.amber.withOpacitySafe(0.5),
            ),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text("${isDark == true ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}"),
              subtitle: Text('This is item number ${index + 1}'),
            ),
            childCount: items.length,
          ),
        ),
      ],
    );
  }
}
