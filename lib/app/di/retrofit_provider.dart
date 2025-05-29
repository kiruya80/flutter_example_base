import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/auth/data_sources/remote/auth_api.dart';
import '../../data/post/data_sources/remote/post_api.dart';
import 'dio_provider.dart';

///
/// retrofit을 사용하는 api 프로바이더
///

final authApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthApi(dio);
});

final postApiProvider = Provider<PostApi>((ref) {
  final dio = ref.watch(dioProvider);
  return PostApi(dio);
});
