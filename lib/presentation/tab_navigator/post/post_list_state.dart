import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/failures.dart';
import '../../../domain/common/entities/route_info.dart';
import '../../../domain/post/entities/post.dart';
import '../../../shared/base/base_ui_status.dart';

part 'post_list_state.freezed.dart';
part 'post_list_state.g.dart';

///
/// extends	자식 class가 부모 class의 method를 그대로 사용 가능
/// implements	자식 class가 부모 class의 method를 재정의 하여 사용해야 함
/// (부모 class는 거의abstarct)
///
@freezed
abstract class PostListState with _$PostListState implements BaseUiStatus {
  const factory PostListState({
    required List<Post> posts,
    bool? isLoading,
    Failure? error,
    RouteInfo? navigateTo,
  }) = _PostListState;

  factory PostListState.initial() =>
      const PostListState(posts: [], isLoading: false, error: null, navigateTo: null);

  factory PostListState.fromJson(Map<String, dynamic> json) => _$PostListStateFromJson(json);


  // PostListUiStatus copyWith({
  //   bool? isLoading,
  //   Failure? error,
  //   String? navigation,
  // }) {
  //   return PostListUiStatus(
  //     isLoading: isLoading ?? this.isLoading,
  //     error: error ?? this.error,
  //     navigation: navigation ?? this.navigation,
  //   );
  // }
}

///
/// // abstract class BaseUiStatus {
///
// class PostListState extends BaseUiStatus {
//   final List<Post> posts;
//
//   const PostListState({
//     this.posts = const [],
//     super.isLoading,
//     super.error,
//     super.navigateTo,
//   });
//
//   PostListState copyWith({
//     List<Post>? posts,
//
//     bool? isLoading,
//     Failure? error,
//     RouteInfo? navigateTo,
//   }) {
//     return PostListState(
//       posts: posts ?? this.posts,
//
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//       navigateTo: navigateTo ?? this.navigateTo,
//     );
//   }
//
//   factory PostListState.initial() =>
//       PostListState(posts: [], isLoading: false, error: null);
// }
