import 'package:go_router/go_router.dart';

import '../../../presentation/other/detail_screen.dart';
import '../../../presentation/other/home_card_screen.dart';
import '../../../presentation/tab_navigator/home/home_tab.dart';
import '../app_routes_info.dart';

///
/// home 모듈 전용 routes
///
final List<GoRoute> homeRoutes = [
  // GoRoute(
  //     name: AppRoutes.home.name,
  //     path: AppRoutes.home.path,
  //     builder: (context, state) => const HomeScreen()),
  // GoRoute(
  //   name: AppRoutes.detail.name,
  //   path: AppRoutes.detail.path,
  //   builder: (context, state) {
  //     final id = state.pathParameters['id']!;
  //     return DetailScreen(id: id);
  //   },
  // ),
];

///
/// 홈탭
/// 	•	GoRoute 내부의 path: 'xxx' 는 상대경로 ,
/// 	•	/ 없이 쓰면 상위 경로와 자동 조합
/// 	•	/ 붙이면 루트 기준 절대 경로로 동작해서 브랜치 밖으로 이탈할 수 있음
///   예) '/detail' 실제 라우팅 결과: /detail  ❌ 절대경로로 인식되어 따로 떨어짐
///
final List<GoRoute> homeTabRoutes = [
  GoRoute(
    name: AppRoutesInfo.tabHome.name,
    path: AppRoutesInfo.tabHome.path,

    /// '/xxx'는 절대경로
    pageBuilder: (context, state) => NoTransitionPage(child: HomeTab()),
    routes: [
      // GoRoute(
      //   name: AppRoutesInfo.detail.name,
      //   path: AppRoutesInfo.detail.path,
      //   builder: (context, state) => DetailScreen(title: 'home Detail'),
      // ),

      /// 'detail'   실제 라우팅 결과:  /home/detail      ✅ 상대경로로 이어짐
      /// 'xxx' 는 상대경로 ,'/detail'  절대경로 하면 안 됨
      GoRoute(
        name: AppRoutesInfo.homeDetail.name,
        path: AppRoutesInfo.homeDetail.path,
        builder: (context, state) {
          // final id = state.pathParameters['id'];
          // final title = state.uri.queryParameters['title'] ?? '';
          return DetailScreen();
          // return DetailScreen(title: 'home Detail');
        },
      ),
      GoRoute(
        name: AppRoutesInfo.homeCard.name,
        path: AppRoutesInfo.homeCard.path,
        builder: (context, state) {
          // final id = state.pathParameters['id'];
          // final title = state.uri.queryParameters['title'] ?? '';
          return HomeCardScreen();
          // return DetailScreen(title: 'home Detail');
        },
      ),
    ],
  ),
];
