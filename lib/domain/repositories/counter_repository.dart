import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/counter.dart';

abstract class CounterRepository {
  Future<Either<Failure, Counter>> getCounterValue();
  Future<Either<Failure, void>> incrementCounter();
  Future<Either<Failure, void>> resetCounter({int? deValue});
}