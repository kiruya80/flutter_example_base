import '../domain/entities/route_info.dart';

class RouteRegistry {
  static final Set<String> _names = {};
  static final Set<String> _paths = {};

  static RouteInfo register(String name, String path) {
    if (_names.contains(name)) {
      throw ArgumentError('Route name "$name" is already registered.');
    }
    if (_paths.contains(path)) {
      print('[경고] 경로 "$path" 는 이미 등록된 경로입니다. 같은 브랜치에서 중복되면 에러가 납니다.');
    }

    _names.add(name);
    _paths.add(path);
    return RouteInfo(name, path);
  }
}
