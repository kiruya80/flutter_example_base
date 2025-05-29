import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/di/shared_prefs_provider.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 앱 전체에서 사용할 SharedPreferences 인스턴스를 딱 한 번 생성해서,
  /// 모든 곳에서 동일하게 접근할 수 있도록 하기 위해서입니다.
  /// 	•	SharedPreferences.getInstance()는 async 함수이기 때문에, Provider 내부에서 사용할 수 없음
  // 	•	Provider는 동기적으로 생성되어야 하기 때문에 비동기 호출을 넣으면 안 됩니다.
  // 	•	따라서 비동기 초기화가 가능한 main()에서만 처리할 수 있습니다.
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        /// 여기에 선언하는게 필수는 아님 테스트등 사용시
        sharedPreferencesProvider.overrideWithValue(prefs), // ✅ 여기서 실제 주입
        // localCounterDataSourceProvider.overrideWith(
        //   (ref) => LocalCounterDataSourceImpl(
        //     ref.watch(sharedPreferencesProvider).requireValue,
        //   ),
        // ),
        // localCounterDataSourceProvider.overrideWith((ref) {
        //   return  LocalCounterDataSourceImpl(
        //     ref.watch(sharedPreferencesProvider).requireValue,
        //   );
        // }),
        // counterRepositoryProvider.overrideWith((ref) {
        //   final localDataSource = ref.read(localCounterDataSourceProvider);
        //   return CounterRepositoryImpl(localDataSource: localDataSource);
        // }),
        // incrementCounterProvider.overrideWith((ref) {
        //   final repository = ref.read(counterRepositoryProvider);
        //   return IncrementCounter(repository);
        // }),
        // getCounterValueProvider.overrideWith((ref) {
        //   final repository = ref.read(counterRepositoryProvider);
        //   return GetCounterValue(repository);
        // }),
        // counterNotifierProvider.overrideWith((ref) {
        //   final increment = ref.read(incrementCounterProvider);
        //   final getValue = ref.read(getCounterValueProvider);
        //   return CounterNotifier(increment, getValue)..getValue();
        // }),
      ],
      child: const MyApp(),
    ),
  );
}
