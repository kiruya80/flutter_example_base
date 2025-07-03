import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';

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

 */
class StatusBlurOverlay extends StatelessWidget {
  final Color? backgroundColor;
  final double? height;

  const StatusBlurOverlay({
    super.key,
    this.backgroundColor,
    this.height, // 상태바 + 상단 일부
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.surface;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    QcLog.d('statusBarHeight === $statusBarHeight');

    // return Positioned(
    //   top: 0,
    //   left: 0,
    //   right: 0,
    //   height: statusBarHeight,
    //   child:
    //   /// ✅ 상태바 영역에만 blur + 반투명 배경
    //   ///
    //   /// sigmaX
    //   /// **가로 방향(X축)**으로 얼마나 흐릴지 (수치가 클수록 더 많이 퍼짐)
    //   ///
    //   /// sigmaY
    //   /// **세로 방향(Y축)**으로 얼마나 흐릴지
    //   ///
    //   ClipRect(
    //     child: BackdropFilter(
    //       // filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
    //       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
    //       child: Container(
    //         height: statusBarHeight,
    //         // color: Colors.white.withOpacity(0.2), // 반투명 오버레이
    //         color: Colors.white.withOpacitySafe(0.4),
    //       ),
    //     ),
    //   ),
    // );

    ///
    ///  •	sigmaX: 5, sigmaY: 5 → 살짝 흐려진 유리창 느낌
    ///  •	sigmaX: 20, sigmaY: 20 → 뿌연 배경 (iOS 스타일 시트 느낌)
    ///  •	sigmaX: 50, sigmaY: 10 → 옆으로만 퍼지는 특이한 블러 (스타일용으로 사용 가능)
    ///
    return ClipRect(
      child: BackdropFilter(
        // filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: height ?? statusBarHeight,
          // color: Colors.white.withOpacity(0.2), // 반투명 오버레이
          color: Colors.white.withOpacitySafe(0.4),
        ),
      ),
    );
  }
}
