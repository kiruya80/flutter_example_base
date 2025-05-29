import 'package:go_router/go_router.dart';

import '../../../presentation/other/detail_screen.dart';
import '../../../presentation/tab_navigator/profile/profile_tab.dart';
import '../app_routes_info.dart';

///
/// profile 모듈 전용 routes
///
final List<GoRoute> profileTabRoutes = [
  GoRoute(
    name: AppRoutesInfo.tabProfile.name,
    path: AppRoutesInfo.tabProfile.path,
    pageBuilder: (context, state) => NoTransitionPage(child: ProfileTab()),
    routes: [
      GoRoute(
        name: AppRoutesInfo.profileDetail.name,
        path: AppRoutesInfo.profileDetail.path,
        builder: (context, state) {
          final id = state.pathParameters['id'];
          final title = state.uri.queryParameters['title'] ?? '';
          return DetailScreen(id: id, title: title);
        },
      ),
    ],
  ),
];
