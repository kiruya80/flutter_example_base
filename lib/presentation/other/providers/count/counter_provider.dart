import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/shared_prefs_provider.dart';
import '../../../../data/count/data_sources/local/local_counter_datasource.dart';
import '../../../../data/count/data_sources/local/local_counter_datasource_impl.dart';
import '../../../../data/count/repositories_impl/counter_repository_impl.dart';
import '../../../../domain/count/entities/counter.dart';
import '../../../../domain/count/repositories/counter_repository.dart';
import '../../../../domain/count/usecases/get_counter_value.dart';
import '../../../../domain/count/usecases/increment_counter.dart';
import '../../../../domain/count/usecases/reset_counter.dart';
import 'counter_state_notifier.dart';

final localCounterDataSourceProvider = Provider<LocalCounterDataSource>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return LocalCounterDataSourceImpl(sharedPreferences);
});

///
/// 로컬 데이터 접근 프로바이더
/// counter 사용
///
final counterRepositoryProvider = Provider<CounterRepository>((ref) {
  final localDataSource = ref.watch(localCounterDataSourceProvider);
  return CounterRepositoryImpl(localDataSource: localDataSource);
});


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
