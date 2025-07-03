import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';
import 'package:flutter_example_base/core/utils/common_utils.dart';
import 'package:flutter_example_base/shared/widgets/status_blur_overlay.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/print_log.dart';
import '../../shared/state/base_con_state.dart';

///
/// 안드로이드
/// https://developer.android.com/design/ui/mobile/guides/layout-and-content/edge-to-edge?hl=ko
///
/// 앱바 고정된 경우, 앱바를 접는다
/// 상단 앱 바가 고정되지 않은 경우 일치하는 배경 색상 그라데이션을 추가합니다.
///
class CommonEdgeToEdgePage extends ConsumerStatefulWidget {
  final Widget child;
  final Widget? background;
  final AppBar? appBar;
  final Color? backgroundColor;

  final bool? isStatusBlur;
  final Color? statusBarColor;

  /// Scaffold에서 시스템 status bar까지 확장
  final bool? extendBodyBehindAppBar;

  /// Scaffold에서 bottomNavigationBar 아래로 확장
  final bool? extendBody;

  /// safeArea의 상단 및 하단 사용여부
  /// true : 안전구역, 스테이터스바 또는 네비게이션 바 영역을 침범하지 않는다
  /// false : 전체 사용, 스테이터스 또는 네비게이션바 영역까지 사용한다
  ///
  final bool? safeAreaTop;
  final bool? safeAreaBottom;

  const CommonEdgeToEdgePage({
    super.key,
    required this.child,
    this.background,
    this.appBar,
    this.backgroundColor = Colors.white,

    /// isStatusBlur 블러 효과
    this.isStatusBlur = true,

    /// 블러효과가 false인 경우 색상처리
    /// 단, ios 색상불가로 블러만 처리
    this.statusBarColor = Colors.white,

    this.extendBody = true,
    this.extendBodyBehindAppBar = true,

    this.safeAreaTop = false,
    this.safeAreaBottom = false,
  });

  @override
  ConsumerState<CommonEdgeToEdgePage> createState() => _CommonEdgeToEdgePageState();
}

class _CommonEdgeToEdgePageState extends BaseConState<CommonEdgeToEdgePage> {
  bool? isScroll = false;

  @override
  void initState() {
    super.initState();
    QcLog.d(
      'initState ====== ${widget.extendBody}, ${widget.extendBodyBehindAppBar} /'
      '${widget.safeAreaTop} , ${widget.safeAreaBottom}',
    );
    isScroll = false;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _setSystemUiOverlayStyle();
    });
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
    CommonUtils.isTablet(context);
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    QcLog.d('statusBarHeight === $statusBarHeight , bottomInset === $bottomInset');

    // 실제 시스템 바 영역 (상태바, 내비게이션바)
    final viewPadding = MediaQuery.of(context).viewPadding;
    // 키보드 등으로 인해 “가려지는 영역”
    final viewInsets = MediaQuery.of(context).viewInsets;
    // viewPadding === EdgeInsets(0.0, 28.6, 0.0, 48.0) , viewInsets === EdgeInsets.zero
    QcLog.d(' viewPadding === $viewPadding , viewInsets == $viewInsets');

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        return _onNotification(notification);
      },
      child: Scaffold(
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar ?? true,
        extendBody: widget.extendBody ?? true,
        backgroundColor: widget.backgroundColor,
        appBar: widget.appBar,
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

            if (Platform.isIOS || widget.isStatusBlur == true) const StatusBlurOverlay(),

            if (Platform.isAndroid)
              // Blur Navigation Bar
              Align(
                alignment: Alignment.bottomCenter,
                child: StatusBlurOverlay(height: bottomInset),
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
  _onNotification(notification) {
    if (notification is ScrollUpdateNotification) {
      final metrics = notification.metrics;

      final isTop = metrics.pixels <= metrics.minScrollExtent + 1;
      final isBottom = metrics.pixels >= metrics.maxScrollExtent - 1;

      if (isTop) {
        QcLog.d("📍 최상단입니다.");
        isScroll = false;

        /// 리스트 상단
        _setSystemUiOverlayStyle();
      } else {
        /// 최상단은 지나감
        if (isBottom) {
          QcLog.d("📍 최하단입니다.");
          isScroll = false;

          /// 리스트 최하단
          _setSystemUiOverlayStyle(
            statusBarColor:
                widget.isStatusBlur == true
                    ? Colors.transparent
                    : widget.statusBarColor?.withOpacitySafe(1),
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
          );
        } else if (isScroll == false) {
          QcLog.d("📍 최상단을 지남.");
          isScroll = true;
          _setSystemUiOverlayStyle(
            /// iOS에서는 statusBarColor는 완전히 무시
            statusBarColor:
                widget.isStatusBlur == true
                    ? Colors.transparent
                    : widget.statusBarColor?.withOpacitySafe(0.4),
            systemNavigationBarColor: Colors.transparent,
            // systemNavigationBarColor:  Colors.white.withOpacity(0.5),
            systemNavigationBarDividerColor: Colors.transparent,
          );
        }
      }
    }
    return false; // 이벤트 계속 전달
  }
}

void _setSystemUiOverlayStyle({
  Color? statusBarColor,
  Color? systemNavigationBarColor,
  Color? systemNavigationBarDividerColor,
}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor ?? Colors.transparent,
      // statusBarBrightness: Brightness.dark,
      // 아이폰 상단 글씨(시계, 배터리) 색상
      // statusBarIconBrightness: Brightness.dark,

      // 안드로이드용 상태바 아이콘 색상
      systemNavigationBarColor: systemNavigationBarColor ?? Colors.transparent,
      systemNavigationBarDividerColor: systemNavigationBarDividerColor ?? Colors.transparent,
      // 네비게이션 바 구분선 색상 설정
      // systemNavigationBarIconBrightness: Brightness.light, // 아이콘 색상 (흰색)
    ),
  );
}
