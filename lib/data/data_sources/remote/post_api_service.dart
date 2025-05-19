import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/post_model.dart';

part 'post_api_service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class PostApiService {
  factory PostApiService(Dio dio, {String baseUrl}) = _PostApiService;

  @GET("/posts")
  Future<List<PostModel>> getPosts();
}