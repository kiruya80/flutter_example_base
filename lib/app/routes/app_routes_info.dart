import 'package:flutter_example_base/domain/common/entities/route_info.dart';

import '../../core/route/route_registry.dart';

///
/// 라우터 네임과 패스를 같이
///
///
class AppRoutesInfo {
  /// 일반 라우터
  ///
  static final intro = RouteRegistry.register('intro', '/intro');
  static final splash = RouteRegistry.register('splash', '/splash');
  static final login = RouteRegistry.register('login', '/login');
  static final setting = RouteRegistry.register('setting', '/setting');

  /// 탭 라우터
  ///
  static final tabHome = RouteRegistry.register('home', '/home');
  static final tabPosts = RouteRegistry.register('posts', '/posts');
  static final tabSearch = RouteRegistry.register('search', '/search');
  static final tabProfile = RouteRegistry.register('profile', '/profile');

  /// 상세 라우터
  ///
  // 상대경로 예시: 홈 탭 안의 디테일 화면
  static final homeDetail = RouteRegistry.register('homeDetail', 'detail');

  static final postAdd = RouteRegistry.register('postAdd', 'postAdd');

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
  static String searchDetailPath({required String id, Map<String, String> queryParams = const {}}) {
    return searchDetail.fullPath(pathParams: {'id': id}, queryParams: queryParams);
  }

  /// 예: /search/detail/123?tab=review&sort=asc
  static String searchDetailFullPath({required String id, Map<String, String> query = const {}}) {
    final path = searchDetail.pathWithParams({'id': id});
    final queryStr = searchDetail.queryString(query);
    return '${tabSearch.path}/$path$queryStr';
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
