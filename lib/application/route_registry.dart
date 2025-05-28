import '../domain/common/entities/route_info.dart';

class RouteRegistry {
  static final Set<String> _names = {};
  static final Set<String> _paths = {};

  static RouteInfo register(String name, String path, {String? prefixPath}) {
    /// 라우터 이름은 유니크
    if (_names.contains(name)) {
      throw ArgumentError('Route name "$name" is already registered. 라우터');
    }

    /// 라우터 경로는 중복 가능. 단, 같은 브랜치는 사용 불가
    if (_paths.contains(path)) {
      print('[경고] 경로 "$path" 는 이미 등록된 경로입니다. 같은 브랜치에서 중복되면 에러가 납니다.');
    }

    _names.add(name);
    _paths.add(path);
    return RouteInfo(name, path, prefixPath: prefixPath);
  }
}
