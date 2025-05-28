import 'package:go_router/go_router.dart';

import '../../other/screens/detail_screen.dart';
import '../../tab_navigator/profile/profile_tab.dart';
import '../app_routes_info.dart';

///
/// profile 모듈 전용 routes
///
final List<GoRoute> profileTabRoutes = [
  GoRoute(
    name: AppTabRoutesInfo.profile.name,
    path: AppTabRoutesInfo.profile.path,
    pageBuilder: (context, state) => NoTransitionPage(child: ProfileTab()),
    routes: [
      GoRoute(
        name: AppTabRoutesInfo.profileDetail.name,
        path: AppTabRoutesInfo.profileDetail.path,
        builder: (context, state) {
          final id = state.pathParameters['id'];
          final title = state.uri.queryParameters['title'] ?? '';
          return DetailScreen(id: id, title: title);
        },
      ),
    ],
  ),
];
