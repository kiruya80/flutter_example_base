import 'package:flutter_example_base/data/providers/shared_prefs_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_sources/local/local_counter_datasource.dart';
import '../data_sources/local/local_counter_datasource_impl.dart';
import '../repositories/counter_repository_impl.dart';
import '../../domain/repositories/counter_repository.dart';


///
/// DB
///
// final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
//   return await SharedPreferences.getInstance();
// });

final localCounterDataSourceProvider = Provider<LocalCounterDataSource>((ref) {
  // final sharedPreferences = ref.watch(sharedPrefsProviderer).requireValue;
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return LocalCounterDataSourceImpl(sharedPreferences);
});

///
/// 로컬 데이터 접근 프로바이더
///
final counterRepositoryProvider = Provider<CounterRepository>((ref) {
  final localDataSource = ref.watch(localCounterDataSourceProvider);
  return CounterRepositoryImpl(localDataSource: localDataSource);
});
