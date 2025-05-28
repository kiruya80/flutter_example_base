import 'package:go_router/go_router.dart';

import '../../other/screens/detail_screen.dart';
import '../../tab_navigator/search/search_tab.dart';
import '../app_routes_info.dart';

///
/// search 모듈 전용 routes
///
final List<GoRoute> searchTabRoutes = [
  GoRoute(
    name: AppTabRoutesInfo.search.name,
    path: AppTabRoutesInfo.search.path,
    pageBuilder: (context, state) => NoTransitionPage(child: SearchTab()),
    routes: [
      GoRoute(
        name: AppTabRoutesInfo.searchDetail.name,
        path: AppTabRoutesInfo.searchDetail.path,
        builder: (context, state) {
          final id = state.pathParameters['id'];
          final title = state.uri.queryParameters['title'] ?? '';
          return DetailScreen(id: id, title: title);
        },
      ),
    ],
  ),
];
