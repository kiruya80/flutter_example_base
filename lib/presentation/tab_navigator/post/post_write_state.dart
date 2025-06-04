import '../../../core/error/failures.dart';
import '../../../app/base/base_ui_status.dart';

class PostWriteState extends BaseUiStatus {
  @override
  final bool isLoading;
  @override
  final Failure? error;
  @override
  final String? navigateTo;

  PostWriteState({this.isLoading = false, this.error, this.navigateTo});

  PostWriteState copyWith({bool? isLoading, Failure? error, String? navigateTo}) {
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
