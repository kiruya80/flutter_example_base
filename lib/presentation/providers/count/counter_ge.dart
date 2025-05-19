import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_ge.g.dart';

///
/// riverpod_generator를 사용하여 프로바이더 자동 생성
/// 어떤 종류의 프로바이더를 생성하고 싶은지에 따라 Counter 클래스의 정의 방식이 달라집니다
/// @riverpod 어노테이션이 붙은 클래스는 기본적으로 AutoDisposeNotifierProvider를 생성
///
/// flutter pub run build_runner build --delete-conflicting-outputs
/// flutter pub run build_runner build
///
/// 1. AutoDisposeNotifierProvider - @riverpod 또는 @Riverpod()
// @Riverpod(keepAlive: false)
// class Counter extends _$Counter {
//   // ... 상태 관리 로직
// }
// @riverpod
// class AutoCounter extends _$AutoCounter with AutoDisposeMixin {
//  ....
// }
/// 2. NotifierProvider - @Riverpod(keepAlive: true)
// @riverpod
// class PersistentCounter extends _$PersistentCounter {
//   // ... 상태 관리 로직
// }
/// 3. FutureProvider
// @riverpod
// Future<int> counterValue(CounterValueRef ref) async {
//   // ... 비동기 작업 수행 후 int 값 반환
//   return someAsyncOperation();
// }
/// 4. StreamProvider
// @riverpod
// Stream<int> counterStream(CounterStreamRef ref) {
//   // ... int 값을 방출하는 Stream 반환
//   return someStream();
// }
///
///
///
///
@Riverpod(keepAlive: true)
// @riverpod
class CounterGe extends _$CounterGe {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}