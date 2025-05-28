import 'package:go_router/go_router.dart';

import '../auth/login_screen.dart';
import '../intro/intro_screen.dart';
import '../post/post_list_screen.dart';
import '../post/post_write_screen.dart';
import '../splash/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/intro',
  routes: [
    GoRoute(
      path: '/intro',
      builder: (context, state) => const IntroPage(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/posts',
      builder: (context, state) => const PostListPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/write',
      builder: (context, state) => const PostWritePage(),
    ),
  ],
);
