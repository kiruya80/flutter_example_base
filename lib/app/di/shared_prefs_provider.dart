import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// final sharedPreferences = ref.watch(sharedPreferencesProvider);
/// runApp 에서 초기화
///
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // override 하지 않으면 에러 발생
});

// final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
//   return await SharedPreferences.getInstance();
// });