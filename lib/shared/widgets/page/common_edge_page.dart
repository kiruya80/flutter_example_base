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
/// ✅ 디폴트 엣지 페이지
///
class CommonEdgePage extends ConsumerStatefulWidget {
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

  const CommonEdgePage({
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
  });

  @override
  ConsumerState<CommonEdgePage> createState() => _CommonEdgePageState();
}

class _CommonEdgePageState extends BaseConState<CommonEdgePage> {
  bool? isDark = false;
  bool? isBlur = true;

  @override
  void initState() {
    super.initState();
    QcLog.d(
      'initState ====== '
      '${widget.extendBody}, ${widget.extendBodyBehindAppBar} /'
      '${widget.safeAreaTop} , ${widget.safeAreaBottom}',
    );
    isBlur = widget.isBlur;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    QcLog.d('didChangeDependencies ===== ');
    String bottomTabId =
        GoRouterState.of(context).topRoute?.name ?? GoRouterState.of(context).uri.toString();
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
    // overlayColor ??= Theme.of(context).colorScheme.surface;
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

            /// todo 앱바 영역 확인 필요 높이
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

      final isBottom = metrics.pixels >= metrics.maxScrollExtent - 1;
      QcLog.d(
        '_onNotification ==== ${metrics.pixels} , $displayHeight , ${metrics.maxScrollExtent}',
      );
      // notification.metrics.pixels >=
      //     notification.metrics.maxScrollExtent -
      //         (bottomMoreHeight + DeviceInfoUtils.instance.getEdgeSpaceHeight(context))

      var isScrollBottom = ref.read(scrollReachedBottomProvider(currentRouteName));
      if (isBottom) {
        if (isScrollBottom == false) {
          debugPrint(
            "📍 최하단입니다. 📦 더 불러오기 트리거, $currentRouteName , ${GoRouterState.of(context).uri} ,",
          );
          ref.read(scrollReachedBottomProvider(currentRouteName).notifier).state = true;
        }
        return;
      }

      if (isScrollBottom == true) {
        ref.read(scrollReachedBottomProvider(currentRouteName).notifier).state = false;
      }
    }
  }
}
