import '../../core/error/failures.dart';
import '../../domain/common/entities/route_info.dart';

///
///  BaseUiStatus – 상태 클래스
///
/// 	•	isLoading, error, navigateTo를 포함한 공통 상태 추상 클래스
///  프로바이더에서 사용할 공통 상태로 주로 위젯과 연관
///
///
mixin BaseUiStatus {
  bool? get isLoading;
  Failure? get error;
  RouteInfo? get navigateTo;
}

// abstract class BaseUiStatus {
//   final bool? isLoading;
//   final Failure? error;
//   final RouteInfo? navigateTo;
//
//   const BaseUiStatus({
//     this.isLoading,
//     this.error,
//     this.navigateTo,
//   });
// }