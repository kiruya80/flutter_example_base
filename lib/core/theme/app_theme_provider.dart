import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// 앱 내 테마 변경
/// 테마를 변경하게 되면 My App build 부터 재빌드
///
/// ref.read(appThemeModeProvider.notifier).state
///   = (isDark ?? false) ? ThemeMode.light : ThemeMode.dark;
///
final appThemeModeProvider = StateProvider<ThemeMode?>((ref) => null);
