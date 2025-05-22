import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../my_app.dart';
import '../screen/detail_screen.dart';
import '../screen/tab_navigator/home_tab.dart';
import '../screen/tab_navigator/profile_tab.dart';
import '../screen/tab_navigator/search_tab.dart';
import 'route_list.dart';
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

///
/// GoRouter 설정 샘플
///

// final GoRouter defaultRouter = GoRouter(
//   routes: [
//     GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
//
//     /// Path Parameter (/details/:id)
//     GoRoute(
//       name: 'details',
//       path: '/details/:id',
//       builder: (context, state) {
//         final id = state.pathParameters['id'];
//         return DetailPathScreen(id: id);
//       },
//     ),
//
//     /// Query Parameter (/search?keyword=flutter)
//     GoRoute(
//       name: 'search',
//       path: '/search',
//       builder: (context, state) {
//         final keyword = state.uri.queryParameters['keyword'] ?? '';
//         return SearchQueryScreen(keyword: keyword);
//       },
//     ),
//   ],
// );
//
// /// Auth Redirect (로그인 리다이렉트)
// final GoRouter authRouter = GoRouter(
//   redirect: (context, state) {
//     final isLoggedIn = false; // 여기에 실제 로그인 상태 넣기
//     final isGoingToLogin = state.fullPath == '/login';
//
//     if (!isLoggedIn && !isGoingToLogin) {
//       return '/login'; // 로그인 페이지로 리디렉션
//     }
//     return null;
//   },
//   routes: [
//     GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
//     GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
//     GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
//   ],
// );

/// 🔐 navigator keys (탭 스택 유지용)
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

///
/// ShellRoute 내부에서 /home, /home/detail을 직접 GoRoute로 구성하면,
/// 	•	실제로는 Navigator가 하나라서
/// 	•	홈 → 디테일 → 프로필 → 홈 이동 시, 홈 초기 화면으로 되돌아감
/// (→ 디테일 스택이 사라짐)
///
final GoRouter shellRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      // navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
            path: '/home',
            pageBuilder: (context, state) => NoTransitionPage(
                  child: HomeScreen(),
                ),
            routes: [
              GoRoute(
                path: 'detail',
                builder: (context, state) => DetailScreen(title: 'home Detail'),
              ),
            ]),
        GoRoute(
            path: '/search',
            pageBuilder: (context, state) {
              // final keyword = state.uri.queryParameters['keyword'] ?? '';
              // return SearchQueryScreen(keyword: keyword);
              return NoTransitionPage(
                child: SearchQueryScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'detail',
                builder: (context, state) => DetailScreen(title: 'search Detail'),
              ),
            ]),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ProfileScreen(),
          ),
          routes: [
            GoRoute(
              path: 'detail',
              builder: (context, state) => DetailScreen(title: 'Profile Detail'),
            ),
          ],
        ),
      ],
    ),
  ],
);

final GoRouter shellTabRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      // navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => NoTransitionPage(
            child: HomeTab(),
          ),
        ),
        GoRoute(
          path: '/search',
          pageBuilder: (context, state) {
            // final keyword = state.uri.queryParameters['keyword'] ?? '';
            // return SearchQueryScreen(keyword: keyword);
            return NoTransitionPage(
              child: SearchTab(),
            );
          },
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ProfileTab(),
          ),
        ),
      ],
    ),
  ],
);
