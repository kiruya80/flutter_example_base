import 'package:flutter_example_base/data/post/repositories_impl/post_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'post_api_service_provider.dart';

final postRepositoryProvider = Provider<PostRepositoryImpl>((ref) {
  final apiService = ref.watch(postApiServiceProvider);
  return PostRepositoryImpl(apiService);
});
