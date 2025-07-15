// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_ge_auto_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postGeAutoListNotifierHash() => r'd6f685689d8ade0086194bf0a5e13ee6492fd764';

///
/// 초기값으로 api 호출
///
/// Future<AsyncValue<...>>
/// ❌ 직접 state = ... 불가능
/// ✅ AsyncNotifier에서 초기 로딩 상태 포함한 패턴
///
/// Future<void> 또는 void
/// ✅ state = ... 직접 조작 가능
/// ✅ AsyncNotifier에서 상태 수동으로 관리할 때 사용
///
/// 초기에 데이터를 로딩하고 이후에 state를 변경하려면
///
/// @override
///
///
/// Copied from [PostGeAutoListNotifier].
@ProviderFor(PostGeAutoListNotifier)
final postGeAutoListNotifierProvider = AutoDisposeAsyncNotifierProvider<
  PostGeAutoListNotifier,
  AsyncValue<Either<Failure, List<Post>>>
>.internal(
  PostGeAutoListNotifier.new,
  name: r'postGeAutoListNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$postGeAutoListNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PostGeAutoListNotifier =
    AutoDisposeAsyncNotifier<AsyncValue<Either<Failure, List<Post>>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
