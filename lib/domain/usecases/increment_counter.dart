import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../../utils/print_log.dart';
import '../repositories/counter_repository.dart';

class IncrementCounter implements UseCase<void, NoParams> {
  final CounterRepository repository;

  IncrementCounter(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    QcLog.d('IncrementCounter call ');
    return await repository.incrementCounter();
  }
}
