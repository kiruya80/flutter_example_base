import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/base_state.dart';
import '../../../../my_app.dart';
import '../../screens/setting_screen.dart';
import '../../../app/app_routes.dart';
import '../auth_routes.dart';
import '../home_routes.dart';
import '../my_route_observer.dart';
import '../profile_routes.dart';
import '../search_routes.dart';

class AppRouter {
  /// 🔐 navigator keys (탭 스택 유지용)
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  ///
  /// 바텀 네비게이션
  /// 각 탭은 히스토리 유지 가능 StatefulShellRoute
  ///
  static final GoRouter shellTabRouter = GoRouter(
    initialLocation: AppTabRoutes.home.path,
    navigatorKey: _rootNavigatorKey,
    observers: [
      widgetRouteObserver, // 위젯에 정의된 옵져버
      MyRouteObserver(), // 👈 사용자 정의 옵저버
    ],
    routes: [
      GoRoute(
        name: AppRoutes.setting.name,
        path: AppRoutes.setting.path,
        builder: (context, state) => SettingScreen(),
      ),
      ...authRoutes,

      /// 홈
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(shell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: homeTabRoutes),
          StatefulShellBranch(routes: profileTabRoutes),
          StatefulShellBranch(routes: searchTabRoutes),
        ],

        /// default
        // branches: [
        //   StatefulShellBranch(
        //     routes: [
        //       GoRoute(
        //         path: '/home',
        //         builder: (context, state) => HomeTab(),
        //         routes: [
        //           GoRoute(
        //             path: 'detail',
        //             builder: (context, state) => DetailScreen(),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        //   StatefulShellBranch(
        //     routes: [
        //       GoRoute(
        //         path: '/search',
        //         builder: (context, state) => SearchTab(),
        //       ),
        //     ],
        //   ),
        //   StatefulShellBranch(
        //     routes: [
        //       GoRoute(
        //         path: '/profile',
        //         builder: (context, state) => ProfileTab(),
        //       ),
        //     ],
        //   ),
        // ],
      ),
    ],
  );
}
