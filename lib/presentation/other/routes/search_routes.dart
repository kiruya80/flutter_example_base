import 'package:go_router/go_router.dart';

import '../screens/detail_screen.dart';
import '../screens/tab_navigator/search_tab.dart';
import '../../app/app_routes.dart';

///
/// search 모듈 전용 routes
///
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
          return DetailScreen(id: id, title: title);
        },
      ),
    ],
  ),
];
