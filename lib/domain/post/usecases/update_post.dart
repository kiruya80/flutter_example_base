import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class UpdatePost {
  final PostRepository repository;

  UpdatePost(this.repository);

  Future<Either<Failure, Post>> call(Post post) {
    return repository.updatePost(post);
  }
}
