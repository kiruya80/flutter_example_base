import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/common/params/no_params.dart';
import '../../../../domain/count/entities/counter.dart';
import '../../../../domain/count/usecases/get_counter_value.dart';
import '../../../../domain/count/usecases/increment_counter.dart';
import '../../../../domain/count/usecases/reset_counter.dart';

// 더 이상 incrementCounterProvider와 getCounterValueProvider를 여기서 정의하지 않습니다.
// 이들은 main.dart에서 정의되었습니다.
// 상태를 관리하는 StateNotifierProvider
class CounterNotifier extends StateNotifier<AsyncValue<Counter>> {
  CounterNotifier(this._increment, this._getValue, this._resetCounterValue)
      : super(const AsyncValue.loading());

  final IncrementCounter _increment;
  final GetCounterValue _getValue;
  final ResetCounter _resetCounterValue;

  Future<void> increment() async {
    final result = await _increment(NoParams());
    result.fold(
      (failure) => state = AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
      (_) async {
        await getValue();
      },
    );
  }

  Future<void> getValue() async {
    state = const AsyncValue.loading();

    // await Future.delayed(Duration(seconds: 1));

    final result = await _getValue(NoParams());
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
    // final result = await _resetCounterValue(NoParams());
    final result = await _resetCounterValue.call(NoParams());
    result.fold(
      (failure) => state = AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
      (_) async {
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
}
