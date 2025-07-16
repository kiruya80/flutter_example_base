import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';

/**
    ImageFilter.blur(sigmaX: 0, sigmaY: 0)
    블러 없음 (선명)
    ImageFilter.blur(sigmaX: 10, sigmaY: 0)
    가로 방향만 흐려짐
    ImageFilter.blur(sigmaX: 0, sigmaY: 10)
    세로 방향만 흐려짐
    ImageFilter.blur(sigmaX: 10, sigmaY: 10)
    일반적인 균일 블러
    ImageFilter.blur(sigmaX: 30, sigmaY: 30)
    많이 퍼지는 강한 블러

    CommonEdgeToEdgePage에서 appBar가 있으면 빌드시 appBar까지 블러처리됨
 */
class BlurOverlay extends StatelessWidget {
  final Color? overlayColor;
  final double? height;
  final bool? isBlur;
  final bool? isDark;
  final bool? isBottom;

  const BlurOverlay({
    super.key,
    this.overlayColor,
    this.height, // 상태바 + 상단 일부
    this.isBlur = true,
    this.isDark = false,
    this.isBottom = false,
  });

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    /**
     * 아래로 스크롤 → 바텀바 숨김 (콘텐츠가 위로 이동)
        build === false |  Color(alpha: 1.0000, red: 0.9765, green: 0.9804, blue: 0.9373, colorSpace: ColorSpace.sRGB) | false ,true ,  34.666666666666664

        위로 스크롤 → 바텀바 보여줌 (콘텐츠가 아래로 이동)
        build === false |  Color(alpha: 1.0000, red: 0.9765, green: 0.9804, blue: 0.9373, colorSpace: ColorSpace.sRGB) | false ,true ,  34.666666666666664
     */

    ///
    ///  •	sigmaX: 5, sigmaY: 5 → 살짝 흐려진 유리창 느낌
    ///  •	sigmaX: 20, sigmaY: 20 → 뿌연 배경 (iOS 스타일 시트 느낌)
    ///  •	sigmaX: 50, sigmaY: 10 → 옆으로만 퍼지는 특이한 블러 (스타일용으로 사용 가능)
    ///
    return ClipRect(
      child:
          isBlur == true
              ? BackdropFilter(
                // filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                // filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: _content(statusBarHeight),
              )
              : _content(statusBarHeight),
    );
  }

  _content(statusBarHeight) {
    return Container(
      height: height ?? statusBarHeight,
      // 반투명 오버레이
      color:
          overlayColor ??
          (isDark == true
              ? Colors.black.withOpacitySafe(0.2)
              : Colors.white.withOpacitySafe(isBottom == true ? 0.5 : 0.2)),
    );
  }
}
