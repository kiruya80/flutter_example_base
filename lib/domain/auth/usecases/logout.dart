import 'package:dartz/dartz.dart';
import 'package:flutter_example_base/domain/common/params/no_params.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class Logout implements UseCase<void, NoParams> {
  final AuthRepository repository;

  Logout(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams noParams) {
    return repository.logout();
  }
}
