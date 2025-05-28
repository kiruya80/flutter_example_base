import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class UpdatePost implements UseCase<Post, Post> {
  final PostRepository repository;

  UpdatePost(this.repository);

  @override
  Future<Either<Failure, Post>> call(Post post) {
    return repository.updatePost(post);
  }
}
