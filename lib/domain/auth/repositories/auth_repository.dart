import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/user.dart';

///
/// 	•	Either<Failure, Result> 구조로 성공/실패 반환
/// 	•	외부 API나 로컬 DB와 직접 통신하지 않음 → data 레이어에서 구현
///
abstract class AuthRepository {
  Future<Either<Failure, User>> login(String id, {String? password});
  Future<Either<Failure, void>> logout();
}
