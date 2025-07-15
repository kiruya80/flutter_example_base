import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example_base/presentation/dialog/dialog_queue_listener.dart';
import 'package:flutter_example_base/shared/utils/system_setting_utils.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app/routes/app_router.dart';
import 'core/theme/app_theme_provider.dart';
import 'core/utils/print_log.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  /// 상태바/내비게이션바 투명하게 만들기
  ///
  /// statusBarIconBrightness
  /// ㄴ Brightness.dark 아이콘 검은색
  /// ㄴ Brightness.light 아이콘 흰색
  ///
  /// systemNavigationBarIconBrightness
  /// ㄴ Brightness.dark 네비게이션 반투명 흰색
  /// ㄴ Brightness.light 네비게이션 반투명 검은색
  ///
  ///
  /// iOS에서는 statusBarColor는 완전히 무시
  ///
  /// light : 검은색 아이콘
  /// dark : 흰색 아이콘
  ///
  // void _setSystemUiOverlayStyle(ThemeMode themeMode) {
  //   /// default - black
  //   SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(
  //       statusBarColor: Colors.transparent,
  //       // ✅ iOS 상태바 아이콘 밝기 light(black ison), dark(white icon)
  //       statusBarBrightness: themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
  //       // ✅ Android 상태바 아이콘 밝기 → light(white ison), dark(black icon)
  //       statusBarIconBrightness: themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
  //
  //       systemNavigationBarColor: Colors.transparent,
  //       // 안드로이드용 네비게이션 아이콘 색상 null이면 불투명
  //       systemNavigationBarDividerColor: Colors.transparent,
  //       // ✅ Android 네비게이션 아이콘 밝기 → light(white ison, 검은색 반투명 배경), dark(black icon, 흰색 반투명 배경)
  //       systemNavigationBarIconBrightness:
  //           themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
  //       // 자동 대비 조정 끄기 (Android 10+) false : 검은색,흰색 반투명 삭제
  //       systemNavigationBarContrastEnforced: false,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    QcLog.d('My App build');
    FocusScope.of(context).unfocus();

    final deviceTheme = MediaQuery.of(context).platformBrightness;
    final themeMode = deviceTheme == Brightness.dark ? ThemeMode.dark : ThemeMode.light;

    QcLog.d("디바이스 테마 : ${deviceTheme == Brightness.dark ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // provider에 처음 한 번만 설정
      if (ref.read(appThemeModeProvider) == null) {
        ref.read(appThemeModeProvider.notifier).state = themeMode;
        QcLog.d("앱 테마 초기 설정 addPostFrameCallback ");
      }
      final appThemeMode = ref.read(appThemeModeProvider) ?? ThemeMode.system;
      SystemSettingUtils().setSystemUiOverlayStyle(
        isDark: appThemeMode == ThemeMode.dark,
        isBlur: false,
      );
    });

    final appThemeMode = ref.watch(appThemeModeProvider) ?? ThemeMode.system;

    QcLog.d("앱 테마 : ${(appThemeMode == ThemeMode.dark) ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}");

    /// 기본
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    // );

    /// 기본 router
    // return MaterialApp.router(
    //   routerConfig: AppRouter.appRouter,
    //   title: 'Post App',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    // );

    /// 바텀네비게이터
    // return MaterialApp.router(
    //   routerConfig: AppRouter.shellTabRouter,
    //   title: 'GoRouter Tabs Demo',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    // );

    // CupertinoApp
    return MaterialApp.router(
      routerConfig: AppRouter.appRouter,
      title: 'Post App',
      themeMode: appThemeMode, // ThemeMode.system
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // scaffoldBackgroundColor: Colors.white,
        // platform: TargetPlatform.iOS, // 👈 전체를 iOS 스타일로
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xff4c662b),
          brightness: Brightness.light,
        ),
        // colorScheme: MaterialTheme.lightScheme(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        // brightness: Brightness.dark,
        // scaffoldBackgroundColor: Colors.black,
        // platform: TargetPlatform.iOS, // 👈 전체를 iOS 스타일로
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xffb1d18a),
          brightness: Brightness.dark,
        ),
        // colorScheme: MaterialTheme.darkScheme(),
      ),

      builder: (context, child) {
        // 여기의 context는 아직 Navigator가 아닐 수 있으므로
        // 반드시 child 안쪽에서 사용해야 함
        return DialogQueueListener(child: child ?? const SizedBox.shrink());
      },
    );
  }
}

// class _GlobalLoadingBlocker extends StatelessWidget {
//   const _GlobalLoadingBlocker();
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false, // Back key 막음
//       child: AbsorbPointer(
//         // 하위 터치 이벤트 차단
//         absorbing: true,
//         child: Container(
//           color: Colors.black38,
//           alignment: Alignment.center,
//           child: const CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }

/// 바텀네비게이터
/// > MainScaffoldWithNav 로 변경
class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell shell;

  const ScaffoldWithNavBar({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: shell.currentIndex,
        type: BottomNavigationBarType.fixed,
        // 4개 이상일 경우 필요
        backgroundColor: Colors.transparent,
        // 투명처리
        onTap: (index) {
          QcLog.d(
            'state before ===== ${GoRouterState.of(context).topRoute.toString()} , ${GoRouterState.of(context).uri} , ${shell.currentIndex} ',
          );

          // if (index == shell.currentIndex) {
          if (TabChangeObserver.onTabChanged(index)) {
            /// todo 만약 홈탭으로 돌아오고 리빌드 하고 싶을때는 프로바이더나 이벤트 버스등 명시적 호출 필요
            /// if (index == 0) {
            ///   eventBus.fire(HomeTabSelectedEvent());
            ///   homeTabNotifier.refresh();
            /// }
            ///
            /// 동일한 탭 다시 클릭하는 경우 홈으로 이동하게
            shell.goBranch(index, initialLocation: true);
          } else {
            shell.goBranch(index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}

class TabChangeObserver {
  static int _lastIndex = 0;

  static bool onTabChanged(int newIndex) {
    if (_lastIndex != newIndex) {
      debugPrint('🟢 탭 변경: $_lastIndex -> $newIndex');
      _lastIndex = newIndex;
      return false;
    } else {
      return true;
    }
  }
}
