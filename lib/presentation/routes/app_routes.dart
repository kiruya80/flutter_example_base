
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
  static const login = _RouteInfo('login', '/login');
  static const home = _RouteInfo('home', '/home');
  static const profile = _RouteInfo('profile', '/profile');
  static const detail = _RouteInfo('detail', '/detail/:id');
}

class _RouteInfo {
  final String name;
  final String path;
  const _RouteInfo(this.name, this.path);
}