import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/remote/post_api_service.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiService apiService;

  PostRepositoryImpl(this.apiService);

  @override
  Future<List<Post>> getPosts() async {
    final postModels = await apiService.getPosts();
    return postModels;
  }
}