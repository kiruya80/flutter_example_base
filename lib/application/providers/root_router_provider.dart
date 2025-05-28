import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/other/screens/move/login_screen.dart';
import '../../presentation/other/screens/post_list_screen.dart';
import '../router/route_names.dart';
import 'auth_provider.dart';

final rootRouterProvider = Provider<GoRouter>((ref) {
  final authService = ref.read(authServiceProvider);

  return GoRouter(
    initialLocation: '/posts',
    redirect: (context, state) {
      final loggedIn = authService.isLoggedIn;
      final isGoingToWrite = state.uri.toString().startsWith(RouteNames.writePost);

      if (!loggedIn && isGoingToWrite) {
        return '${RouteNames.login}?redirect=${state.uri.toString()}';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, __) => '/posts',
      ),
      GoRoute(
        name: 'login',
        path: RouteNames.login,
        builder: (context, state) {
          final redirectPath = state.uri.queryParameters['redirect'];
          return LoginScreen(redirectPath: redirectPath);
        },
      ),
      GoRoute(
        name: 'postList',
        path: RouteNames.posts,
        builder: (context, state) => const PostListScreen(),
        routes: [
          // GoRoute(
          //   name: 'postForm',
          //   path: 'write',
          //   builder: (context, state) => const PostFormScreen(),
          //   redirect: (context, state) {
          //     if (!authService.isLoggedIn) {
          //       return '/login?redirect=${state.fullPath}';
          //     }
          //     return null;
          //   },
          // ),
        ],
      ),
    ],
  );
});
