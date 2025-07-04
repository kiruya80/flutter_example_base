import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/common_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme_provider.dart';
import '../../core/utils/print_log.dart';
import '../../shared/state/base_con_state.dart';
import '../../shared/widgets/common_edge_to_edge_page.dart';
import '../../shared/widgets/my_sliver_persistent_header_delegate.dart';
import '../../shared/widgets/refresh_more_scrollview.dart';

class EdgeToEdgePage extends ConsumerStatefulWidget {
  final String? id;
  final String? type;

  const EdgeToEdgePage({super.key,
    this.id,
    // @QueryParam('contractNo') this.contractNo,
    this.type});

  @override
  ConsumerState<EdgeToEdgePage> createState() => _EdgeToEdgePageState();
}

class _EdgeToEdgePageState extends BaseConState<EdgeToEdgePage> {
  // 100개의 샘플 텍스트 리스트 생성
  final items = List.generate(100, (index) => 'Item ${index + 1}');
  bool? isDark;

  @override
  void initState() {
    super.initState();
    QcLog.d('initState ==== id : ${widget.id} , type : ${widget.type}');
  }

  @override
  Widget build(BuildContext context) {
    CommonUtils.isTablet(context);
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    QcLog.d('statusBarHeight === $statusBarHeight , bottomInset === $bottomInset');

    // return getEdgeToEdge1();
    // return getEdgeToEdge2();
    // return material();
    // return CommonEdgeToEdgePage(child: getEdgeToEdge());
    // final primaryColor = Theme.of(context).primaryColor;
    final primaryColor = Theme.of(context).colorScheme.primary;

    /// theme
    final appThemeMode = ref.watch(appThemeModeProvider);
    isDark = appThemeMode == ThemeMode.dark;
    QcLog.d("앱 테마 : ${isDark == true ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}");

    // return getMaterial();
    // return getIosStyle();

    // return Scaffold(body: sliverScroll());

    // return getMaterialCustomScroll();
    // return Scaffold(body: refreshScroll());
    return getMaterialRefresh();
  }

  sliverScroll() {
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
        SliverToBoxAdapter(child: Container(height: 200, color: Colors.deepOrangeAccent)),

        /// 스크롤시 상단에서 최소높이까지 줄어듬
        SliverPersistentHeader(
          pinned: true,
          delegate: MySliverPersistentHeaderDelegate(
            maxHeight: 200,
            minHeight: 100,
            child: Container(
              // height: 80,
              color: Colors.amber,
            ),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(title: Text('Item $index')),
            childCount: 30,
          ),
        ),
      ],
    );
  }

  refreshScroll() {
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
      sliverChildBuilder: (context, index) {
        return Container(
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text("${isDark == true ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}"),
            subtitle: Text('This is item number ${index + 1}'),
          ),
        );
      },
    );
  }

  ///
  /// EdgeToEdge 안에 refresh widget
  ///
  getMaterialRefresh() {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    QcLog.d('statusBarHeight === $statusBarHeight , bottomInset === $bottomInset');

    return CommonEdgeToEdgePage(
      // backgroundColor: Colors.white,
      backgroundColor: Colors.amber,
      floatingActionButton: FloatingActionButton(
        heroTag: 'theme',
        onPressed: () {
          ref.read(appThemeModeProvider.notifier).state =
              (isDark ?? false) ? ThemeMode.light : ThemeMode.dark;
        },
        child: const Icon(Icons.add),
      ),
      isBlur: true,
      child: refreshScroll(),
    );
  }

  getMaterialCustomScroll() {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    QcLog.d('statusBarHeight === $statusBarHeight , bottomInset === $bottomInset');

    return CommonEdgeToEdgePage(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        heroTag: 'theme',
        onPressed: () {
          ref.read(appThemeModeProvider.notifier).state =
              (isDark ?? false) ? ThemeMode.light : ThemeMode.dark;
        },
        child: const Icon(Icons.add),
      ),
      isBlur: true,
      child: sliverScroll(),
    );
  }

  getMaterial() {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    QcLog.d('statusBarHeight === $statusBarHeight , bottomInset === $bottomInset');

    return CommonEdgeToEdgePage(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        heroTag: 'theme',
        onPressed: () {
          ref.read(appThemeModeProvider.notifier).state =
              (isDark ?? false) ? ThemeMode.light : ThemeMode.dark;
        },
        child: const Icon(Icons.add),
      ),
      // statusBarColor: primaryColor,
      isBlur: true,
      // appBar: AppBar(title: const Text('EdgeToEdge'),
      //     backgroundColor: Colors.transparent
      // ),
      child: ListView.builder(
        /// 상하단에 공간
        /// 상단은 스테이터스바 겹치지 않고
        /// 하단은 네비게이션에 가르지 않게
        padding: EdgeInsets.only(top: statusBarHeight, bottom: bottomInset),
        itemCount: items.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text("${isDark == true ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}"),
            subtitle: Text('This is item number ${index + 1}'),
          );
        },
      ),
    );
  }

  getIosStyle() {
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

  getEdgeToEdge() {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.lightGreenAccent.withValues(
      //   alpha:0.5,
      // ),
      // backgroundColor: Colors.lightGreenAccent.withOpacity(0.1),
      // appBar: AppBar(title: const Text('EdgeToEdge'), backgroundColor: Colors.transparent),
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView.builder(
          /// 상하단에 공간
          /// 상단은 스테이터스바 겹치지 않고
          /// 하단은 네비게이션에 가르지 않게
          padding: EdgeInsets.only(top: statusBarHeight, bottom: bottomInset),
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
    );
  }

  getEdgeToEdge1() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text('Title'),
        backgroundColor: Colors.transparent, // 중요
        // backgroundColor: Colors.cyanAccent,
        elevation: 0,
      ),
      body: SafeArea(
        top: false, // 직접 처리할 것이므로 false
        bottom: false,
        maintainBottomViewPadding: true,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.orange],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(items[index]),
                subtitle: Text('This is item number ${index + 1}'),
              );
            },
          ),
        ),
      ),
    );
  }
}

// return Scaffold(
//   extendBodyBehindAppBar: true,
//   body: Stack(
//     children: [
//       // 전체 배경 (예: 이미지나 컬러)
//       Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blue.shade300, Colors.purple.shade300],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//       ),
//       // 배경 이미지 또는 배경색
//       Image.network(
//         'https://picsum.photos/600/800',
//         fit: BoxFit.cover,
//         height: double.infinity,
//         width: double.infinity,
//       ),
//
//       // ✅ 상태바 영역에만 blur + 반투명 배경
//       ClipRect(
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//           child: Container(
//             height: statusBarHeight,
//             color: Colors.white.withOpacity(0.2), // 반투명 오버레이
//           ),
//         ),
//       ),
//
//       // 본문
//       Positioned.fill(
//         child: Column(
//           children: [
//             SizedBox(height: statusBarHeight + kToolbarHeight), // 상태바 + 앱바 높이만큼 띄우기
//             Expanded(
//               child: Center(
//                 child: Text(
//                   '상단 상태바 영역에 블러 적용됨',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   ),
// );
