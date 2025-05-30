import 'package:dartz/dartz.dart';
import 'package:flutter_example_base/data/post/models/post_model_mapper.dart';
import '../../../core/error/failures.dart';
import '../../../domain/post/entities/post.dart';
import '../../../domain/post/repositories/post_repository.dart';
import '../data_sources/remote/post_api.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApi api;

  PostRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final response = await api.getPosts();
      return Right(response.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Post>> createPost(Post post) async {
    try {
      // final model = PostModel.fromEntity(post); post.toModel()
      final model = post.toModel();
      final response = await api.createPost(model.toJson());
      return Right(response.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Post>> updatePost(Post post) async {
    try {
      // final model = PostModel.fromEntity(post);
      final model = post.toModel();
      final response = await api.updatePost(post.id ?? 123, model.toJson());
      return Right(response.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(int id) async {
    try {
      await api.deletePost(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
