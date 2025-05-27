import 'package:dartz/dartz.dart';
import 'package:flutter_example_base/utils/print_log.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

class GetCounterValue implements UseCase<Counter, NoParams> {
  final CounterRepository repository;

  GetCounterValue(this.repository);

  @override
  Future<Either<Failure, Counter>> call(NoParams params) async {
    QcLog.d('GetCounterValue call =====');
    final result = await repository.getCounterValue();
    return result.fold(
      (failure) {
        if (failure is CacheFailure) {
          return Right(const Counter(value: 0)); // CacheFailure 시 초기값 반환
        }
        return Left(failure);
      },
      (counter) => Right(counter),
    );
  }
}
