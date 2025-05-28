import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

///
/// 	•	비즈니스 로직을 하나의 책임으로 분리 call 이 하나로
///     로그인과 로그아웃을 합치지말고 두개로 분리애햐한다
///   •	단일 원칙 책임
/// 	•	주입 가능한 구조 (예: Provider, Riverpod, DI 등)
///
class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<Either<Failure, User>> call(String id, {String? password}) {
    return repository.login(id, password: password);
  }
}
