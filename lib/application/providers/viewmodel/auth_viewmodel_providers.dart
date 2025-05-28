import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../presentation/auth/auth_state.dart';
import '../../../presentation/auth/auth_view_model.dart';
import '../usecase/auth_usecase_providers.dart';

// 🔹 loginViewModelProvider: ViewModel에 UseCase를 주입
final loginViewModelProvider = StateNotifierProvider<LoginViewModel, AuthState>((ref) {
  /// 유스케이스를 생성자로 보낸다
  final login = ref.watch(loginUseCaseProvider);
  return LoginViewModel(login);
});
