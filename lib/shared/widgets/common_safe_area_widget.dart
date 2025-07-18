import 'package:flutter/material.dart';
import 'package:flutter_example_base/shared/widgets/refresh_more_scrollview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/base_con_state.dart';
import 'common/edge_space_widget.dart';

///
/// 기본 safeArea를 가지고 있고
/// 엣지투엣지를 사용하는 화면인 경우
/// 디바이스에 따라 상하 여백을 위해 사용한다
///
/// !! 위 아래 여백을 사용하지 않는 화면인 경우만 !!!
///
class CommonSafeAreaWidget extends ConsumerStatefulWidget {
  final Widget child;
  final bool? isTop;
  final bool? isBottom;

  const CommonSafeAreaWidget({super.key, required this.child, this.isTop, this.isBottom});

  @override
  ConsumerState<CommonSafeAreaWidget> createState() => _CommonSafeAreaWidgetState();
}

class _CommonSafeAreaWidgetState extends BaseConState<CommonSafeAreaWidget> {
  @override
  Widget build(BuildContext context) {
    isTop = widget.isTop ?? true;
    isBottom = widget.isBottom ?? true;
    return SafeArea(
      top: isTop,
      bottom: isBottom,
      child: Container(
        width: double.maxFinite,
        color: Colors.teal,
        child: Column(
          children: [
            // BottomEdgeSpaceWidget(isBottom: false, isEdgeToEdge: !isTop),
            Expanded(child: widget.child),
            // BottomEdgeSpaceWidget(isEdgeToEdge: !isBottom),
          ],
        ),
        /// 아래 안됨
        // child: Expanded(child: RefreshMoreScrollview(content: widget.child)),
      ),
    );
  }
}
