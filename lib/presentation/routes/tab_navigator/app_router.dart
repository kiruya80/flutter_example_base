import 'package:flutter/material.dart';
import 'package:flutter_example_base/utils/print_log.dart';
import 'package:go_router/go_router.dart';

import '../../../my_app.dart';
import '../../screen/detail_screen.dart';
import '../../screen/tab_navigator/home_tab.dart';
import '../../screen/tab_navigator/profile_tab.dart';
import '../../screen/tab_navigator/search_tab.dart';
import '../app_routes.dart';
import '../home_routes.dart';
import '../profile_routes.dart';
import '../search_routes.dart';

/// 🔐 navigator keys (탭 스택 유지용)
final _rootNavigatorKey = GlobalKey<NavigatorState>();

///
/// 바텀 네비게이션
/// 각 탭은 히스토리 유지 가능 StatefulShellRoute
///
final GoRouter shellTabRouter = GoRouter(
  initialLocation: AppTabRoutes.home.path,
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          // routes: homeTabRoutes
          routes: [
            GoRoute(
              name: AppTabRoutes.home.name,
              path: AppTabRoutes.home.path,
              pageBuilder: (context, state) => NoTransitionPage(child: HomeTab()),
              routes: [
                // GoRoute(
                //   name: AppTabRoutes.detail.name,
                //   path: AppTabRoutes.detail.path,
                //   builder: (context, state) => DetailScreen(title: 'home Detail'),
                // ),
                /// path parameter 사용하기
                GoRoute(
                  name: AppTabRoutes.homeDetail.name,
                  path: '${AppTabRoutes.homeDetail.path}/:id',
                  builder: (context, state) {
                    // final id = state.pathParameters['id'];
                    // final title = state.uri.queryParameters['title'] ?? '';
                    // QcLog.d('detail === $id , $title');
                    // return DetailScreen(id: id, title: title,);
                    return DetailScreen(title: 'home Detail');
                  },
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          // routes: searchTabRoutes
          routes: [
            GoRoute(
              name: AppTabRoutes.search.name,
              path: AppTabRoutes.search.path,
              pageBuilder: (context, state) => NoTransitionPage(child: SearchTab()),
              routes: [
                GoRoute(
                  name: AppTabRoutes.searchDetail.name,
                  path: AppTabRoutes.searchDetail.path,
                  builder: (context, state) {
                    final id = state.pathParameters['id'];
                    final title = state.uri.queryParameters['title'] ?? '';
                    QcLog.d('detail === $id , $title');
                    return DetailScreen(id: id, title: title,);
                    return DetailScreen(title: 'search Detail');
                  },
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          // routes: profileTabRoutes
          routes: [
            GoRoute(
              name: AppTabRoutes.profile.name,
              path: AppTabRoutes.profile.path,
              pageBuilder: (context, state) => NoTransitionPage(child: ProfileTab()),
              routes: [
                GoRoute(
                  name: AppTabRoutes.profileDetail.name,
                  path: AppTabRoutes.profileDetail.path,
                  builder: (context, state) => DetailScreen(title: 'profile Detail'),
                ),
              ],
            ),
          ],
        ),
      ],
      ///
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
