import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/counter.dart';
import '../../domain/repositories/counter_repository.dart';
import '../data_sources/local/local_counter_datasource.dart';
import '../data_sources/local/local_counter_datasource_impl.dart';
import '../models/counter_model.dart';

class CounterRepositoryImpl implements CounterRepository {
  final LocalCounterDataSource localDataSource;

  CounterRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Counter>> getCounterValue() async {
    try {
      final localCounter = await localDataSource.getCounter();
      return Right(CounterModel(value: localCounter).toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Counter>> incrementCounter() async {
    try {
      final currentValue = await localDataSource.getCounter();
      final result = currentValue + 1;
      await localDataSource.saveCounter(result);
      // return Right(result);
      return Right(CounterModel(value: result).toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> resetCounter({int? deValue}) async {
    try {
      await localDataSource.saveCounter(deValue ?? 0);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
