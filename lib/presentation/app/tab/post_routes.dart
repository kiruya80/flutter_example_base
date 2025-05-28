import 'package:go_router/go_router.dart';

import '../../tab_navigator/post/post_list_screen.dart';
import '../../tab_navigator/post/post_write_screen.dart';
import '../app_routes_info.dart';

///
/// post 모듈 전용 routes
///
final List<GoRoute> postTabRoutes = [
  GoRoute(
    name: AppTabRoutesInfo.posts.name,
    path: AppTabRoutesInfo.posts.path,
    pageBuilder: (context, state) => NoTransitionPage(child: PostListScreen()),
    routes: [
      GoRoute(
        name: AppTabRoutesInfo.postAdd.name,
        path: AppTabRoutesInfo.postAdd.path,
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
