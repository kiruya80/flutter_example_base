import 'package:go_router/go_router.dart';

import 'package:flutter_example_base/presentation/screen/move/home_screen.dart';

import '../screen/detail_screen.dart';
import '../screen/tab_navigator/home_tab.dart';
import '../screen/tab_navigator/profile_tab.dart';
import 'app_routes.dart';

///
/// profile 모듈 전용 routes
///
final List<GoRoute> profileTabRoutes = [
  GoRoute(
    name: AppTabRoutes.profile.name,
    path: AppTabRoutes.profile.path,
    pageBuilder: (context, state) => NoTransitionPage(child: ProfileTab()),
    routes: [
      GoRoute(
        name: AppTabRoutes.profileDetail.name,
        path: AppTabRoutes.profileDetail.path,
        builder: (context, state) {
          final id = state.pathParameters['id'];
          final title = state.uri.queryParameters['title'] ?? '';
          return DetailScreen(id: id, title: title);
        },
      ),
    ],
  ),
];
