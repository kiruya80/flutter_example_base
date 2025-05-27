import '../../domain/entities/route_info.dart';
import '../../utils/route_registry.dart';

///
/// 라우터 네임과 패스를 같이
///
///
// class RouteNames {
//   static const String home = 'home';
//   static const String profile = 'profile';
//   static const String login = 'login';
// }

class AppRoutes {
  static const login = RouteInfo('login', '/login');
  // static const home = RouteInfo('home', '/home');
  // static const profile = RouteInfo('profile', '/profile');
  // static const detail = RouteInfo('detail', '/detail/:id');

  static const setting = RouteInfo('setting', '/setting');
}

class AppTabRoutes {
  // static const home = RouteInfo('home', '/home');
  // static const search = RouteInfo('search', '/search');
  // static const profile = RouteInfo('profile', '/profile');
  // static const detail = RouteInfo('detail', 'detail');

  static final home = RouteRegistry.register('home', '/home');
  static final search = RouteRegistry.register('search', '/search');
  static final profile = RouteRegistry.register('profile', '/profile');

  // 상대경로 예시: 홈 탭 안의 디테일 화면
  static final homeDetail = RouteRegistry.register('homeDetail', 'detail');
  static final profileDetail = RouteRegistry.register('profileDetail', 'detail/:id');
  // 파라미터가 필요한 경로 예시
  static final searchDetail = RouteRegistry.register('searchDetail', 'detail/:id');

  static final homeCard = RouteRegistry.register('homeCard', 'homeCard');

  ///
  /// 헬퍼 예시 context.go 를 사용할 때
  /// context.goNamed(
  ///   AppTabRoutes.detail.name,
  ///   queryParameters: {'id': '123'},
  /// );
  /// 예: /search/detail/123
  /// context.go(AppTabRoutes.searchDetailPath('123'));
  /// context.go(AppTabRoutes.searchDetailFullPath(
  ///   id: '123',
  ///   query: {'tab': 'review', 'sort': 'asc'},
  /// ));
  ///  👉 /search/detail/123?tab=review&sort=asc
  ///
  // static String searchDetailPath(String id) =>'${search.path}/${searchDetail.pathWithParams({'id': id})}';
  // static String searchDetailPath(String id) => '${home.path}/${detail.path}?id=$id';
  /// go() 전용 경로 만들기
  static String searchDetailPath({
    required String id,
    Map<String, String> queryParams = const {},
  }) {
    return searchDetail.fullPath(
      pathParams: {'id': id},
      queryParams: queryParams,
    );
  }

  /// 예: /search/detail/123?tab=review&sort=asc
  static String searchDetailFullPath({
    required String id,
    Map<String, String> query = const {},
  }) {
    final path = searchDetail.pathWithParams({'id': id});
    final queryStr = searchDetail.queryString(query);
    return '${search.path}/$path$queryStr';
  }

  // static String profileDetailPath({
  //   required String id,
  //   Map<String, String> queryParams = const {},
  // }) {
  //   return profileDetail.fullPath(
  //     pathParams: {'id': id},
  //     queryParams: queryParams,
  //   );
  // }
}
