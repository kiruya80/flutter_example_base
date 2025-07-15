import 'package:flutter/cupertino.dart';

///
/// 생성일 : 2025. 7. 4.
/// class 설명
///
/// CustomScrollView 에서 사용
///  ㄴ SliverPersistentHeader등에 넣을때 스크를하면 상단에서 최소높이까지만 줄어듬
///
class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate({
    required this.minHeight,

    /// 스크롤시 상단에서 최소 보여지는 높이
    required this.maxHeight,

    /// 전체 높이
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant MySliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
