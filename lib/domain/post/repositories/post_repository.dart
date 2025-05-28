import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../entities/post.dart';

///
/// 	•	실패 시 String을 실패 메시지로 사용 중 (나중에 Failure 클래스로 확장 가능)
///
abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, Post>> createPost(Post post);
  Future<Either<Failure, Post>> updatePost(Post post);
  Future<Either<Failure, void>> deletePost(int id);
}
