import '../../core/error/failures.dart';

abstract class BaseUiStatus {
  // final bool? isLoading;
  // final Failure? error;
  bool get isLoading;
  Failure? get error;
  String? get navigateTo;

  // const ProviderBaseState({this.isLoading, this.error});
}
// class BaseUiStatus {
//   final bool isLoading;
//   final Failure? error;
//   final String? navigateTo;
//
//   const BaseUiStatus({
//     this.isLoading = false,
//     this.error,
//     this.navigateTo,
//   });
// }