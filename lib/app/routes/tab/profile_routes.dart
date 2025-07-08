import 'package:go_router/go_router.dart';

import '../../../main_scaffold_with_nav.dart';
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
    // pageBuilder: (context, state) => NoTransitionPage(child: ProfileTab()),
    pageBuilder: (context, state) {
      final mainScaffoldState = context.findAncestorStateOfType<MainScaffoldWithNavState>();
      final controller = mainScaffoldState?.controllers[AppRoutesInfo.tabProfile.tabIndex]; // 게시글 탭 인덱스

      return NoTransitionPage(
        child: ProfileTab(mainNavScrollController: controller!),
      );
    },
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
