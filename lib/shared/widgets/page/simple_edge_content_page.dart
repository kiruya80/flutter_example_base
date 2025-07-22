import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/refresh_scroll_widgets.dart';

///
/// 사용
/// ㄴ 엣지투엣지이고 앱바 및 바텀네비게이션 x
/// ㄴ ✅ 새로고침 가능, 단 더보기 등이 아닌 현재 컨텐츠만 새로 로딩
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
class SimpleEdgeContentPage extends StatefulWidget {
  /// 스크롤시 팅기는 효과
  final bool? isPhysics;

  /// status 여백 유무
  final bool? isSpaceStatus;
  final Color? backgroundColor;
  final Widget? child;
  final Widget? emptyContent;
  final ScrollController? controller;

  /// onRefresh 시 호출 함수
  final Future<void> Function()? onRefresh;

  const SimpleEdgeContentPage({
    super.key,
    this.isPhysics = false,
    this.isSpaceStatus = true,
    this.backgroundColor,
    this.child,
    this.emptyContent,
    this.controller,
    this.onRefresh,
  });

  @override
  State<SimpleEdgeContentPage> createState() => _SimpleEdgeContentPageState();
}

class _SimpleEdgeContentPageState extends State<SimpleEdgeContentPage> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   extendBody: true,
    //   extendBodyBehindAppBar: true,
    //   body: SafeArea(
    //     top: false,
    //     bottom: false,
    //     child: Container(
    //       width: double.maxFinite,
    //       color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
    //       child: CustomScrollView(
    //         controller: widget.controller,
    //         physics:
    //             widget.isPhysics == true
    //                 ? const AlwaysScrollableScrollPhysics(
    //                   parent: BouncingScrollPhysics(), //ios 기본
    //                 )
    //                 : null,
    //         slivers: getSliversContents(context),
    //       ),
    //     ),
    //   ),
    // );
    return Container(
      width: double.maxFinite,
      color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
      child: CustomScrollView(
        controller: widget.controller, // 직접 설정 시,
        primary: false, // primary는 false로
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

    /// 엣지 투 엣지인 경우 상단 스테이터스 영역
    if (widget.isSpaceStatus == true) {
      RefreshScrollWidgets().getStatus(context, scrollSlivers);
    }

    /// 새로고침 드래그시 상단 로딩 이미지
    if (widget.onRefresh != null) {
      RefreshScrollWidgets().getRefresh(scrollSlivers, onRefresh: widget.onRefresh);
    }

    /// 1. 데이터가 없는 경우
    if (widget.emptyContent != null) {
      scrollSlivers.add(SliverToBoxAdapter(child: widget.emptyContent));
    }

    /// 2. 컨텐츠 영역 - scrollview, listview 등등
    scrollSlivers.add(SliverToBoxAdapter(child: widget.child));

    /// 네비게이터 높이 :  홈 네비게이터등이 있는 경우 여백
    RefreshScrollWidgets().getBottomSpace(scrollSlivers);

    return scrollSlivers;
  }
}
