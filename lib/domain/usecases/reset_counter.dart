import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../../utils/print_log.dart';
import '../repositories/counter_repository.dart';

class ResetCounter implements UseCase<void, NoParams> {
  final CounterRepository repository;

  ResetCounter(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    QcLog.d('ResetCounter call ');
    return await repository.resetCounter();
  }

  Future<Either<Failure, void>> callTest() async {
    QcLog.d('ResetCounter callTest ');
    return await repository.resetCounter();
  }
}
