import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/dio_provider.dart';
import '../../data/auth/data_sources/remote/auth_api.dart';
import '../../data/post/data_sources/remote/post_api.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthApi(dio);
});

final postApiProvider = Provider<PostApi>((ref) {
  final dio = ref.watch(dioProvider);
  return PostApi(dio);
});
