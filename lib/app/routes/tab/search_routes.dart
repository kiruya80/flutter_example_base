import 'package:go_router/go_router.dart';

import '../../../main_scaffold_with_nav.dart';
import '../../../presentation/other/detail_screen.dart';
import '../../../presentation/tab_navigator/search/search_tab.dart';
import '../app_routes_info.dart';

///
/// search 모듈 전용 routes
///
final List<GoRoute> searchTabRoutes = [
  GoRoute(
    name: AppRoutesInfo.tabSearch.name,
    path: AppRoutesInfo.tabSearch.path,
    // pageBuilder: (context, state) => NoTransitionPage(child: SearchTab()),
    pageBuilder: (context, state) {
      final mainScaffoldState = context.findAncestorStateOfType<MainScaffoldWithNavState>();
      final controller =
          mainScaffoldState?.controllers[AppRoutesInfo.tabSearch.tabIndex]; // 게시글 탭 인덱스

      return NoTransitionPage(child: SearchTab(mainNavScrollController: controller));
    },
    routes: [
      GoRoute(
        name: AppRoutesInfo.searchDetail.name,
        path: AppRoutesInfo.searchDetail.path,
        builder: (context, state) {
          final id = state.pathParameters['id'];
          final title = state.uri.queryParameters['title'] ?? '';
          return DetailScreen(id: id, title: title);
        },
      ),
    ],
  ),
];
