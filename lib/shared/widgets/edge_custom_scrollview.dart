import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';

///
///
/// CustomScrollView 들어갈 수 있는 위젯
///
/// ✅ SliverAppBar
/// 앱바
///
/// ✅ SliverToBoxAdapter(child: ...)
/// Text, Container, ListView, Column 등 일반 위젯
///
/// ✅ SliverList, SliverFixedExtentList 등
/// 리스트
///
/// ✅ SliverGrid
/// 그리드
///
///
class EdgeCustomScrollview extends StatefulWidget {
  /// 리프래시 사용하는 위젯여부
  final bool? isRefresh;

  /// 추가 데이터 존재유무
  // final MoreDataScroll? isMoreDataScroll;
  //
  // final NetState? netState;
  // final String? emptyMsg;
  // final String? errorMsg;
  //
  // /// onRefresh 시 호출 함수
  // final Future<void> Function()? onRefresh;
  //
  // /// 스크롤 , 바닥 리스너
  // final Future<void> Function()? onBottom;
  //
  // /// 새로고침 인디케이터 색상
  // final Color refreshIndicatorColor;
  //
  // /// 올라가는 헤더
  // final SliverPersistentHeaderDelegate? upDisappearHeader;
  //
  // /// 앱에서 항상 표시되는 헤더
  // final SliverPersistentHeaderDelegate? fixedHeader;

  /// status 여백 유무
  final Color? backgroundColor;
  final bool? isSpaceStatus;
  final Widget? content;

  final Widget? noListContent;

  const EdgeCustomScrollview({
    super.key,
    this.isRefresh = true,

    // this.isMoreDataScroll = MoreDataScroll.NONE,
    // this.netState,
    // this.emptyMsg = "데이터가 없습니다.",
    // this.errorMsg = "오류가 발생했습니다.",
    // this.onRefresh,
    // this.onBottom,
    // this.refreshIndicatorColor = Colors.blue,
    // this.upDisappearHeader,
    // this.fixedHeader,
    this.backgroundColor = Colors.white,
    this.isSpaceStatus = true,
    this.content,
    this.noListContent,
  });

  @override
  State<EdgeCustomScrollview> createState() => _EdgeCustomScrollviewState();
}

class _EdgeCustomScrollviewState extends State<EdgeCustomScrollview> {
  /// NotificationListener
  ///
  // bool _onNotification(ScrollNotification scrollNotification) {
  //   if (widget.isMoreDataScroll != MoreDataScroll.HAS) {
  //     return false;
  //   }
  //   // QcLog.d('_onNotification  EdgeCustomScrollviewState ====== ');
  //   var metrics = scrollNotification.metrics;
  //   //세로 스크롤인 경우에만 추적
  //   if (metrics.axisDirection != AxisDirection.down) return false;
  //   if (metrics.extentAfter <= 0) {
  //     //스크롤 끝에 닿은 경우 실행
  //     // if (widget.isRefresh == true && widget.onBottom != null) {
  //     if (widget.onBottom != null) {
  //       widget.onBottom!();
  //     }
  //   }
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    QcLog.d('statusBarHeight === $statusBarHeight ,($kToolbarHeight) bottomInset === $bottomInset');

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification onNotification) {
        //스크롤 시 이 부분에서 이벤트가 발생한다.
        // _onNotification(onNotification);
        return false;
      },
      child: Container(
        color: widget.backgroundColor,
        child: CustomScrollView(
          // controller: pagingScrollController,
          physics:
              widget.isRefresh == true
                  ? const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(), //ios 기본
                  )
                  : null,
          slivers: [
            // SliverAppBar(
            //   pinned: true,
            //   expandedHeight: statusBarHeight,
            //   flexibleSpace: FlexibleSpaceBar(title: Text('제목')),
            // ),
            if (widget.isSpaceStatus == true)
              SliverToBoxAdapter(
                child: Container(height: statusBarHeight, color: Colors.transparent),
              ),

            SliverToBoxAdapter(child: widget.content),

            /// 네비게이터 높이
            SliverToBoxAdapter(child: Container(height: bottomInset, color: Colors.transparent)),
          ],
        ),
      ),
    );
  }
}
