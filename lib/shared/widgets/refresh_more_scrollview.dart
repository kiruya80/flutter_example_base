import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/device_info_utils.dart';
import 'common/edge_space_widget.dart';
import 'common/my_sliver_persistent_header_delegate.dart';

/// 더보기 데이터 상태
// enum MoreDataScroll { HAS, NONE, FAIL }
//
// enum NetState { Init, Loading, Paging, Empty, Completed, Error, CriticalError }

///
/// 생성일 : 2024. 10. 19.
/// 리프레쉬 & 더가져오기 리스트 위젯
/// https://inblog.ai/vosw1/sliver-%EC%8A%A4%ED%81%AC%EB%A1%A4-%EB%B0%8F-%EB%A6%AC%EC%8A%A4%ED%8A%B8-%EB%A0%8C%EB%8D%94%EB%A7%81-19382
///
/// 1.  refresh - list타입
// RefreshMoreScrollview(
//     isRefresh: // 당겨서 새로고침 여부 기본 true
//     itemCount: 리스트 아이템,
//     isMoreDataScroll: 마지막 페이지 여부 ,
//     netState: DataList.state,
//     emptyMsg: 로딩등 에러시 메시지 ,
//     onRefresh: () async { 상단 리프래쉬
//     },
//     onBottom: () async { 리스트 바닥
//     },
//     upDisappearHeader: // 스크롤시 위로 올라가는 영역
//             MySliverPersistentHeaderDelegate(
//             maxHeight: 237,
//             minHeight: 237,
//             child: Container(
//             )),
//
//     fixedHeader: // 스크롤시 앱바 아래에 고정되는 영역
//          MySliverPersistentHeaderDelegate(
//         maxHeight: 70,
//         minHeight: 70,
//         child: Container(
//           height: 70,
//           color: Colors.white,
//           child:  ,
//         )),
//
//     /// 리스트 컨텐츠
//     sliverChildBuilder: (context, index) {
//       return listItemView();
//       }
//
/// 2. refresh - content타입
// RefreshMoreScrollview(
//     isRefresh: // 당겨서 새로고침 여부 기본 true
//     onRefresh: () async {
//     },
//     upDisappearHeader: // 스크롤시 위로 올라가는 영역
//             MySliverPersistentHeaderDelegate(
//             maxHeight: 237,
//             minHeight: 237,
//             child: Container(
//             )),
//
//     fixedHeader: // 스크롤시 앱바 아래에 고정되는 영역
//          MySliverPersistentHeaderDelegate(
//         maxHeight: 70,
//         minHeight: 70,
//         child: Container(
//           height: 70,
//           color: Colors.white,
//           child:  ,
//         )),
//
//     /// 컨텐츠 영역으로 스크롤시 새로고침 가능 onRefresh
//     noListContent: widget
///
//        CustomScrollView(
//           slivers: [
//             /// 스크롤시 올라가 사라지는 영역
//             SliverToBoxAdapter(
//               child: _upScrollWidget(),
//             ),
//
//             /// 헤더 스크롤시 고정영역 - 플랜선택 위젯
//             SliverPersistentHeader(pinned: true, delegate: getStickyHeaderDelegate()),
//
//             /// 컨텐츠 리스트
//             SliverList(delegate: getPlanData()),
//           ],
//         ),
//
class RefreshMoreScrollview extends StatefulWidget {
  final bool? isPhysics;

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

  // final Widget? boxAdapter;

  /// 올라가는 헤더
  final SliverPersistentHeaderDelegate? upDisappearHeader;

  /// 앱에서 항상 표시되는 헤더
  final SliverPersistentHeaderDelegate? fixedHeader;

  /// 리스트뷰
  final IndexedWidgetBuilder? sliverChildBuilder;
  final Widget? noListContent;
  final Widget? content;

  final bool? safeAreaTop;
  final bool? safeAreaBottom;

  const RefreshMoreScrollview({
    super.key,
    this.isPhysics = true,
    this.isRefresh = true,
    this.itemCount = 0,
    this.isMoreDataScroll = MoreDataScroll.NONE,
    this.netState,
    this.emptyMsg = "데이터가 없습니다.",
    this.errorMsg = "오류가 발생했습니다.",
    this.onRefresh,
    this.onBottom,
    this.refreshIndicatorColor = Colors.blue,
    // this.boxAdapter,
    this.upDisappearHeader,
    this.fixedHeader,
    this.sliverChildBuilder,
    this.noListContent,
    this.content,

    this.safeAreaTop = false,
    this.safeAreaBottom = false,
  });

  @override
  State<RefreshMoreScrollview> createState() => _RefreshMoreScrollviewState();
}

class _RefreshMoreScrollviewState extends State<RefreshMoreScrollview> {
  /// NotificationListener
  ///
  bool _onNotification(ScrollNotification scrollNotification) {
    if (widget.isMoreDataScroll != MoreDataScroll.HAS) {
      return false;
    }
    // QcLog.d('_onNotification  RefreshMoreScrollviewState ====== ');
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

    /// 2. NotificationListener
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification onNotification) {
        //스크롤 시 이 부분에서 이벤트가 발생한다.
        _onNotification(onNotification);
        return false;
      },
      child: CustomScrollView(
        // controller: pagingScrollController,
        physics:
            widget.isPhysics == true
                ? const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(), //ios 기본
                )
                : null,
        slivers: getSliversContents(context),
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

    /// 엣지 투 엣지인 경우 상단 스테이터스 영역
    if (widget.safeAreaTop == false) {
      scrollSlivers.add(
        SliverPersistentHeader(
          delegate: MySliverPersistentHeaderDelegate(
            maxHeight: DeviceInfoUtils.instance.getEdgeSpaceHeight(context, isBottom: false),
            minHeight: 0,
            child: BottomEdgeSpaceWidget(isEdgeToEdge: true, isBottom: false),
          ),
        ),
      );
    }

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
            if (widget.onRefresh != null) {
              // await Future.delayed(const Duration(milliseconds: 500));
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
        if (widget.safeAreaBottom == false) {
          scrollSlivers.add(
            SliverFillRemaining(
              hasScrollBody: false,
              child: getSliverFillRemaining(context, widget.isMoreDataScroll),
            ),
          );
        }

      default:
    }

    /// 하단 여백
    if (widget.safeAreaBottom != null) {
      scrollSlivers.add(
        SliverToBoxAdapter(
          child: BottomEdgeSpaceWidget(isEdgeToEdge: !(widget.safeAreaBottom ?? false)),
        ),
      );
    }
    return scrollSlivers;
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
          child: Center(
            child: CircularProgressIndicator(color: Color(0xFFFE6F0F), strokeWidth: 3.5),
          ),
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
}
