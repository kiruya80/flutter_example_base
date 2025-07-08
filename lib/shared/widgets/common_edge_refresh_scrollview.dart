import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/common_utils.dart';
import '../state/base_con_state.dart';

///
/// Edge to edge + RefreshScrollview
///
class CommonEdgeRefreshScrollview extends ConsumerStatefulWidget {
  /// 리프래시 사용하는 위젯여부
  final bool? isRefresh;
  final int? itemCount;

  /// 추가 데이터 존재유무
  final MoreDataScroll? isMoreDataScroll;

  final NetState? netState;
  final String? emptyMsg;
  final String? errorMsg;

  /// onRefresh 시 호출 함수
  final Future<void> Function()? onRefresh;

  /// 스크롤 , 바닥 리스너
  final Future<void> Function()? onBottom;

  /// 새로고침 인디케이터 색상
  final Color refreshIndicatorColor;

  /// 올라가는 헤더
  final SliverPersistentHeaderDelegate? upDisappearHeader;

  /// 앱에서 항상 표시되는 헤더
  final SliverPersistentHeaderDelegate? fixedHeader;

  /// 리스트뷰
  final IndexedWidgetBuilder? sliverChildBuilder;
  final Widget? noListContent;

  ///
  ///
  final String? appTitle;
  final Color? backgroundColor;

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

  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;

  const CommonEdgeRefreshScrollview({
    super.key,
    this.isRefresh = true,
    this.itemCount = 0,
    this.isMoreDataScroll = MoreDataScroll.NONE,
    this.netState,
    this.emptyMsg = "데이터가 없습니다.",
    this.errorMsg = "오류가 발생했습니다.",
    this.onRefresh,
    this.onBottom,
    this.refreshIndicatorColor = Colors.blue,
    this.upDisappearHeader,
    this.fixedHeader,
    this.sliverChildBuilder,
    this.noListContent,

    ///
    /// EdgeRe
    ///
    this.appTitle,
    this.backgroundColor = Colors.white,
    this.extendBodyBehindAppBar = true,
    this.extendBody = true,
    this.safeAreaTop = false,
    this.safeAreaBottom = false,
    this.floatingActionButton,
    this.bottomSheet,
    this.bottomNavigationBar,
  });

  @override
  ConsumerState<CommonEdgeRefreshScrollview> createState() => _CommonEdgeRefreshScrollviewState();
}

class _CommonEdgeRefreshScrollviewState extends BaseConState<CommonEdgeRefreshScrollview> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    QcLog.d(
      'initState ====== ${widget.extendBody}, ${widget.extendBodyBehindAppBar} /'
      '${widget.safeAreaTop} , ${widget.safeAreaBottom} ',
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _setSystemUiOverlayStyle();
    });
  }

  void _setSystemUiOverlayStyle() {
    ///
    /// statusBarIconBrightness
    /// ㄴ ThemeMode.dark - 아이콘 검은색 - 블러 처리시
    /// ㄴ Brightness.light - 아이콘 흰색
    ///
    ///
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // ✅ iOS 상태바 아이콘 밝기 light(black ison), dark(white icon)
        statusBarBrightness: Brightness.light,
        // ✅ Android 상태바 아이콘 밝기 → light(white ison), dark(black icon)
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        // 안드로이드용 네비게이션 아이콘 색상 null이면 불투명
        systemNavigationBarDividerColor: Colors.transparent,
        // ✅ Android 네비게이션 아이콘 밝기 → light(white ison, 검은색 반투명 배경), dark(black icon, 흰색 반투명 배경)
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// NotificationListener
  ///
  bool _onNotification(ScrollNotification scrollNotification) {
    if (widget.isMoreDataScroll != MoreDataScroll.HAS) {
      return false;
    }
    var metrics = scrollNotification.metrics;
    //세로 스크롤인 경우에만 추적
    if (metrics.axisDirection != AxisDirection.down) return false;
    if (metrics.extentAfter <= 0) {
      //스크롤 끝에 닿은 경우 실행
      // if (widget.isRefresh == true && widget.onBottom != null) {
      if (widget.onBottom != null) {
        widget.onBottom!();
      }
    }
    return false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /**
      AlwaysScrollableScrollPhysics(
      //physics 물리 - 원하는 UI에 맞춰 작업하면 됨
      // NeverScrollableScrollPhysics : 목록 스크롤 불가능하게 설정
      // BouncingScrollPhysics : 튕겨저 올라가는 듯한 동작 가능 List 끝에 도달했을 시에 다시 되돌아감
      // ClampingScrollPhysics : 안드로이드의 기본 스크롤과 동일하다. List의 끝에 도달하면 동작을 멈춤
      // PageScrollPhysics : 다른 스크롤에 비해 조금더 부드럽게 만듬
   */
  @override
  Widget build(BuildContext context) {
    /// 1. pagingScrollController
    // return CustomScrollView(
    //   controller: pagingScrollController,
    //   physics: widget.isRefresh == true
    //       ? const AlwaysScrollableScrollPhysics(
    //     parent: BouncingScrollPhysics(), //ios 기본
    //   )
    //       : null,
    //   slivers: getSliversContents(context),
    // );
    CommonUtils.isTablet(context);
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    QcLog.d(
      'statusBarHeight === $statusBarHeight ,($kToolbarHeight) bottomInset === $bottomInset ',
    );

    /// 2. NotificationListener
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification onNotification) {
        //스크롤 시 이 부분에서 이벤트가 발생한다.
        _onNotification(onNotification);
        return false;
      },

      child: Scaffold(
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar ?? true,
        extendBody: widget.extendBody ?? true,
        backgroundColor: widget.backgroundColor,
        floatingActionButton: widget.floatingActionButton,
        bottomSheet: widget.bottomSheet,
        bottomNavigationBar: widget.bottomNavigationBar,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: widget.safeAreaTop ?? false,
          bottom: widget.safeAreaBottom ?? false,
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                physics:
                    widget.isRefresh == true
                        ? const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(), //ios 기본
                        )
                        : null,
                slivers: getSliversContents(context),
              ),

              // if (Platform.isIOS || widget.isBlur == true) BlurOverlay(isStatusDark: false),
              // if (Platform.isAndroid && widget.isBlur == true)
              //   Align(alignment: Alignment.bottomCenter, child: BlurOverlay(height: bottomInset, isStatusDark: false,)),

              // GestureDetector(
              //     behavior: HitTestBehavior.translucent,
              //     onTap: () {
              //       QcLog.d('onTap === ');
              //       _scrollController.animateTo(
              //         0.0,
              //         duration: const Duration(milliseconds: 300),
              //         curve: Curves.easeOut,
              //       );
              //     },
              //     child: Container(height: statusBarHeight + 15,
              //
              //       color: Colors.deepPurple,
              //     )),
              if (Platform.isAndroid && widget.sliverChildBuilder != null)
                Positioned(
                  top: 0,
                  left: 60,
                  right: 60,
                  height: statusBarHeight + 15,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      QcLog.d('onTap === ');
                      _scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    child: Container(height: statusBarHeight + 15, color: Colors.transparent),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getSliversContents(BuildContext context) {
    List<Widget> scrollSlivers = [];

    /// 위로 올라가는 위젯 영역이지만 포험되는 경우 리프래쉬 문제
    // if (widget.boxAdapter != null) {
    //   scrollSlivers.add(SliverToBoxAdapter(
    //     child: widget.boxAdapter,
    //   ));
    // }
    // if (widget.sliverAppBar != null) {
    //   scrollSlivers.add(widget.sliverAppBar!);
    // }

    /// 높이 고정 앱바 - transparent
    scrollSlivers.add(
      SliverAppBar(
        expandedHeight: kToolbarHeight,
        // 스크롤 방향 반대로 올리면 다시 보여줄지 여부
        floating: true,
        // 스크롤 시 상단에 고정될지 여부
        pinned: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          // ✅ iOS 상태바 아이콘 밝기 light(black ison), dark(white icon)
          statusBarBrightness: Brightness.light,
          // ✅ Android 상태바 아이콘 밝기 → light(white ison), dark(black icon)
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          // 안드로이드용 네비게이션 아이콘 색상 null이면 불투명
          systemNavigationBarDividerColor: Colors.transparent,
          // ✅ Android 네비게이션 아이콘 밝기 → light(white ison, 검은색 반투명 배경), dark(black icon, 흰색 반투명 배경)
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        // 검정 아이콘
        flexibleSpace: FlexibleSpaceBar(
          title: Text(widget.appTitle ?? ''),
          background: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(height: kToolbarHeight, color: Colors.white.withOpacitySafe(0.4)),
            ),
          ),
        ),
      ),
    );

    /// 위로 올라가는 위젯 영역
    if (widget.upDisappearHeader != null) {
      scrollSlivers.add(
        SliverPersistentHeader(
          pinned: false,
          // floating:true,
          delegate: widget.upDisappearHeader!,
        ),
      );
    }

    /// 스크롤 상단 앱바 아래 깔리는 뷰 영역
    /// upDisappearHeader 아래
    /// floating : false : 가장 상단으로 올라가야 내려옴
    /// floating : true : 스크롤을 하자마자 헤더가 내려옴
    if (widget.fixedHeader != null) {
      scrollSlivers.add(
        SliverPersistentHeader(
          pinned: true,
          // floating:true,
          delegate: widget.fixedHeader!,
        ),
      );
    }

    /// 새로고침 드래그시 상단 로딩 이미지
    if (widget.isRefresh == true) {
      scrollSlivers.add(
        CupertinoSliverRefreshControl(
          // refreshTriggerPullDistance: 100.0,
          // 다시 로드를 트리거하려면 스크롤 가능한 오버스크롤 양을 드래그해야 합니다. 기본 100
          // refreshIndicatorExtent: 60.0,
          // 새로 고침 표시기 조각이 유지되는 동안 유지되는 높이기본 60
          builder: (
            BuildContext context,
            RefreshIndicatorMode refreshState,
            double pulledExtent,
            double refreshTriggerPullDistance,
            double refreshIndicatorExtent,
          ) {
            // iOS 스타일 인디케이터의 회전 애니메이션을 유지하면서 색상만 변경
            return Center(
              child:
                  refreshState == RefreshIndicatorMode.inactive
                      ? const SizedBox.shrink() // 아무것도 표시하지 않음
                      : Container(
                        width: 36,
                        height: 36,
                        padding: const EdgeInsets.all(8.0),
                        child:
                            refreshState == RefreshIndicatorMode.refresh
                                ? const CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFE6F0F)),
                                  strokeCap: StrokeCap.round,
                                )
                                : CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFFFE6F0F),
                                  ),
                                  strokeCap: StrokeCap.round,
                                  value: pulledExtent / refreshTriggerPullDistance,
                                ),
                      ),
            );
          },
          onRefresh: () async {
            QcLog.d('onRefresh ================');
            if (widget.onRefresh != null) {
              /// 새로고침 로딩 딜레이주기
              // await Future.delayed(const Duration(seconds: 2));
              await widget.onRefresh!();
            }
          },
        ),
      );
    }

    if (widget.noListContent != null) {
      scrollSlivers.add(SliverToBoxAdapter(child: widget.noListContent));
    }

    /// 리스트 내용
    /// 로딩 결과에 따라
    ///
    switch (widget.netState) {
      // case NetState.Loading:
      //   scrollSlivers.add(
      //     SliverFillRemaining(
      //       hasScrollBody: false,
      //       child: Center(child: CircularProgressIndicator(
      //         strokeWidth: 2.0,
      //         valueColor: const AlwaysStoppedAnimation<Color>(
      //           Color(0xFFFE6F0F),
      //         ),
      //         strokeCap: StrokeCap.round,
      //       )),
      //     ),
      //   );
      case NetState.Error:
        scrollSlivers.add(
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text(widget.emptyMsg ?? "오류가 발생했습니다.")),
          ),
        );

      case NetState.Empty:

        /// 리스트 데이터가 없거나 api 조회 에러인 경우 보여줄 화면
        scrollSlivers.add(
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text(widget.emptyMsg ?? "데이터가 없습니다.")),
          ),
        );
      case NetState.Completed:
      case NetState.Paging:

        /// 리스트 컨텐츠
        if (widget.sliverChildBuilder != null) {
          scrollSlivers.add(
            SliverList(
              delegate: SliverChildBuilderDelegate(
                widget.sliverChildBuilder!,
                childCount: widget.itemCount,
              ),
            ),
          );
        } else {
          // scrollSlivers.add(SliverFillRemaining(
          //     hasScrollBody: true,
          //     child: widget.noListContent));

          // scrollSlivers.add(SliverToBoxAdapter(
          //   child: widget.noListContent,
          // ));
        }

        /// 하단 리스트 로딩 후 뷰
        if (Platform.isAndroid) {
          scrollSlivers.add(
            SliverFillRemaining(
              hasScrollBody: false,
              child: getSliverFillRemaining(context, widget.isMoreDataScroll),
            ),
          );
        }
      default:
    }

    /// 제일 아래는 네비게이션 위에 위젯이 다 올라가게
    scrollSlivers.add(
      SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).viewPadding.bottom)),
    );

    return scrollSlivers;
  }
}

/*
 * 실패
 * 로드할 데이터가 있는 경우
 *
 */
Widget getSliverFillRemaining(BuildContext context, MoreDataScroll? isMoreScrollLoad) {
  if (isMoreScrollLoad == MoreDataScroll.HAS) {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: Center(child: CircularProgressIndicator(color: Color(0xFFFE6F0F), strokeWidth: 3.5)),
      ),
    );
  } else if (isMoreScrollLoad == MoreDataScroll.FAIL) {
    /// 더보기 실패시 메시지 필요하다면
    return Container(
      alignment: Alignment.center,
      // child: QcText.bodyMedium(
      //   'error_content'.tr,
      // ),
      child: const Text("오류가 발생했습니다."),
    );
  } else {
    // return Container();
    return const SizedBox.shrink();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return NotificationListener<ScrollNotification>(
  //       onNotification: (ScrollNotification scrollInfo) {
  //         /// ScrollUpdateNotification(depth: 0 (local), FixedScrollMetrics(968.9..[717.7]..3673.4), scrollDelta: 0.09460146127491953)
  //         // widget.onScrollNotification(scrollInfo);
  //         // return false;
  //
  //         logUtil.debug("Scroll === ${scrollInfo.metrics.axisDirection} , ${AxisDirection.down} , ${AxisDirection.up}");
  //         var metrics = scrollInfo.metrics;
  //
  //         //세로 스크롤인 경우에만 추적
  //         if (metrics.axisDirection != AxisDirection.down){
  //           logUtil.debug('scrollInfo ==== 세로 스크롤인 경우에만 추적');
  //           return false;
  //         }
  //
  //         if (metrics.extentAfter <= 0) {
  //           //스크롤 끝에 닿은 경우 실행
  //           logUtil.debug('scrollInfo ==== 스크롤 끝에 닿은 경우 실행');
  //         }
  //         return false;
  //       },
  //       child: CustomScrollView(
  //         // key: Key(itemCount.toString()), // 리스트 내용 변환시 업데이트 반영 todo 그런데 리스트 추가시도 변경됨 remove에 사용해야하는데
  //         // controller: scController,
  //         physics: widget.isRefresh
  //             ? const AlwaysScrollableScrollPhysics(
  //                 //physics 물리 - 원하는 UI에 맞춰 작업하면 됨
  //                 // NeverScrollableScrollPhysics : 목록 스크롤 불가능하게 설정
  //                 // BouncingScrollPhysics : 튕겨저 올라가는 듯한 동작 가능 List 끝에 도달했을 시에 다시 되돌아감
  //                 // ClampingScrollPhysics : 안드로이드의 기본 스크롤과 동일하다. List의 끝에 도달하면 동작을 멈춤
  //                 // PageScrollPhysics : 다른 스크롤에 비해 조금더 부드럽게 만듬
  //                 parent: BouncingScrollPhysics(), //ios 기본
  //               )
  //             : null,
  //         slivers: getSliversContents(context),
  //       ));
  // }
}
