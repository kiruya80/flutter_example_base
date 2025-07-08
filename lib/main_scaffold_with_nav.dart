import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';
import 'package:flutter_example_base/presentation/dialog/dialog_queue_listener.dart';
import 'package:flutter_example_base/presentation/tab_navigator/home/home_tab.dart';
import 'package:flutter_example_base/presentation/tab_navigator/post/post_list_screen.dart';
import 'package:flutter_example_base/presentation/tab_navigator/profile/profile_tab.dart';
import 'package:flutter_example_base/presentation/tab_navigator/search/search_tab.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app/routes/app_router.dart';
import 'app/routes/app_routes_info.dart';
import 'core/theme/app_theme_provider.dart';
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
  final Map<int, ScrollController> controllers = {
    AppRoutesInfo.tabHome.tabIndex ?? 0: ScrollController(),
    AppRoutesInfo.tabPosts.tabIndex ?? 1: ScrollController(),
    AppRoutesInfo.tabProfile.tabIndex ?? 2: ScrollController(),
    AppRoutesInfo.tabSearch.tabIndex ?? 3: ScrollController(),
  };
  // var navItems = [
  //   BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  //   BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
  //   BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  //   BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  // ];

  final List<NavItem> navItems = [
    NavItem(icon: Icons.home, label: 'Home'),
    NavItem(icon: Icons.search, label: 'Post'),
    NavItem(icon: Icons.person, label: 'Profile'),
    NavItem(icon: Icons.search, label: 'Search'),
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

  late final AnimationController _bottomBarAnimationController;

  @override
  void initState() {
    super.initState();

    // 하단 바 애니메이션 컨트롤러
    _bottomBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // 각 탭의 스크롤 방향 감지
    for (final entry in controllers.entries) {
      entry.value.addListener(() {
        final direction = entry.value.position.userScrollDirection;
        if (direction == ScrollDirection.reverse) {
          _bottomBarAnimationController.forward(); // 아래로 → 숨김
        } else if (direction == ScrollDirection.forward) {
          _bottomBarAnimationController.reverse(); // 위로 → 다시 나타남
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: widget.shell,
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network('https://picsum.photos/1080/1920', fit: BoxFit.cover),
          ),

          // Center(
          //   child: Text(
          //     'Content',
          //     style: TextStyle(fontSize: 24, color: Colors.white),
          //   ),
          // ),
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

      /// 이동없는 네비게이션
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.transparent, // 투명처리
      //   currentIndex: widget.navigationShell.currentIndex,
      //   type: BottomNavigationBarType.fixed, // 4개 이상일 경우 필요
      //   onTap: _onTap,
      //
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      //   ],
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
      //     items: const [
      //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //       BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
      //       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //       BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _buildBlurBottomBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: kBottomNavigationBarHeight+10,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            border: Border(top: BorderSide(color: Colors.white24, width: 0.5)),
            // color: Colors.white.withOpacity(0.1),
            // border: const Border(top: BorderSide(color: Colors.white30, width: 0.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navItems.length, (index) {
              final selected = index == widget.navigationShell.currentIndex;
              final item = navItems[index];

              // return GestureDetector(
              //   onTap: () => _onTap(index),
              //   behavior: HitTestBehavior.opaque,
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         item.label ?? '',
              //         style: TextStyle(
              //           color: selected ? Colors.white : Colors.white54,
              //           fontSize: 12,
              //         ),
              //       ),
              //     ],
              //   ),
              // );

              return Expanded(
                child: GestureDetector(
                  onTap: () => _onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: selected ? Colors.white.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          color: selected ? Colors.white : Colors.white60,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.label,
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final String label;

  NavItem({required this.icon, required this.label});
}
