import 'package:flutter/material.dart';
import 'package:flutter_example_base/presentation/dialog/dialog_queue_listener.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app/routes/app_router.dart';
import 'core/theme/app_theme_provider.dart';
import 'core/utils/print_log.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    QcLog.d('My App build');

    final deviceTheme = MediaQuery.of(context).platformBrightness;
    QcLog.d("디바이스 테마 : ${deviceTheme == Brightness.dark ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}");

    // if (deviceTheme == Brightness.dark) {
    //   QcLog.d("디바이스 테마 : 🌙 다크 모드입니다");
    // } else {
    //   QcLog.d("디바이스 테마 : ☀️ 라이트 모드입니다");
    // }

    final appThemeMode = ref.watch(appThemeModeProvider);
    QcLog.d("앱 테마 : ${(appThemeMode == ThemeMode.dark) ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}");

    /// 기본
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    // );

    /// 바텀네비게이터
    // return MaterialApp.router(
    //   routerConfig: AppRouter.shellTabRouter,
    //   title: 'GoRouter Tabs Demo',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    // );

    // final router = ref.watch(rootRouterProvider);
    // return MaterialApp.router(
    //   routerConfig: router,
    // );

    // return MaterialApp.router(
    //   routerConfig: AppRouter.appRouter,
    //   title: 'Post App',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    // );

    // CupertinoApp
    return MaterialApp.router(
      routerConfig: AppRouter.appRouter,
      title: 'Post App',
      themeMode: appThemeMode,
      // 중요!
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.system, // system / light / dark
      theme: ThemeData(
        useMaterial3: true,
        // platform: TargetPlatform.iOS, // 👈 전체를 iOS 스타일로
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          // brightness: Brightness.dark,
        ),
      ),
      builder: (context, child) {
        // return child!;

        // return DialogQueueListener(child: child!); // 여기에 적용

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
