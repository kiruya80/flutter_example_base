import '../../core/error/failures.dart';
import '../../domain/common/entities/route_info.dart';

///
///  BaseUiStatus – 상태 클래스
///
/// 	•	isLoading, error, navigateTo를 포함한 공통 상태 추상 클래스
///
///
abstract class BaseUiStatus {
  final bool? isLoading;
  final Failure? error;
  final RouteInfo? navigateTo;

  const BaseUiStatus({
    this.isLoading,
    this.error,
    this.navigateTo,
  });

  // bool get isLoading;
  // Failure? get error;
  // RouteInfo? get navigateTo;
}
