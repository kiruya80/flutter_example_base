import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di/retrofit_provider.dart';
import '../../../domain/auth/repositories/auth_repository.dart';
import '../repositories_impl/auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authApiProvider));
});
