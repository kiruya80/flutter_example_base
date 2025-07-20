import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';
import 'package:flutter_example_base/core/utils/common_utils.dart';
import 'package:flutter_example_base/shared/entities/nav_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/di/scroll_notifier.dart';
import '../../../app/routes/app_routes_info.dart';
import '../../../core/theme/app_theme_provider.dart';
import '../../../core/utils/device_info_utils.dart';
import '../../../core/utils/print_log.dart';
import '../../state/base_con_state.dart';
import '../common/blur_overlay.dart';
import '../common/edge_space_widget.dart';

///
///
/// ✅ 메인홈 (탭 네이게이터 구성)
/// navigationShell을 child로 가진다
///
///
/// 안드로이드
/// https://developer.android.com/design/ui/mobile/guides/layout-and-content/edge-to-edge?hl=ko
///
///  홈화면 및 메인 화면등에서 사용
///  ㄴ 스테이터스 & 바텀
///  ㄴ 컨텐츠, 컨텐츠 배경
///  ㄴ 앱바
///  구성을 가지고
///
///  # Google Gmail앱 기분 #
///  액션 : 리스트 최상단인 경우 스테이터스 반투명 바텀 : 불투명
///  스크롤 아래로 첫페이지정도 지나면, 바텀 탭이 아래로 사라지고,플로팅 버튼도 줄어듬
///  내리던 도중에 스크롤 위로 하자마자 상단에 검색 탭 메뉴등등이 내려오고 불투명
///  조금 더 스크롤 위로시 바텀 네비게이터 위로 올라오고 불투명
///
///  1. light
///  - 스테이터스,바텀버튼 아이콘 검은색 계열 ,
///  - 스테이터스,바텀버튼 배경 흰색 반투명계열
///
///  2. dark
///  - 스테이터스,바텀버튼 아이콘 흰색 계열
///  - 스테이터스,바텀버튼 배경 검은색 계열
///
///
///
/// 앱바 고정된 경우, 앱바를 접는다
/// 상단 앱 바가 고정되지 않은 경우 일치하는 배경 색상 그라데이션을 추가합니다.
///
/// 1. 블러 on 인 경우 & 앱바 없는 경우
/// ㄴ 상태바, 네비게이션바 색상 투명 & 위에 블러 이미지
///
/// 2. 블러 on 인 경우 & 앱바 있는 경우
/// ㄴ
class CommonDefaultEdgePage extends ConsumerStatefulWidget {
  ///
  /// Scaffold 설정
  ///
  final Widget? appBar;
  final Color? backgroundColor;

  /// Scaffold에서 bottomNavigationBar 아래로 확장
  final bool? extendBody;

  /// Scaffold에서 시스템 status bar까지 확장
  final bool? extendBodyBehindAppBar;

  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;

  ///
  /// body 내 컨텐츠 및 SafeArea 설정
  ///

  final Widget? background;

  /// safeArea의 상단 및 하단 사용여부
  /// true : 안전구역, 스테이터스바 또는 네비게이션 바 영역을 침범하지 않는다
  /// false : 전체 사용, 스테이터스 또는 네비게이션바 영역까지 사용한다
  ///
  final bool? safeAreaTop;
  final bool? safeAreaBottom;
  final Widget child;
  final bool? isBlur;

  ///
  /// 스크롤 위치
  ///
  // final VoidCallback? onScrollTop;
  // final ValueChanged<double>? onScrollUpdate;
  // final VoidCallback? onScrollEnd;
  /// 바텀 네비게이션 보이기
  final ValueChanged<bool>? onShowBottomBar;

  const CommonDefaultEdgePage({
    super.key,
    required this.child,
    this.background,
    this.appBar,
    this.backgroundColor = Colors.white,
    this.isBlur = true,
    this.extendBodyBehindAppBar = true,
    this.extendBody = true,
    this.safeAreaTop = false,
    this.safeAreaBottom = false,
    this.floatingActionButton,
    this.bottomSheet,
    this.bottomNavigationBar,
    // this.onScrollTop,
    // this.onScrollUpdate,
    // this.onScrollEnd,
    this.onShowBottomBar,
  });

  @override
  ConsumerState<CommonDefaultEdgePage> createState() => _CommonDefaultEdgePageState();
}

class _CommonDefaultEdgePageState extends BaseConState<CommonDefaultEdgePage> {
  bool? isDark = false;
  bool? isBlur = true;
  Color? overlayColor;

  bool isBottomBarVisible = true;
  bool isOnBottom = false;
  double lastOffset = 0;
  final double _threshold = 10.0; // 최소 스크롤 거리
  final double bottomMoreHeight = 100;

  @override
  void initState() {
    super.initState();
    QcLog.d(
      'initState ====== '
      '${widget.extendBody}, ${widget.extendBodyBehindAppBar} /'
      '${widget.safeAreaTop} , ${widget.safeAreaBottom}',
    );
    isBottomBarVisible = true;
    lastOffset = 0;
    isBlur = widget.isBlur;
  }

  ///
  /// 기본적으로 AppBar는 body 위에 위치하지만, body는 AppBar 아래부터 시작합니다.
  ///
  /// extendBodyBehindAppBar: true,를 하면
  /// body가 상단 status bar + AppBar 영역까지 확장
  /// AppBar가 투명하면, 마치 화면 맨 위부터 body가 그려지는 것처럼 보임
  ///
  /// kToolbarHeight : AppBar 높이 (보통 56dp)
  ///
  @override
  Widget build(BuildContext context) {
    // QcLog.d('build ==== $isBlur , $isDark');
    // CommonUtils.isTablet(context);
    overlayColor ??= Theme.of(context).colorScheme.surface;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    // QcLog.d('statusBarHeight === $statusBarHeight ,($kToolbarHeight) bottomInset === $bottomInset');

    // 실제 시스템 바 영역 (상태바, 내비게이션바)
    // final viewPadding = MediaQuery.of(context).viewPadding;
    // // 키보드 등으로 인해 “가려지는 영역”
    // final viewInsets = MediaQuery.of(context).viewInsets;
    // // viewPadding === EdgeInsets(0.0, 28.6, 0.0, 48.0) , viewInsets === EdgeInsets.zero
    // QcLog.d(' viewPadding === $viewPadding , viewInsets == $viewInsets');
    //
    var appThemeMode = ref.watch(appThemeModeProvider);
    // QcLog.d("앱 테마 : ${(appThemeMode == ThemeMode.dark) ? "☀🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}");
    if ((appThemeMode == ThemeMode.dark) != isDark) {
      /// 테마가 변경됨
    }
    isDark = appThemeMode == ThemeMode.dark;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification onNotification) {
        //스크롤 시 이 부분에서 이벤트가 발생한다.
        _onNotification(context, onNotification);
        return false; // 이벤트 계속 전달
      },

      child: Scaffold(
        // appBar: widget.appBar,
        backgroundColor: widget.backgroundColor,
        extendBody: widget.extendBody ?? true,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar ?? true,
        floatingActionButton: widget.floatingActionButton,
        bottomSheet: widget.bottomSheet,
        bottomNavigationBar: widget.bottomNavigationBar,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            /// 배경
            Container(child: widget.background),

            /// 컨텐츠
            SafeArea(
              top: widget.safeAreaTop ?? false,
              bottom: widget.safeAreaBottom ?? false,
              child: widget.child,
            ),

            Container(
              margin: EdgeInsets.only(top: widget.appBar != null ? statusBarHeight : 0),
              height: widget.appBar != null ? kToolbarHeight : 0,
              child: widget.appBar,
            ),

            /// appBar 유무에 따라 높이 달라짐
            // if (Platform.isIOS || widget.isBlur == true)
            // if (Platform.isIOS)
            Align(
              alignment: Alignment.topCenter,
              child: BlurOverlay(
                isBlur: isBlur,
                isDark: isDark,
                overlayColor: Theme.of(context).colorScheme.surface.withOpacitySafe(0.7),
              ),
            ),

            ///
            /// Navigation Bar\
            /// 안드로이드는 기본
            /// ios는 바텀네비게이터를 사용할때만
            ///
            if (Platform.isAndroid || widget.bottomNavigationBar != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: BlurOverlay(
                  height: bottomInset,
                  isBlur: isBlur,
                  isDark: isDark,
                  isBottom: true,
                  overlayColor: overlayColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  ///
  ///
  /// 항목
  ///                     statusBarColor              navigationBarColor
  /// 투명 설정 가능      가능 (Colors.transparent)   가능하지만 blur 발생
  /// blur 적용 여부      없음 (완전 투명 가능)       있음 (대부분 기기에서 반투명/블러됨)
  /// 영향을 받는 영역   상단 상태 표시줄             하단 소프트 버튼 영역
  ///
  /// systemNavigationBarIconBrightness
  /// ㄴ Brightness.dark 흰색
  /// ㄴ Brightness.light 검은색
  ///
  _onNotification(BuildContext context, ScrollNotification notification) {
    CommonUtils.getDisplayWidth(context);
    var displayHeight = CommonUtils.getDisplayHeight(context);
    final metrics = notification.metrics;

    if (notification is ScrollUpdateNotification) {
      //세로 스크롤인 경우에만 추적
      if (metrics.axisDirection != AxisDirection.down) return false;

      final isTop = metrics.pixels <= metrics.minScrollExtent + (displayHeight);
      final isBottom = metrics.pixels >= metrics.maxScrollExtent - 1;
      // notification.metrics.pixels >=
      //     notification.metrics.maxScrollExtent -
      //         (bottomMoreHeight + DeviceInfoUtils.instance.getEdgeSpaceHeight(context))
      String bottomTabId =
          GoRouterState.of(context).topRoute?.name ?? GoRouterState.of(context).uri.toString();

      if (isTop) {
        if (lastOffset != 0) {
          QcLog.d("📍 최상단입니다. $isBlur");

          if (widget.onShowBottomBar != null) {
            widget.onShowBottomBar!(true);
          }
          setState(() {
            if (widget.bottomNavigationBar != null) {
              /// 바텀 네비게이션이 있는 경우
              overlayColor ??= Theme.of(context).colorScheme.surface;
            } else {
              overlayColor ??= Theme.of(context).colorScheme.surface.withOpacitySafe(0.7);
            }
          });
          lastOffset = 0;
          isOnBottom = false;
        }
        return;
      }

      var isScrollBottom = ref.read(scrollReachedBottomProvider(bottomTabId));
      if (isBottom) {
        // QcLog.d("📍 최하단입니다.");
        //   if (isBottom && isOnBottom == false) {
        //     if (widget.onShowBottomBar != null) {
        //       widget.onShowBottomBar!(false);
        //     }
        //     isOnBottom = true;
        //
        //     setState(() {
        //       if (Platform.isIOS) {
        //         overlayColor = Colors.transparent;
        //       } else {
        //         overlayColor = Theme.of(context).colorScheme.surfaceDim.withOpacitySafe(0.5);
        //       }
        //     });
        //   }
        // 홈 탭에서만 무한 스크롤
        // if (notification.metrics.pixels >=
        //     notification.metrics.maxScrollExtent -
        //         (bottomMoreHeight + DeviceInfoUtils.instance.getEdgeSpaceHeight(context))) {

        if (isScrollBottom == false) {
          debugPrint("📍 최하단입니다. 📦 더 불러오기 트리거, $bottomTabId , ${GoRouterState.of(context).uri} ,");
          ref.read(scrollReachedBottomProvider(bottomTabId).notifier).state = true;
        }
        return;
      }

      ref.read(scrollReachedBottomProvider(bottomTabId).notifier).state = false;

      if (isTop == false && isBottom == false) {
        // QcLog.d("📍 최상단을 지남.");
        final currentOffset = notification.metrics.pixels;
        final delta = currentOffset - lastOffset;
        lastOffset = currentOffset;
        isOnBottom = false;

        // print('_onNotification ===== isTop : $isTop , isBottom : $isBottom');
        if (delta > _threshold) {
          // print('⬇️  아래로 스크롤 → 바텀바 숨김 (콘텐츠가 위로 이동) $overlayColor');
          if (widget.onShowBottomBar != null) {
            widget.onShowBottomBar!(false);
          }
          setState(() {
            if (Platform.isIOS) {
              overlayColor = Colors.transparent;
            } else {
              overlayColor = Theme.of(context).colorScheme.surface.withOpacitySafe(0.7);
            }
          });
        } else if (delta < -_threshold) {
          // print('⬆️ 위로 스크롤 → 바텀바 보여줌 (콘텐츠가 아래로 이동) $overlayColor');
          if (widget.onShowBottomBar != null) {
            widget.onShowBottomBar!(true);
          }
          setState(() {
            if (widget.bottomNavigationBar != null) {
              /// 바텀 네비게이션이 있는 경우
              overlayColor = Theme.of(context).colorScheme.surface;
            } else {
              overlayColor = Theme.of(context).colorScheme.surface.withOpacitySafe(0.7);
            }
          });
        } else {
          // print('⬇️ ⬆️ 그이외 $overlayColor');
          setState(() {
            if (widget.bottomNavigationBar == null) {
              overlayColor = Theme.of(context).colorScheme.surface.withOpacitySafe(0.7);
            }
          });
        }
      }
    }
  }
}
