import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example_base/core/extensions/string_extensions.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_example_base/shared/widgets/common/refresh_scroll_widgets.dart';

import '../../../core/constants/app_constants.dart';

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
  final Widget? emptyContent;
  final Widget? content;

  /// status 영역잡기
  final bool? safeAreaTop;
  final bool? safeAreaBottom;

  final Color? backgroundColor;
  final ScrollController? controller;
  final String? appTitle;

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
    this.emptyContent,
    this.content,

    this.safeAreaTop = false,

    /// false인 경우 엣지투엣지
    this.safeAreaBottom = false,

    /// false인 경우 엣지투엣지
    this.backgroundColor,
    this.controller,
    this.appTitle,
  });

  @override
  State<RefreshMoreScrollview> createState() => _RefreshMoreScrollviewState();
}

class _RefreshMoreScrollviewState extends State<RefreshMoreScrollview> {
  // AlwaysScrollableScrollPhysics(
  //physics 물리 - 원하는 UI에 맞춰 작업하면 됨
  // NeverScrollableScrollPhysics : 목록 스크롤 불가능하게 설정
  // BouncingScrollPhysics : 튕겨저 올라가는 듯한 동작 가능 List 끝에 도달했을 시에 다시 되돌아감
  // ClampingScrollPhysics : 안드로이드의 기본 스크롤과 동일하다. List의 끝에 도달하면 동작을 멈춤
  // PageScrollPhysics : 다른 스크롤에 비해 조금더 부드럽게 만듬

  @override
  Widget build(BuildContext context) {
    QcLog.d('build itemCount ==== ${widget.itemCount}');

    return Container(
      width: double.maxFinite,
      color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
      child: CustomScrollView(
        controller: widget.controller,
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
      RefreshScrollWidgets().getStatus(context, scrollSlivers);
    }

    /// 높이 고정 앱바 - transparent
    if (widget.appTitle.isNotNullOrEmpty) {
      RefreshScrollWidgets().getAppbar(scrollSlivers, widget.appTitle);
    }

    /// 위로 올라가는 위젯 영역
    if (widget.upDisappearHeader != null) {
      RefreshScrollWidgets().getDisappearHeader(scrollSlivers, widget.upDisappearHeader);
    }

    /// 스크롤 상단 앱바 아래 깔리는 뷰 영역
    /// upDisappearHeader 아래
    /// floating : false : 가장 상단으로 올라가야 내려옴
    /// floating : true : 스크롤을 하자마자 헤더가 내려옴
    if (widget.fixedHeader != null) {
      RefreshScrollWidgets().getFixedHeader(scrollSlivers, widget.fixedHeader);
    }

    /// 새로고침 드래그시 상단 로딩 이미지
    if (widget.isRefresh == true) {
      RefreshScrollWidgets().getRefresh(scrollSlivers, onRefresh: widget.onRefresh);
    }

    /// 1. 데이터가 없는 경우
    if (widget.emptyContent != null) {
      scrollSlivers.add(SliverToBoxAdapter(child: widget.emptyContent));
    }

    /// 2. 컨텐츠 영역 - scrollview, listview 등등
    if (widget.content != null) {
      scrollSlivers.add(SliverToBoxAdapter(child: widget.content));
    }

    /// 3. 리스트 내용 - sliverChildBuilder 를 사용하는 경우
    /// 로딩 결과에 따라
    ///
    RefreshScrollWidgets().loadData(
      context,
      scrollSlivers,
      widget.sliverChildBuilder,
      widget.itemCount,
      widget.netState,
      widget.emptyMsg,
      // widget.safeAreaBottom,
      widget.isMoreDataScroll,
    );

    /// 네비게이터 높이 :  홈 네비게이터등이 있는 경우 여백
    if (widget.safeAreaBottom == false) {
      RefreshScrollWidgets().getBottomSpace(scrollSlivers);
    }
    return scrollSlivers;
  }
}
