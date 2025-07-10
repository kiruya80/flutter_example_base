import 'package:go_router/go_router.dart';

import '../../../main_scaffold_with_nav.dart';
import '../../../presentation/tab_navigator/post/post_list_screen.dart';
import '../../../presentation/tab_navigator/post/post_write_screen.dart';
import '../app_routes_info.dart';

///
/// post 모듈 전용 routes
///
final List<GoRoute> postTabRoutes = [
  GoRoute(
    name: AppRoutesInfo.tabPosts.name,
    path: AppRoutesInfo.tabPosts.path,
    // pageBuilder: (context, state) => NoTransitionPage(child: PostListScreen()),
    pageBuilder: (context, state) {
      final mainScaffoldState = context.findAncestorStateOfType<MainScaffoldWithNavState>();
      final controller =
          mainScaffoldState?.controllers[AppRoutesInfo.tabPosts.tabIndex]; // 게시글 탭 인덱스

      return NoTransitionPage(child: PostListScreen(mainNavScrollController: controller));
    },
    routes: [
      GoRoute(
        name: AppRoutesInfo.postAdd.name,
        path: AppRoutesInfo.postAdd.path,
        builder: (context, state) {
          // final id = state.pathParameters['id'];
          // final title = state.uri.queryParameters['title'] ?? '';
          return PostWriteScreen();
        },
        redirect: (context, state) {
          // final authService = ref.read(authServiceProvider);
          // final loggedIn = authService.isLoggedIn;
          // final isGoingToWrite = state.uri.toString().startsWith(RouteNames.writePost);
          //
          // if (!loggedIn && isGoingToWrite) {
          //   return '${RouteNames.login}?redirect=${state.uri.toString()}';
          // }

          return null;
        },
      ),
    ],
  ),
];
