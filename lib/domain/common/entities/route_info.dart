import 'package:freezed_annotation/freezed_annotation.dart';

///
/// 라우터  기본 정보 클래스
/// ㄴ 라우터 이름 / 라우터 경로
///
/// 라우터 이동에 필요한 경로
///

part 'route_info.freezed.dart';
part 'route_info.g.dart';

@freezed
abstract class RouteInfo with _$RouteInfo {
  const factory RouteInfo({
    required String name,
    required String path,
    String? prefixPath,
    Map<String, dynamic>? pathParams,
    Map<String, dynamic>? queryParams,
  }) = _RouteInfo;

  factory RouteInfo.fromJson(Map<String, dynamic> json) => _$RouteInfoFromJson(json);
}
// class RouteInfo {
//   final String name;
//   final String path;
//   final String? prefixPath; // 탭 경로 등 앞에 붙일 경로
//   final Map<String, dynamic>? pathParams;
//   final Map<String, dynamic>? queryParams;
//
//   const RouteInfo(
//     this.name,
//     this.path, {
//     this.prefixPath,
//     this.pathParams,
//     this.queryParams,
//   });
// }
