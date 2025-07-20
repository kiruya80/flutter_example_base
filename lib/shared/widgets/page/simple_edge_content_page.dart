import 'package:flutter/material.dart';

import '../common/edge_space_widget.dart';

///
/// 사용
/// ㄴ 엣지투엣지이고 앱바 및
/// 바텀네비게이션 x
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
  final ScrollController? controller;

  const SimpleEdgeContentPage({
    super.key,
    this.isPhysics = false,
    this.isSpaceStatus = true,
    this.backgroundColor,
    this.child,
    this.controller,
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

    /// status 영역잡기
    if (widget.isSpaceStatus == true) {
      scrollSlivers.add(
        SliverToBoxAdapter(child: BottomEdgeSpaceWidget(isEdgeToEdge: true, isBottom: false)),
      );
    }

    /// 컨텐츠 영역
    scrollSlivers.add(SliverToBoxAdapter(child: widget.child));

    /// 네비게이터 높이
    scrollSlivers.add(SliverToBoxAdapter(child: BottomEdgeSpaceWidget(isEdgeToEdge: true)));

    return scrollSlivers;
  }
}
