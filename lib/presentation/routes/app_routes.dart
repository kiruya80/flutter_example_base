
import '../../domain/entities/route_info.dart';
import '../../utils/route_registry.dart';

///
/// 라우터 네임과 패스를 같이
///
///
class RouteNames {
  static const String home = 'home';
  static const String profile = 'profile';
  static const String login = 'login';
}

class AppRoutes {
  static const login = RouteInfo('login', '/login');
  static const home = RouteInfo('home', '/home');
  static const profile = RouteInfo('profile', '/profile');
  static const detail = RouteInfo('detail', '/detail/:id');
}

class AppTabRoutes {
  // static const home = RouteInfo('home', '/home');
  // static const search = RouteInfo('search', '/search');
  // static const profile = RouteInfo('profile', '/profile');
  // static const detail = RouteInfo('detail', 'detail');

  static final home = RouteRegistry.register('home', '/home');
  static final search = RouteRegistry.register('search', '/search');
  static final profile = RouteRegistry.register('profile', '/profile');

  // 상대 경로 예시
  static final detail = RouteRegistry.register('homeDetail', 'detail');

  /// context.go(AppTabRoutes.detailPath('123'));
  ///
  /// context.goNamed(
  ///   AppTabRoutes.detail.name,
  ///   queryParameters: {'id': '123'},
  /// );
  static String detailPath(String id) => '${home.path}/${detail.path}?id=$id';
}

