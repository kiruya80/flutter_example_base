// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_ge.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$counterGeHash() => r'7d2a6e4d5024060c96468a1457a23555103de834';

///
/// riverpod_generator를 사용하여 프로바이더 자동 생성
/// 어떤 종류의 프로바이더를 생성하고 싶은지에 따라 Counter 클래스의 정의 방식이 달라집니다
/// @riverpod 어노테이션이 붙은 클래스는 기본적으로 AutoDisposeNotifierProvider를 생성
///
/// flutter pub run build_runner build --delete-conflicting-outputs
/// flutter pub run build_runner build
///
/// 1. AutoDisposeNotifierProvider - @riverpod 또는 @Riverpod()
/// 2. NotifierProvider - @Riverpod(keepAlive: true)
/// 3. FutureProvider
/// 4. StreamProvider
///
///
///
///
///
/// Copied from [CounterGe].
@ProviderFor(CounterGe)
final counterGeProvider = NotifierProvider<CounterGe, int>.internal(
  CounterGe.new,
  name: r'counterGeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$counterGeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CounterGe = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
