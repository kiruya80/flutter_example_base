import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/auth/usecases/login.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(); // 싱글톤처럼 유지
});
