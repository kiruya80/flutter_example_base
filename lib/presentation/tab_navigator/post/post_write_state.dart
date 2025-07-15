import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/failures.dart';
import '../../../domain/common/entities/route_info.dart';
import '../../../shared/base/base_ui_status.dart';

part 'post_write_state.freezed.dart';
part 'post_write_state.g.dart';

@freezed
abstract class PostWriteState with _$PostWriteState implements BaseUiStatus {
  const factory PostWriteState({bool? isLoading, Failure? error, RouteInfo? navigateTo}) =
      _PostWriteState;

  factory PostWriteState.initial() =>
      const PostWriteState(isLoading: false, error: null, navigateTo: null);

  factory PostWriteState.fromJson(Map<String, dynamic> json) => _$PostWriteStateFromJson(json);
}

// class PostWriteState extends BaseUiStatus {
//   const PostWriteState({
//     super.isLoading,
//     super.error,
//     super.navigateTo,
//   });
//
//   PostWriteState copyWith({
//     bool? isLoading,
//     Failure? error,
//     RouteInfo? navigateTo,
//   }) {
//     return PostWriteState(
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//       navigateTo: navigateTo ?? this.navigateTo,
//     );
//   }
//
//   factory PostWriteState.initial() =>
//       PostWriteState(isLoading: false, error: null);
// }
