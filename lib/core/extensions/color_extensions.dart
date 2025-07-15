import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';

extension ColorExtension on Color {
  /// 정밀도 손실 없이 알파값(opacity)을 변경합니다.
  /// [opacity]는 0.0 ~ 1.0 사이여야 하며, 0.0은 완전 투명, 1.0은 불투명입니다.
  Color withOpacitySafe(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0, 'Opacity must be between 0.0 and 1.0');
    final alpha = opacity.clamp(0.0, 1.0);
    // QcLog.d('withOpacitySafe === $alpha');
    return withValues(alpha: alpha);
  }

  /// 예: 밝기 조정
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}
