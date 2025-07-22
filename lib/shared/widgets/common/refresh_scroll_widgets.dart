import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/device_info_utils.dart';
import 'edge_space_widget.dart';
import 'my_sliver_persistent_header_delegate.dart';

///
/// refresh scrollview에서 사용하는 scrollSlivers
///
class RefreshScrollWidgets {
  /// 엣지 투 엣지인 경우 상단 스테이터스 영역
  getStatus(BuildContext context, List<Widget> scrollSlivers) {
    scrollSlivers.add(
      SliverPersistentHeader(
        delegate: MySliverPersistentHeaderDelegate(
          maxHeight: DeviceInfoUtils.instance.getEdgeSpaceHeight(context, isBottom: false),
          minHeight: 0,
          child: BottomEdgeSpaceWidget(isEdgeToEdge: true, isBottom: false),
        ),
      ),
    );
    // scrollSlivers.add(
    //   SliverToBoxAdapter(
    //       child: BottomEdgeSpaceWidget(isEdgeToEdge: true, isBottom: false)
    //   ),
    // );
  }

  /// 높이 고정 앱바 - transparent
  getAppbar(List<Widget> scrollSlivers, String? appTitle) {
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
          title: Text(appTitle ?? ''),
          background: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(height: kToolbarHeight, color: Colors.white.withOpacitySafe(0.4)),
            ),
          ),
        ),
      ),
    );
  }

  /// 위로 올라가는 위젯 영역
  getDisappearHeader(
    List<Widget> scrollSlivers,
    SliverPersistentHeaderDelegate? upDisappearHeader,
  ) {
    scrollSlivers.add(
      SliverPersistentHeader(
        pinned: false,
        // floating:true,
        delegate: upDisappearHeader!,
      ),
    );
  }

  /// 스크롤 상단 앱바 아래 깔리는 뷰 영역
  /// upDisappearHeader 아래
  /// floating : false : 가장 상단으로 올라가야 내려옴
  /// floating : true : 스크롤을 하자마자 헤더가 내려옴
  getFixedHeader(List<Widget> scrollSlivers, SliverPersistentHeaderDelegate? fixedHeader) {
    scrollSlivers.add(
      SliverPersistentHeader(
        pinned: true,
        // floating:true,
        delegate: fixedHeader!,
      ),
    );
  }

  /// 새로고침 드래그시 상단 로딩 이미지
  getRefresh(List<Widget> scrollSlivers, {Future<void> Function()? onRefresh}) {
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
                              ? CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  // Color(0xFFFE6F0F)
                                  Theme.of(context).colorScheme.secondary,
                                ),
                                strokeCap: StrokeCap.round,
                              )
                              : CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  // Color(0xFFFE6F0F),
                                  Theme.of(context).colorScheme.primary,
                                ),
                                strokeCap: StrokeCap.round,
                                value: pulledExtent / refreshTriggerPullDistance,
                              ),
                    ),
          );
        },
        onRefresh: () async {
          if (onRefresh != null) {
            await Future.delayed(const Duration(milliseconds: 500));
            await onRefresh();
          }
        },
      ),
    );
  }

  /// 3. 리스트 내용 - sliverChildBuilder 를 사용하는 경우
  loadData(
    BuildContext context,
    List<Widget> scrollSlivers,
    IndexedWidgetBuilder? sliverChildBuilder,
    int? itemCount,
    NetState? netState,
    String? emptyMsg,
    // bool? safeAreaBottom,
    MoreDataScroll? isMoreDataScroll,
  ) {
    switch (netState) {
      case NetState.Loading:
        break;
      case NetState.Error:
        scrollSlivers.add(
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text(emptyMsg ?? "오류가 발생했습니다.")),
          ),
        );
        break;

      case NetState.Empty:

        /// 리스트 데이터가 없거나 api 조회 에러인 경우 보여줄 화면
        scrollSlivers.add(
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text(emptyMsg ?? "데이터가 없습니다.")),
          ),
        );
        break;
      case NetState.Completed:
      case NetState.Paging:

        /// 리스트 컨텐츠
        if (sliverChildBuilder != null) {
          scrollSlivers.add(
            SliverList(
              delegate: SliverChildBuilderDelegate(sliverChildBuilder, childCount: itemCount),
            ),
          );
        } else {
          /// 컨텐츠 영역
          // if (widget.content != null) {
          //   QcLog.d('컨텐츠 영역 ============');
          //   scrollSlivers.add(SliverToBoxAdapter(child: widget.content));
          // }

          // scrollSlivers.add(SliverFillRemaining(
          //     hasScrollBody: true,
          //     child: widget.noListContent));

          // scrollSlivers.add(SliverToBoxAdapter(
          //   child: widget.noListContent,
          // ));
        }

        /// 하단 리스트 로딩 후 뷰
        // if (safeAreaBottom == false) {
          scrollSlivers.add(
            SliverFillRemaining(
              hasScrollBody: false,
              child: getSliverFillRemaining(context, isMoreDataScroll),
            ),
          );
        // }
        break;

      default:
    }
  }

  /// 네비게이터 높이 :  홈 네비게이터등이 있는 경우 여백
  getBottomSpace(List<Widget> scrollSlivers, {bool isEdgeToEdge = true}) {
    QcLog.d('getBottomSpace ====$isEdgeToEdge');
    scrollSlivers.add(
      SliverToBoxAdapter(child: BottomEdgeSpaceWidget(isEdgeToEdge: isEdgeToEdge)),
    );
  }

  ///
  /// 실패 : 로드할 데이터가 있는 경우
  ///
  getSliverFillRemaining(BuildContext context, MoreDataScroll? isMoreScrollLoad) {
    if (isMoreScrollLoad == MoreDataScroll.HAS) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: Center(
            child: CircularProgressIndicator(
              // color: Color(0xFFFE6F0F),
              color: Theme.of(context).colorScheme.primary,
              strokeWidth: 3.5,
            ),
          ),
        ),
      );
    } else if (isMoreScrollLoad == MoreDataScroll.FAIL) {
      /// 더보기 실패시 메시지 필요하다면
      return Container(alignment: Alignment.center, child: const Text("오류가 발생했습니다."));
    } else {
      return const SizedBox.shrink();
    }
  }
}
