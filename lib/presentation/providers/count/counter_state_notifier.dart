import 'package:flutter_example_base/domain/usecases/reset_counter.dart';
import 'package:flutter_example_base/utils/print_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/counter.dart';
import '../../../domain/usecases/get_counter_value.dart';
import '../../../domain/usecases/increment_counter.dart';

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
    QcLog.d('increment result == $result');
    result.fold(
      (failure) => state = AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
      (_) async {
        await getValue();
      },
    );
  }

  Future<void> getValue() async {
    QcLog.d('getValue');
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
}
