import 'package:flutter_example_base/data/post/data_sources/remote/post_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/dio_provider.dart';

final postApiServiceProvider = Provider<PostApi>((ref) {
  final dio = ref.watch(dioProvider);
  return PostApi(dio);
});
