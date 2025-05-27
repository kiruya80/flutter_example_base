///
/// 라우터  기본 정보 클래스
/// ㄴ 라우터 이름 / 라우터 경로
///
/// 라우터 이동에 필요한 경로
///
class RouteInfo {
  final String name;
  final String path;
  final String? prefixPath; // 탭 경로 등 앞에 붙일 경로

  const RouteInfo(this.name, this.path, {this.prefixPath});
}

extension RouteInfoHelper on RouteInfo {
  /// 예: /home/detail/123
  String pathWithParams(Map<String, String> pathParams) {
    var finalPath = path;
    pathParams.forEach((key, value) {
      finalPath = finalPath.replaceAll(':$key', value);
    });
    return finalPath;
  }

  /// 예: ?id=123&type=a
  String queryString(Map<String, String> queryParams) {
    if (queryParams.isEmpty) return '';
    return '?${Uri(queryParameters: queryParams).query}';
  }

  /// 예: /home/detail/123?id=aaa
  // String fullPath({
  //   Map<String, String> pathParams = const {},
  //   Map<String, String> queryParams = const {},
  // }) {
  //   final base = pathWithParams(pathParams);
  //   final query = queryString(queryParams);
  //   return '$base$query';
  // }

  /// 전체 경로 반환 (prefixPath 포함)
  String fullPath({
    Map<String, String> pathParams = const {},
    Map<String, String> queryParams = const {},
  }) {
    final bodyPath = pathWithParams(pathParams);
    final query = queryString(queryParams);
    final prefix = prefixPath != null ? '$prefixPath/' : '';
    return '$prefix$bodyPath$query';
  }
}