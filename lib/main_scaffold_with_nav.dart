import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';
import 'package:flutter_example_base/presentation/tab_navigator/home/home_tab.dart';
import 'package:flutter_example_base/presentation/tab_navigator/post/post_list_screen.dart';
import 'package:flutter_example_base/presentation/tab_navigator/profile/profile_tab.dart';
import 'package:flutter_example_base/presentation/tab_navigator/search/search_tab.dart';
import 'package:flutter_example_base/shared/entities/nav_item.dart';
import 'package:flutter_example_base/shared/widgets/blur_bottom_bar_item.dart';
import 'package:flutter_example_base/shared/widgets/common_edge_to_edge_page.dart';

import 'package:go_router/go_router.dart';

import 'app/routes/app_routes_info.dart';
import 'core/utils/print_log.dart';

/// 바텀네비게이터
class MainScaffoldWithNav extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffoldWithNav({super.key, required this.navigationShell});

  @override
  State<MainScaffoldWithNav> createState() => MainScaffoldWithNavState();
}

class MainScaffoldWithNavState extends State<MainScaffoldWithNav>
    with SingleTickerProviderStateMixin {
  /// 바텀 네비게이션 가리기 애니메이션
  // late final AnimationController _bottomBarAnimationController;

  final Map<int, ScrollController> controllers = {
    AppRoutesInfo.tabHome.tabIndex ?? 0: ScrollController(),
    AppRoutesInfo.tabPosts.tabIndex ?? 1: ScrollController(),
    AppRoutesInfo.tabProfile.tabIndex ?? 2: ScrollController(),
    AppRoutesInfo.tabSearch.tabIndex ?? 3: ScrollController(),
  };

  // var bottomNavItems = [
  //   BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  //   BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
  //   BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  //   BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  // ];

  final List<NavItem> navItems = [
    NavItem(iconData: Icons.home, label: 'Home'),
    NavItem(iconData: Icons.post_add, label: 'Post'),
    NavItem(iconData: Icons.person, label: 'Profile'),
    NavItem(iconData: Icons.search, label: 'Search'),
  ];

  int _lastTappedIndex = 0;

  bool onTabChanged(int newIndex) {
    if (_lastTappedIndex != newIndex) {
      debugPrint('🟢 탭 변경: $_lastTappedIndex -> $newIndex');
      _lastTappedIndex = newIndex;
      return true;
    } else {
      return false;
    }
  }

  void _onTap(int index) {
    QcLog.d(
      'state before ===== ${GoRouterState.of(context).topRoute.toString()} , ${GoRouterState.of(context).uri} , ${widget.navigationShell.currentIndex} ',
    );

    // if (onTabChanged(index)) {
    //   /// todo 만약 홈탭으로 돌아오고 리빌드 하고 싶을때는 프로바이더나 이벤트 버스등 명시적 호출 필요
    //   /// if (index == 0) {
    //   ///   eventBus.fire(HomeTabSelectedEvent());
    //   ///   homeTabNotifier.refresh();
    //   /// }
    //   ///
    //   /// 동일한 탭 다시 클릭하는 경우 홈으로 이동하게
    //   widget.navigationShell.goBranch(index, initialLocation: true);
    // } else {
    //   widget.navigationShell.goBranch(index);
    // }

    // if (index == _lastTappedIndex) {
    if (onTabChanged(index) == false) {
      final mainNavScrollController = controllers[index];
      QcLog.d('중복 탭 시 스크롤 최상단 ===  ${mainNavScrollController?.hasClients}');

      if (mainNavScrollController?.hasClients == true) {
        mainNavScrollController?.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } else {
      widget.navigationShell.goBranch(index);
    }
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    /// 바텀 네비게이션 가리기 애니메이션
    // 하단 바 애니메이션 컨트롤러
    // _bottomBarAnimationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 200),
    // );
    //
    // // 각 탭의 스크롤 방향 감지
    // for (final entry in controllers.entries) {
    //   entry.value.addListener(() {
    //     final direction = entry.value.position.userScrollDirection;
    //     if (direction == ScrollDirection.reverse) {
    //       _bottomBarAnimationController.forward(); // 아래로 → 숨김
    //     } else if (direction == ScrollDirection.forward) {
    //       _bottomBarAnimationController.reverse(); // 위로 → 다시 나타남
    //     }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // return getDefault();
    return getBottomNavBlur();
    // return getCustomNavStack();
  }

  /// 1. 기본 네비게이션바
  /// ㄴ 백키 종료 가능
  getDefault() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: widget.navigationShell,

      /// 이동없는 네비게이션
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.transparent, // 투명처리
      //   currentIndex: widget.navigationShell.currentIndex,
      //   type: BottomNavigationBarType.fixed, // 4개 이상일 경우 필요
      //   onTap: _onTap,
      //   items: bottomNavItems,
      // ),
      /// 스크롤에 따라 이동
      // bottomNavigationBar: SizeTransition(
      //   sizeFactor: CurvedAnimation(
      //     parent: _bottomBarAnimationController,
      //     curve: Curves.easeInOut,
      //   ).drive(Tween(begin: 1.0, end: 0.0)),
      //   axisAlignment: -1.0,
      //   child: BottomNavigationBar(
      //     currentIndex: widget.navigationShell.currentIndex,
      //     onTap: _onTap,
      //     items: bottomNavItems,
      //   ),
      // ),
      /// 블러처리
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            // 투명처리
            currentIndex: widget.navigationShell.currentIndex,
            type: BottomNavigationBarType.fixed,
            // 4개 이상일 경우 필요
            onTap: _onTap,
            // items: bottomNavItems,
            items: List.generate(navItems.length, (index) {
              final item = navItems[index];
              return item.toBottomNavigationBarItem(
                selected: index == widget.navigationShell.currentIndex,
                selectedColor: Colors.white,
                unselectedColor: Colors.grey,
              );
            }),
          ),
        ),
      ),
    );
  }

  /// 2 .블러 처리된 네비게이션
  /// ㄴ 백키 종료 가능
  getBottomNavBlur() {
    var bottom = MediaQuery.of(context).padding.bottom;
    return CommonEdgeToEdgePage(
      extendBodyBehindAppBar: true,
      extendBody: true,
      // bottomNavigationBar: ClipRect(
      //   child: BackdropFilter(
      //     filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      //     child: BottomNavigationBar(
      //       backgroundColor: Colors.transparent,
      //       // 투명처리
      //       currentIndex: widget.navigationShell.currentIndex,
      //       type: BottomNavigationBarType.fixed,
      //       // 4개 이상일 경우 필요
      //       onTap: _onTap,
      //       // items: bottomNavItems,
      //       items: List.generate(navItems.length, (index) {
      //         final item = navItems[index];
      //         return item.toBottomNavigationBarItem(
      //           selected: index == widget.navigationShell.currentIndex,
      //           selectedColor: Colors.white,
      //           unselectedColor: Colors.grey,
      //         );
      //       }),
      //     ),
      //   ),
      // ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: _buildBlurBottomBar(),
      ),
      child: widget.navigationShell,
    );
  }

  /// stack으로 구성
  /// ㄴ 단, 뒤로가기시 종료가 안되는 이슈
  getCustomNavStack() {
    return CommonEdgeToEdgePage(
      // body: widget.shell,
      extendBodyBehindAppBar: true,
      extendBody: true,

      // body: IndexedStack(
      //   index: widget.navigationShell.currentIndex,
      //   children: [
      //     HomeTab(mainNavScrollController: controllers[0]!),
      //     PostListScreen(mainNavScrollController: controllers[1]!),
      //     ProfileTab(mainNavScrollController: controllers[2]!),
      //     SearchTab(mainNavScrollController: controllers[3]!),
      //   ],
      // ),
      child: Stack(
        children: [
          /// 배경 필요시
          // Positioned.fill(
          //   child: Image.network('https://picsum.photos/1080/1920', fit: BoxFit.cover),
          // ),
          /// 탭 컨텐츠
          IndexedStack(
            index: widget.navigationShell.currentIndex,
            children: [
              HomeTab(mainNavScrollController: controllers[0]!),
              PostListScreen(mainNavScrollController: controllers[1]!),
              ProfileTab(mainNavScrollController: controllers[2]!),
              SearchTab(mainNavScrollController: controllers[3]!),
            ],
          ),

          // ✅ blur 처리된 BottomNavigationBar
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom,
            child: _buildBlurBottomBar(),
          ),
        ],
      ),
    );
  }

  /// blur 처리된 바텀네이게이션
  ///
  Widget _buildBlurBottomBar({BlurBottomType? blurType = BlurBottomType.Scale}) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: EdgeInsets.only(left: 5,right: 5 ),
          height: kBottomNavigationBarHeight + 10,
          decoration: BoxDecoration(
            // color: Colors.white.withOpacitySafe(0.15),
            color: Theme.of(context).colorScheme.surfaceBright.withOpacitySafe(0.3),
            // color: Theme.of(context).colorScheme.secondary.withOpacitySafe(0.2),
            /// 바텀 네비 위 줄
            // border: Border(top: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 0.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navItems.length, (index) {
              final selected = index == widget.navigationShell.currentIndex;
              final item = navItems[index];
              return Expanded(
                child: BlurBottomBarItem(
                  blurType: blurType,
                  selected: selected,
                  iconData: item.iconData,
                  label: item.label ?? '',
                  onTap: () => _onTap(index),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
