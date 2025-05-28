import 'package:flutter/cupertino.dart';
import 'package:flutter_example_base/presentation/app/tab/tab_router.dart';
import 'package:go_router/go_router.dart';

import '../../core/state/base_state.dart';
import '../../my_app.dart';
import '../auth/login_screen.dart';
import '../intro/intro_screen.dart';
import '../settting/setting_screen.dart';
import 'app_routes_info.dart';
import 'my_route_observer.dart';
import '../splash/splash_screen.dart';

class AppRouter {
  /// 🔐 navigator keys (탭 스택 유지용)
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final appRouter = GoRouter(
    initialLocation: AppRoutesInfo.intro.path,
    navigatorKey: _rootNavigatorKey,
    observers: [
      widgetRouteObserver, // 위젯에 정의된 옵져버
      MyRouteObserver(), // 👈 사용자 정의 옵저버
    ],
    routes: [
      GoRoute(
        name: AppRoutesInfo.intro.name,
        path: AppRoutesInfo.intro.path,
        builder: (context, state) => const IntroPage(),
      ),
      GoRoute(
        name: AppRoutesInfo.splash.name,
        path: AppRoutesInfo.splash.path,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: AppRoutesInfo.login.name,
        path: AppRoutesInfo.login.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: AppRoutesInfo.setting.name,
        path: AppRoutesInfo.setting.path,
        builder: (context, state) => const SettingScreen(),
      ),
      /// tab
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(shell: navigationShell);
        },
        branches: tabBranches,
      ),
    ],
  );
}
