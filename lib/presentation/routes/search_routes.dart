import 'package:go_router/go_router.dart';

import 'package:flutter_example_base/presentation/screen/move/home_screen.dart';

import '../screen/detail_screen.dart';
import '../screen/tab_navigator/home_tab.dart';
import '../screen/tab_navigator/search_tab.dart';
import 'app_routes.dart';

///
/// search 모듈 전용 routes
///
// final List<GoRoute> searchRoutes = [
//   GoRoute(
//       name: AppRoutes.home.name,
//       path: AppRoutes.home.path,
//       builder: (context, state) => const HomeScreen()),
//   GoRoute(
//     name: AppRoutes.detail.name,
//     path: AppRoutes.detail.path,
//     builder: (context, state) {
//       final id = state.pathParameters['id']!;
//       return DetailScreen(id: id);
//     },
//   ),
// ];

final List<GoRoute> searchTabRoutes = [
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
          return DetailScreen(id: id, title:title);
        },
      ),
    ],
  ),
];
