import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';
import 'package:flutter_example_base/shared/entities/nav_item.dart';
import 'package:flutter_example_base/shared/widgets/blur_bottom_bar_item.dart';
import 'package:flutter_example_base/shared/widgets/common_default_edge_page.dart';

import 'package:go_router/go_router.dart';

import 'app/routes/app_routes_info.dart';
import 'app/routes/tab/tab_router.dart';
import 'core/utils/print_log.dart';

///
/// 메인 바텀네비게이터
/// ㄴ 하단 탭
/// ㄴ 컨텐츠 스크롤에 따라 숨김, 보이기 처리
///
class MainScaffoldWithNav extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffoldWithNav({super.key, required this.navigationShell});

  @override
  State<MainScaffoldWithNav> createState() => MainScaffoldWithNavState();
}

class MainScaffoldWithNavState extends State<MainScaffoldWithNav>
    with SingleTickerProviderStateMixin {
  /// 바텀 네비게이션 가리기 애니메이션
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  ///
  /// tab 내부  스크롤 컨트럴러
  /// 동일 탭 클릭시 - 컨텐츠 스크롤 최상단 이동을 위해서
  ///
  late Map<int, ScrollController> controllers = {};

  /// 네비게이터 아이템
  /// tab item
  ///
  List<NavItem> navItems = [];

  /// 마지막 탭 인덱스
  int _lastTappedIndex = 0;

  /// 바텀네비게이션 숨김 여부
  bool isBottomBarVisible = true;

  /// 탭 인덱스 변경
  bool onTabChanged(int newIndex) {
    if (_lastTappedIndex != newIndex) {
      debugPrint('🟢 탭 변경: $_lastTappedIndex -> $newIndex');
      _lastTappedIndex = newIndex;
      return true;
    } else {
      return false;
    }
  }

  ///
  /// 탭 클릭시
  /// ㄴ 동일 탭이면 스크롤 최상단 이동
  /// ㄴ 아닌 경우 탭 이동
  ///
  void _onTap(int index) {
    // QcLog.d(
    //   'state before ===== ${GoRouterState.of(context).topRoute.toString()} , ${GoRouterState.of(context).uri} , ${widget.navigationShell.currentIndex} ',
    // );

    if (onTabChanged(index) == false) {
      final mainNavScrollController = controllers[index];
      QcLog.d('중복 탭 시 스크롤 최상단 ===  ${mainNavScrollController?.hasClients}');

      _scrollToTop(mainNavScrollController);
    } else {
      widget.navigationShell.goBranch(index);
    }
  }

  void _scrollToTop(mainNavScrollController) {
    if (mainNavScrollController?.hasClients == true) {
      mainNavScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initTabInfo();
    _initTabNavAni();
  }

  ///
  /// 탭 정보 초기 설정
  ///
  _initTabInfo() {
    controllers = {};
    navItems = [];
    int index = 0;

    for (StatefulShellBranch value in TabRouter.tabBranches) {
      controllers[index] = ScrollController();
      index++;
      if (value.routes.isNotEmpty == true && value.routes.first is GoRoute) {
        GoRoute route = value.routes.first as GoRoute;
        QcLog.d('route.name ==== ${route.name} , ${route.path}');
        if (route.name == AppRoutesInfo.tabHome.name) {
          navItems.add(NavItem(iconData: Icons.home, label: AppRoutesInfo.tabHome.name));
        } else if (route.name == AppRoutesInfo.tabPosts.name) {
          navItems.add(NavItem(iconData: Icons.post_add, label: AppRoutesInfo.tabPosts.name));
        } else if (route.name == AppRoutesInfo.tabProfile.name) {
          navItems.add(NavItem(iconData: Icons.person, label: AppRoutesInfo.tabProfile.name));
        } else if (route.name == AppRoutesInfo.tabSearch.name) {
          navItems.add(NavItem(iconData: Icons.search, label: AppRoutesInfo.tabSearch.name));
        }
      }
    }
  }

  ///
  /// 탭 네비게이터 애니컨트럴러 설정
  ///
  _initTabNavAni() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // 아래에 감춰짐
      end: Offset.zero, // 제자리로 올라옴
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // 시작 시 보이게 하려면
    _controller.forward();
  }

  ///
  /// 바텀 네비게이터 숨김, 보이기 처리
  ///
  void showBottomBar(bool show) {
    if (show) {
      /// 바텀 네비게이션 불투명 처리
      if (isBottomBarVisible == false) {
        _controller.forward().then((v) {
          isBottomBarVisible = true;
        });
      }
    } else {
      if (isBottomBarVisible == true) {
        _controller.reverse().then((v) {
          isBottomBarVisible = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    // return getDefault();
    // return getBottomNavBlur();

    return getBottomNavBlurAni(isBlur: true);

    /// test pass
    // return getBottomNavBlurAni2();
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

  /// 2-1 .블러 처리된 네비게이션
  /// ㄴ 백키 종료 가능
  getBottomNavBlur() {
    // var bottom = MediaQuery.of(context).padding.bottom;
    return CommonDefaultEdgePage(
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: _buildBlurBottomBar(),
      ),
      child: widget.navigationShell,
    );
  }

  /// 2-2 .블러 처리된 네비게이션 애니메이션
  /// ㄴ 백키 종료 가능
  ///
  getBottomNavBlurAni({bool? isBlur = false}) {
    return CommonDefaultEdgePage(
      extendBodyBehindAppBar: true,
      extendBody: true,
      isBlur: isBlur,
      onShowBottomBar: (isVisible) {
        showBottomBar(isVisible);
      },
      bottomNavigationBar: _buildBlurBottomBarAni(),
      child: widget.navigationShell,
    );
  }

  ///
  /// ios 인 경우 safearea bottom을 풀고
  /// 홈 인디게이터가 있는 모델인 경우
  ///
  ///
  Widget _buildBlurBottomBarAni({BlurBottomType? blurType = BlurBottomType.Scale}) {
    return SafeArea(
      child: ClipRect(
        child: SlideTransition(
          position: _offsetAnimation,
          child: Container(
            height: kBottomNavigationBarHeight + 10,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(navItems.length, (index) {
                final selected = index == widget.navigationShell.currentIndex;
                final item = navItems[index];
                return Expanded(
                  child: BlurBottomBarItem(
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
      ),
    );
  }

  ///
  double lastOffset = 0;

  /// 2-3 .블러 처리된 네비게이션 애니메이션
  /// ㄴ 백키 종료 가능
  getBottomNavBlurAni2() {
    return CommonDefaultEdgePage(
      extendBodyBehindAppBar: true,
      extendBody: true,
      onScrollTop: () {
        // 스크롤 시작 → 일단 숨기자 (UX 선택 사항)
        // setState(() => isBottomBarVisible = true);
        showBottomBar(true);
      },
      onScrollUpdate: (offset) {
        print('onScrollUpdate ==== $offset | $lastOffset');
        final difference = offset - lastOffset;
        // setState(() => isBottomBarVisible = false);

        // if (difference > scrollThreshold && isBottomBarVisible) {
        //   showBottomBar(false);
        // } else if (difference < -scrollThreshold && !isBottomBarVisible) {
        //   showBottomBar(true);
        // }

        // offset 값 변화에 따라 위/아래 감지해서 show/hide
        if (offset > lastOffset) {
          showBottomBar(false);
        } else if (offset < lastOffset) {
          showBottomBar(true);
        }
        lastOffset = offset;
      },
      onScrollEnd: () {
        // 스크롤 멈췄을 때 상태 유지 또는 복구 로직 추가 가능
      },
      bottomNavigationBar: _buildBlurBottomBar(),
      child: widget.navigationShell,
    );
  }

  ///
  /// blur 처리된 바텀네이게이션
  ///
  Widget _buildBlurBottomBar({BlurBottomType? blurType = BlurBottomType.Scale}) {
    return SafeArea(
      // top: false,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 5, right: 5),
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
      ),
    );
  }

  /// stack으로 구성
  /// ㄴ 단, 뒤로가기시 종료가 안되는 이슈
  // getCustomNavStack() {
  //   return CommonDefaultEdgePage(
  //     // body: widget.shell,
  //     extendBodyBehindAppBar: true,
  //     extendBody: true,
  //
  //     // body: IndexedStack(
  //     //   index: widget.navigationShell.currentIndex,
  //     //   children: [
  //     //     HomeTab(mainNavScrollController: controllers[0]!),
  //     //     PostListScreen(mainNavScrollController: controllers[1]!),
  //     //     ProfileTab(mainNavScrollController: controllers[2]!),
  //     //     SearchTab(mainNavScrollController: controllers[3]!),
  //     //   ],
  //     // ),
  //     child: Stack(
  //       children: [
  //         Positioned.fill(
  //           child: Image.network('https://picsum.photos/1080/1920', fit: BoxFit.cover),
  //         ),
  //
  //         // Center(
  //         //   child: Text(
  //         //     'Content',
  //         //     style: TextStyle(fontSize: 24, color: Colors.white),
  //         //   ),
  //         // ),
  //         IndexedStack(
  //           index: widget.navigationShell.currentIndex,
  //           children: [
  //             HomeTab(mainNavScrollController: controllers[0]!),
  //             PostListScreen(mainNavScrollController: controllers[1]!),
  //             ProfileTab(mainNavScrollController: controllers[2]!),
  //             SearchTab(mainNavScrollController: controllers[3]!),
  //           ],
  //         ),
  //
  //         // ✅ blur 처리된 BottomNavigationBar
  //         Positioned(
  //           left: 0,
  //           right: 0,
  //           bottom: MediaQuery.of(context).padding.bottom,
  //           child: _buildBlurBottomBar(),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
