import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../presentation/auth/auth_state.dart';
import '../../../presentation/auth/auth_view_model.dart';
import '../usecase/auth_usecase_providers.dart';

// 🔹 authViewModelProvider: ViewModel에 UseCase를 주입
final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  /// 유스케이스를 생성자로 보낸다
  return AuthViewModel(ref.watch(loginUseCaseProvider));
});
