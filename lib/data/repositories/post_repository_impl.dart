import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/remote/post_api_service.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiService apiService;

  PostRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final posts = await apiService.getPosts();
      return Right(posts); // 성공
    } catch (e) {
      return Left(ServerFailure('Failed to fetch posts')); // 실패
    }
  }
}