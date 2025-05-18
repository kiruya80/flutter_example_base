import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/counter.dart';
import '../../domain/usecases/get_counter_value.dart';
import '../../domain/usecases/increment_counter.dart';
import '../../domain/usecases/reset_counter.dart';
import '../repository_providers.dart';
import 'counter_state_notifier.dart';

final incrementCounterProvider = Provider<IncrementCounter>((ref) {
  /// 레파지토리 프로바이더 가져오기
  final repository = ref.watch(counterRepositoryProvider);
  return IncrementCounter(repository);
});

final getCounterValueProvider = Provider<GetCounterValue>((ref) {
  /// 레파지토리 프로바이더 가져오기
  final repository = ref.watch(counterRepositoryProvider);
  return GetCounterValue(repository);
});

final resetCounterValueProvider = Provider<ResetCounter>((ref) {
  /// 레파지토리 프로바이더 가져오기
  final repository = ref.watch(counterRepositoryProvider);
  return ResetCounter(repository);
});


///
/// 뷰모델 같이. 위젯에서 사용할 통합 프로바이더
///
/// domain > usecase에서
///
final counterNotifierProvider = StateNotifierProvider<CounterNotifier, AsyncValue<Counter>>((ref) {
  /// 화면에서 필요한 기능별 usecase
  final incrementCounter = ref.watch(incrementCounterProvider);
  final getCounterValue = ref.watch(getCounterValueProvider);
  final resetCounterValue = ref.watch(resetCounterValueProvider);

  return CounterNotifier(incrementCounter, getCounterValue, resetCounterValue)..getValue();
});