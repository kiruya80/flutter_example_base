import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../repositories/post_repository.dart';

class DeletePost {
  final PostRepository repository;

  DeletePost(this.repository);

  Future<Either<Failure, void>> call(int id) {
    return repository.deletePost(id);
  }
}
