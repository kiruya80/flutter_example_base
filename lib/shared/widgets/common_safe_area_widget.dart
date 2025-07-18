import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/base_con_state.dart';
import 'edge_space_widget.dart';

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
        color: Colors.orange,
        child: Column(
          children: [
            BottomEdgeSpaceWidget(isBottom: false, isEdgeToEdge: !isTop),
            Expanded(child: widget.child),
            BottomEdgeSpaceWidget(isEdgeToEdge: !isBottom),
          ],
        ),
      ),
    );
  }
}
