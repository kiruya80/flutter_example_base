import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';

enum BlurBottomType { Scale, NoScale, Ripple }

///
/// 바텀네비게이션 버튼 아이템
///
class BlurBottomBarItem extends StatefulWidget {
  final bool selected;
  final IconData iconData;
  final String label;
  final VoidCallback onTap;
  final BlurBottomType? blurType;

  const BlurBottomBarItem({
    super.key,
    required this.selected,
    required this.iconData,
    required this.label,
    required this.onTap,
    this.blurType = BlurBottomType.Ripple,
  });

  @override
  State<BlurBottomBarItem> createState() => BlurBottomBarItemState();
}

class BlurBottomBarItemState extends State<BlurBottomBarItem> with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(_) => setState(() => _scale = 0.9);

  void _onTapUp(_) => setState(() => _scale = 1.0);

  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    if (widget.blurType == BlurBottomType.Scale) {
      return getTabScale();
    } else if (widget.blurType == BlurBottomType.NoScale) {
      return getTabNoScale();
    } else {
      return getRipple();
    }
  }

  /// 탭을 누르면 살짝 작아졌다가 돌아오는 효과
  getTabScale() {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: widget.selected ? Colors.white.withOpacitySafe(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  widget.iconData,
                  key: ValueKey<bool>(widget.selected),
                  color: widget.selected ? Colors.black : Colors.white60,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.selected ? Colors.black : Colors.white60,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getTabNoScale() {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: widget.selected ? Colors.white.withOpacitySafe(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon(item.icon, color: selected ? Colors.black : Colors.white60),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                widget.iconData,
                key: ValueKey<bool>(widget.selected),
                color: widget.selected ? Colors.black : Colors.white60,
              ),
            ),
            // item.icon,
            const SizedBox(height: 2),
            Text(
              widget.label ?? '',
              style: TextStyle(
                color: widget.selected ? Colors.black : Colors.white60,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getRipple() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: widget.selected ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  widget.iconData,
                  key: ValueKey<bool>(widget.selected),
                  color: widget.selected ? Colors.black : Colors.white60,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.selected ? Colors.black : Colors.white60,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
