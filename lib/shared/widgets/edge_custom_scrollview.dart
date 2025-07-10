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
  /// 스크롤시 팅기는 효과
  final bool? isPhysics;

  /// status 여백 유무
  final bool? isSpaceStatus;
  final Color? backgroundColor;
  final Widget? content;

  const EdgeCustomScrollview({
    super.key,
    this.isPhysics = false,
    this.isSpaceStatus = true,
    this.backgroundColor,
    this.content,
  });

  @override
  State<EdgeCustomScrollview> createState() => _EdgeCustomScrollviewState();
}

class _EdgeCustomScrollviewState extends State<EdgeCustomScrollview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
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
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    QcLog.d('statusBarHeight === $statusBarHeight ,($kToolbarHeight) bottomInset === $bottomInset');

    List<Widget> scrollSlivers = [];

    /// status 영역잡기
    if (widget.isSpaceStatus == true) {
      scrollSlivers.add(
        SliverToBoxAdapter(child: Container(height: statusBarHeight, color: Colors.transparent)),
      );
    }

    /// 컨텐츠 영역
    scrollSlivers.add(SliverToBoxAdapter(child: widget.content));

    /// 네비게이터 높이
    scrollSlivers.add(
      SliverToBoxAdapter(child: Container(height: bottomInset, color: Colors.transparent)),
    );

    return scrollSlivers;
  }
}
