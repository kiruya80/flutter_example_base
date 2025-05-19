import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/failures.dart';
import 'local_counter_datasource.dart';

class LocalCounterDataSourceImpl implements LocalCounterDataSource {
  final SharedPreferences prefs;

  LocalCounterDataSourceImpl(this.prefs);

  Future<void> _ensureCounterExists() async {
    final value = prefs.getInt('counter');
    if (value == null) {
      await prefs.setInt('counter', 0); // 초기값 0 저장
    }
  }

  @override
  Future<int> getCounter() async {
    await _ensureCounterExists(); // 카운터 값 존재 확인 및 초기화
    final value = prefs.getInt('counter');
    if (value != null) {
      return value;
    } else {
      throw CacheException('Could not get cached counter value.');
    }
  }

  @override
  Future<void> saveCounter(int value) async {
    await prefs.setInt('counter', value);
  }
}
