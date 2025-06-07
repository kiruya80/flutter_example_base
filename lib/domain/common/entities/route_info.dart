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
  final Map<String, dynamic>? pathParams;
  final Map<String, dynamic>? queryParams;

  const RouteInfo(
    this.name,
    this.path, {
    this.prefixPath,
    this.pathParams,
    this.queryParams,
  });
}
