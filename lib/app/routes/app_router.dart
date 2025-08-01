import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../my_app.dart';
import '../../shared/state/base_state.dart';
import '../../presentation/auth/login_screen.dart';
import '../../presentation/intro/intro_screen.dart';
import '../../presentation/settting/setting_screen.dart';
import 'app_routes_info.dart';
import 'my_route_observer.dart';
import '../../presentation/splash/splash_screen.dart';
import 'tab/tab_router.dart';

class AppRouter {
  /// 🔐 navigator keys (탭 스택 유지용)
  // static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> globalNavigatorKey =
      GlobalKey<NavigatorState>();

  static final appRouter = GoRouter(
    initialLocation: AppRoutesInfo.intro.path,
    navigatorKey: globalNavigatorKey,
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
        branches: TabRouter.tabBranches,
      ),
    ],
  );
}
