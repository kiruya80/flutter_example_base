import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  ///
  /// dart 특성으로 객체 생성시 call이 자동 실행된다
  /// 단, call의 파라미터가 있는 경우 맞아야
  ///
  Future<Either<Failure, Type>> call(Params params);
}
