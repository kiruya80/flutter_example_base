import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/auth/providers/auth_repository_provider.dart';
import '../../../domain/auth/usecases/login.dart';

/// login, logout usecase
///
// authRepositoryProvider는 data 레이어에서 등록되어 있어야 함
// 🔹 loginProvider: UseCase를 주입함
final loginUseCaseProvider = Provider<Login>((ref) {
  return Login(ref.watch(authRepositoryProvider));
});
