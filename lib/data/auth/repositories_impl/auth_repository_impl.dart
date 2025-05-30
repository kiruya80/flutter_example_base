import 'package:dartz/dartz.dart';
import 'package:flutter_example_base/data/auth/models/auth_model_mapper.dart';
import '../../../core/error/failures.dart';
import '../../../domain/auth/entities/user.dart';
import '../../../domain/auth/repositories/auth_repository.dart';
import '../../post/models/post_model.dart';
import '../data_sources/remote/auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi api;

  AuthRepositoryImpl(this.api);

  @override
  Future<Either<Failure, User>> login(String id, {String? password}) async {
    try {

      /// todo 샘플은 로그인 api가 없어서 테스트용으로
      PostModel postModel = PostModel(
          id: 123, userId: 9999, title: id, body: id
      );
      final response = await api.login(postModel.toJson());
      // final response = await api.login({'email': email, 'password': password});
      return Right(response.toEntity());
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await api.logout();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
