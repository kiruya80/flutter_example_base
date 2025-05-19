import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/post_repository_impl.dart';
import 'post_api_service_provider.dart';

final postRepositoryProvider = Provider<PostRepositoryImpl>((ref) {
  final apiService = ref.watch(postApiServiceProvider);
  return PostRepositoryImpl(apiService);
});