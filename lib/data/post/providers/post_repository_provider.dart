import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/retrofit_provider.dart';
import '../../../domain/post/repositories/post_repository.dart';
import '../repositories_impl/post_repository_impl.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImpl(ref.watch(postApiProvider));
});
