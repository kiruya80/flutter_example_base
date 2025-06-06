import '../../../core/error/failures.dart';
import '../../../app/base/base_ui_status.dart';
import '../../../domain/common/entities/route_info.dart';

class PostWriteState extends BaseUiStatus {
  @override
  final bool isLoading;
  @override
  final Failure? error;
  @override
  final RouteInfo? navigateTo;

  PostWriteState({this.isLoading = false, this.error, this.navigateTo});

  PostWriteState copyWith({bool? isLoading, Failure? error, RouteInfo? navigateTo}) {
    return PostWriteState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      navigateTo: navigateTo,
    );
  }

  factory PostWriteState.initial() => PostWriteState(isLoading: false, error: null);

  // PostWriteState({super.isLoading, super.error});
  //
  // factory PostWriteState.initial() => PostWriteState(isLoading: false);
  //
  // PostWriteState copyWith({bool? isLoading, Failure? error}) {
  //   return PostWriteState(isLoading: isLoading ?? this.isLoading, error: error ?? this.error);
  // }
}
