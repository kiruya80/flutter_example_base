import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/post_repository.dart';

class DeletePost implements UseCase<void, int> {
  final PostRepository repository;

  DeletePost(this.repository);

  @override
  Future<Either<Failure, void>> call(int id) {
    return repository.deletePost(id);
  }
}
