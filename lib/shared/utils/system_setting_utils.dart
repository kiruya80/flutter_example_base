import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';

class SystemSettingUtils {
  ///
  /// statusBarIconBrightness
  /// ㄴ ThemeMode.dark - 아이콘 검은색 - 블러 처리시
  /// ㄴ Brightness.light - 아이콘 흰색
  ///
  ///
  void setSystemUiOverlayStyle({
    bool? isBlur = true,
    bool? isDark = false,
    Color? statusBarColor,
    // Color? systemNavigationBarDividerColor,
  }) {
    QcLog.d('setSystemUiOverlayStyle ==== $isBlur , $isDark');
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        /// iOS에서는 statusBarColor는 완전히 무시
        statusBarColor:
            isBlur == true
                ? Colors.transparent
                : (statusBarColor?.withOpacitySafe(0.4) ?? Colors.transparent),

        /// ios
        // ✅ iOS 상태바 아이콘 밝기 light(black ison), dark(white icon)
        statusBarBrightness:
            isBlur == true
                ? Brightness.dark
                : (isDark == true ? Brightness.dark : Brightness.light),
        // 아이폰 상단 글씨(시계, 배터리) 색상
        // ✅ Android 상태바 아이콘 밝기 → light(white ison), dark(black icon)
        statusBarIconBrightness:
            // isBlur == true
            //     ? Brightness.dark
            //     : (isDark == true ? Brightness.dark : Brightness.light),
            isDark == true ? Brightness.light : Brightness.dark,

        // 안드로이드용 네비게이션 아이콘 색상 null이면 불투명
        // 변경시 transparent로 하고 위에 위젯을 덮는 형태로 색상변경 가능
        systemNavigationBarColor: Colors.transparent,
        // 네비게이션 바 구분선 색상 설정 null이면 불투명
        // systemNavigationBarDividerColor: systemNavigationBarDividerColor ?? Colors.transparent,
        // 아이콘 색상 (흰색)
        // ✅ Android 네비게이션 아이콘 밝기 → light(white ison, 검은색 반투명 배경), dark(black icon, 흰색 반투명 배경)
        systemNavigationBarIconBrightness:
            // isBlur == true
            //     ? Brightness.dark
            //     : (isDark == true ? Brightness.dark : Brightness.light),
            isDark == true ? Brightness.light : Brightness.dark,
        // 자동 대비 조정 끄기 (Android 10+) false : 검은색,흰색 반투명 삭제 투명으로 변경
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }
}
