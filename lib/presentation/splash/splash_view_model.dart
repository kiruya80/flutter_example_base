import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, AsyncValue<void>>(
  (ref) => SplashViewModel(),
);

class SplashViewModel extends StateNotifier<AsyncValue<void>> {
  SplashViewModel() : super(const AsyncData(null));

  Future<bool> checkAuthStatus() async {
    state = const AsyncLoading();
    try {
      await Future.delayed(const Duration(seconds: 2));

      // TODO: 실제 로그인 토큰 검사 로직 작성 (SharedPreferences 등)
      final isLoggedIn = false; // 테스트용

      state = const AsyncData(null);
      return isLoggedIn;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}
