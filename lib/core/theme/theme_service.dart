import 'package:flutter/material.dart';

///
/// 머터리얼 디자인 빌더
/// https://material-foundation.github.io/material-theme-builder/
///
/// todo 디자인 테마 샘플 및 스키마 가져오기
/// https://rydmike.com/flexcolorscheme/themesplayground-latest/
///
/// https://m3.material.io/
/// https://pub.dev/packages/dynamic_color
///
/// final theme = ThemeData(
///   useMaterial3: true,
///   colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
/// ); 사용시에
///
/// 전체 색상 체계에서 가져오기
/// ㄴ Theme.of(context).colorScheme
/// 텍스트 스타일
/// ㄴ Theme.of(context).textTheme
/// 아이콘 스타일
/// ㄴ Theme.of(context).iconTheme
///
/// 기본 색상 colorScheme.primary
/// 강조 색상 colorScheme.secondary
/// 배경 색상 colorScheme.background
/// 표면 색상 colorScheme.surface
/// 오류 색상 colorScheme.error
/// 텍스트 색상 (onX) colorScheme.onPrimary, onBackground, onSurface, etc
///
///
class QcTheme {
  // static const SEED_COLOR = Colors.green;
  // static const SEED_COLOR = Color(0xFF6750A4);
  static const SEED_COLOR = Color(0xFF1ac0c6);

  // static const SEED_COLOR = Color.fromRGBO(103, 80, 164, 0);

  ///
  /// https://material-foundation.github.io/material-theme-builder/#/dynamic
  /// https://m3.material.io/styles/color/the-color-system/key-colors-tones
  /// https://colors.muz.li/
  ///
  ///
  /// primary
  /// 기본 키 색상은 FAB, 눈에 띄는 버튼, 활성 상태 및 융기된 표면의 색조와
  /// 같은 UI 전체의 주요 구성 요소에 대한 역할을 파생하는 데 사용됩니다.
  ///
  /// secondary
  // 보조 키 색상은 필터 칩과 같이 UI에서 덜 눈에 띄는 구성 요소에
  // 사용되는 동시에 색상 표현의 기회를 확장합니다.
  ///
  /// tertiary
  // 3차 키 색상은 1차 색상과 2차 색상의 균형을 맞추거나 요소에 대한
  // 관심을 높이는 데 사용할 수 있는 대비되는 액센트의 역할을 도출하는 데 사용됩니다.
  // 3차 색상 역할은 팀이 재량에 따라 사용할 수 있도록 남겨두고 제품에서 보다
  // 폭넓은 색상 표현을 지원하기 위한 것입니다.
  ///
  ///
  /// Neutral
  /// 뉴트럴 키 컬러는 표면과 배경의 역할, 강조가 높은 텍스트와 아이콘을 도출하는 데 사용됩니다.
  ///
  /// neutral variant
  // 중간 변형 키 색상은 중간 강조 텍스트 및 아이콘, 표면 변형 및 구성 요소 윤곽선을 파생하는 데 사용됩니다.
  ///
  ///
  /// Error
  /// 강조 및 중립 키 색상 외에도 색상 시스템에는 오류 역할 자체의 형태로
  /// 오류에 대한 의미론적 색상 역할과 on-error ,
  /// error 컨테이너 및 on-error 컨테이너 역할이 포함됩니다.
  ///
  ///
  /// 제품별 맞춤 색상
  /// 사용자 정의 색상은 오류와 같은 기존 의미를 전달하는 방법으로 UI의 표현 색상과 함께 종종 필요한 특정 색상을 고정합니다.
  // 또한 동적 색상 환경의 가변성과 함께 팀에 더 많은 제어 및 사용자 지정 기능을 제공하는 데 사용됩니다.
  ///
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6750A4),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFEADDFF),
    onPrimaryContainer: Color(0xFF21005D),
    secondary: Color(0xFF625B71),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE8DEF8),
    onSecondaryContainer: Color(0xFF1D192B),
    tertiary: Color(0xFF7D5260),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFD8E4),
    onTertiaryContainer: Color(0xFF31111D),
    error: Color(0xFFB3261E),
    errorContainer: Color(0xFFF9DEDC),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410E0B),
    background: Color(0xFFFFFBFE),
    onBackground: Color(0xFF1C1B1F),
    surface: Color(0xFFFFFBFE),
    onSurface: Color(0xFF1C1B1F),
    surfaceVariant: Color(0xFFE7E0EC),
    onSurfaceVariant: Color(0xFF49454F),
    outline: Color(0xFF79747E),
    onInverseSurface: Color(0xFFF4EFF4),
    inverseSurface: Color(0xFF313033),
    inversePrimary: Color(0xFFD0BCFF),
    shadow: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFD0BCFF),
    onPrimary: Color(0xFF381E72),
    primaryContainer: Color(0xFF4F378B),
    onPrimaryContainer: Color(0xFFEADDFF),
    secondary: Color(0xFFCCC2DC),
    onSecondary: Color(0xFF332D41),
    secondaryContainer: Color(0xFF4A4458),
    onSecondaryContainer: Color(0xFFE8DEF8),
    tertiary: Color(0xFFEFB8C8),
    onTertiary: Color(0xFF492532),
    tertiaryContainer: Color(0xFF633B48),
    onTertiaryContainer: Color(0xFFFFD8E4),
    error: Color(0xFFF2B8B5),
    errorContainer: Color(0xFF8C1D18),
    onError: Color(0xFF601410),
    onErrorContainer: Color(0xFFF9DEDC),
    background: Color(0xFF1C1B1F),
    onBackground: Color(0xFFE6E1E5),
    surface: Color(0xFF1C1B1F),
    onSurface: Color(0xFFE6E1E5),
    surfaceVariant: Color(0xFF49454F),
    onSurfaceVariant: Color(0xFFCAC4D0),
    outline: Color(0xFF938F99),
    onInverseSurface: Color(0xFF1C1B1F),
    inverseSurface: Color(0xFFE6E1E5),
    inversePrimary: Color(0xFF6750A4),
    shadow: Color(0xFF000000),
  );
}
