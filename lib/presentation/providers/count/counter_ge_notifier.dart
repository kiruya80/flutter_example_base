import 'package:flutter_example_base/utils/print_log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/counter.dart';
import 'counter_provider.dart';

part 'counter_ge_notifier.g.dart';


// @Riverpod(keepAlive: false)
@riverpod
class CounterGeNotifier extends _$CounterGeNotifier {
  late final incrementUseCase;
  late final getValueUseCase;
  late final resetCounterUseCase;

  ///
  /// @riverpod에서는 생성자에 의존성을 넣지 않고, 반드시 build() 안에서 주입해야 합니다.
  /// build애서 의존성을 주입하는 구조이기세
  /// ref.read(incrementCounterProvider); 같이 사용 가능
  ///
  @override
  FutureOr<Counter> build() async {
    QcLog.d('build 초기화');

    incrementUseCase = ref.read(incrementCounterProvider);
    getValueUseCase = ref.read(getCounterValueProvider);
    resetCounterUseCase = ref.read(resetCounterValueProvider);

    final result = await getValueUseCase(NoParams());
    return result.fold((failure) => throw _mapFailureToException(failure), (counter) => counter);
  }

  Future<void> increment() async {
    QcLog.d('increment');
    final result = await incrementUseCase(NoParams());
    result.fold(
      (failure) => state = AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
      (_) async {
        final newValue = await getValueUseCase(NoParams());
        newValue.fold(
          (failure) => state = AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
          (counter) => state = AsyncValue.data(counter),
        );
      },
    );
  }

  Future<void> getValue() async {
    QcLog.d('getValue');
    state = const AsyncValue.loading();

    await Future.delayed(Duration(seconds: 1));

    final result = await getValueUseCase(NoParams());
    result.fold(
      (failure) => state = AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
      (counter) => state = AsyncValue.data(counter),
    );
  }

  Future<void> resetCount() async {
    ///
    /// await _resetCounterValue(NoParams()); 또는
    /// await _resetCounterValue.call(NoParams());
    ///
    // final result = await resetCounterUseCase(NoParams());
    final result = await resetCounterUseCase.call(NoParams());
    QcLog.d('resetCount result == $result');
    result.fold(
      (failure) => state = AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
      (_) async {
        QcLog.d('resetCount 성공 후 값 가져오기 ');
        // state = AsyncValue.data();
        await getValue();
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is CacheFailure) {
      return 'Could not retrieve cached data.';
    }
    return 'Unexpected error';
  }

  Exception _mapFailureToException(Failure failure) {
    return Exception(_mapFailureToMessage(failure));
  }
}
