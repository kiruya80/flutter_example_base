import 'package:go_router/go_router.dart';

import 'home_routes.dart';
import 'post_routes.dart';
import 'profile_routes.dart';
import 'search_routes.dart';

///
/// 탭 라우터
///
class TabRouter {
  /// 홈화면 탭
  static final List<StatefulShellBranch> tabBranches = [
    StatefulShellBranch(routes: homeTabRoutes),
    StatefulShellBranch(routes: postTabRoutes),
    StatefulShellBranch(routes: profileTabRoutes),
    StatefulShellBranch(routes: searchTabRoutes),
  ];
//
// final StatefulShellRoute statefulShellRoute = StatefulShellRoute.indexedStack(
//   builder: (context, state, navigationShell) {
//     return ScaffoldWithNavBar(shell: navigationShell);
//   },
//   branches: tabBranches,
//
//   /// default
//   // branches: [
//   //   StatefulShellBranch(
//   //     routes: [
//   //       GoRoute(
//   //         path: '/home',
//   //         builder: (context, state) => HomeTab(),
//   //         routes: [
//   //           GoRoute(
//   //             path: 'detail',
//   //             builder: (context, state) => DetailScreen(),
//   //           ),
//   //         ],
//   //       ),
//   //     ],
//   //   ),
//   //   StatefulShellBranch(
//   //     routes: [
//   //       GoRoute(
//   //         path: '/search',
//   //         builder: (context, state) => SearchTab(),
//   //       ),
//   //     ],
//   //   ),
//   //   StatefulShellBranch(
//   //     routes: [
//   //       GoRoute(
//   //         path: '/profile',
//   //         builder: (context, state) => ProfileTab(),
//   //       ),
//   //     ],
//   //   ),
//   // ],
// );
}
