import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_sources/remote/post_api_service.dart';
import 'dio_provider.dart';

final postApiServiceProvider = Provider<PostApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return PostApiService(dio);
});
