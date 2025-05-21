// lib/presentation/routes/app_router.dart
import 'package:go_router/go_router.dart';
import 'route_list.dart'; // 또는 home_routes.dart + auth_routes.dart
import 'package:flutter_example_base/presentation/screen/login_screen.dart';
import 'package:flutter_example_base/presentation/screen/profile_screen.dart';
import 'package:flutter_example_base/presentation/screen/settings_screen.dart';
import 'package:flutter_example_base/presentation/screen/detail_path_screen.dart';
import 'package:flutter_example_base/presentation/screen/home_screen.dart';
import 'package:flutter_example_base/presentation/screen/search_query_screen.dart';

///
/// GoRouter 객체 최종 정의
///
final router = GoRouter(routes: allRoutes);

/// GoRouter 설정
final GoRouter defaultRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

    /// Path Parameter (/details/:id)
    GoRoute(
      name: 'details',
      path: '/details/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return DetailPathScreen(id: id);
      },
    ),

    /// Query Parameter (/search?keyword=flutter)
    GoRoute(
      name: 'search',
      path: '/search',
      builder: (context, state) {
        final keyword = state.uri.queryParameters['keyword'] ?? '';
        return SearchQueryScreen(keyword: keyword);
      },
    ),
  ],
);

/// Auth Redirect (로그인 리다이렉트)
final GoRouter authRouter = GoRouter(
  redirect: (context, state) {
    final isLoggedIn = false; // 여기에 실제 로그인 상태 넣기
    final isGoingToLogin = state.fullPath == '/login';

    if (!isLoggedIn && !isGoingToLogin) {
      return '/login'; // 로그인 페이지로 리디렉션
    }
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
  ],
);

/// ShellRoute (하단 탭 바 구조)
final GoRouter shellRouter = GoRouter(
  routes: [
    ShellRoute(
      // builder: (context, state, child) => ScaffoldWithNavBar(child: child),
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
      ],
    ),
  ],
);
