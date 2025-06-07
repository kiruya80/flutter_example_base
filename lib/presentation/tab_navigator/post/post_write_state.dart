import '../../../core/error/failures.dart';
import '../../../domain/common/entities/route_info.dart';
import '../../../shared/base/base_ui_status.dart';

class PostWriteState extends BaseUiStatus {
  const PostWriteState({
    super.isLoading,
    super.error,
    super.navigateTo,
  });

  PostWriteState copyWith({
    bool? isLoading,
    Failure? error,
    RouteInfo? navigateTo,
  }) {
    return PostWriteState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      navigateTo: navigateTo ?? this.navigateTo,
    );
  }

  factory PostWriteState.initial() =>
      PostWriteState(isLoading: false, error: null);
}
