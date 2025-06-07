import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/post_model.dart';

part 'post_api.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class PostApi {
  factory PostApi(Dio dio) = _PostApi;

  @GET("/posts")
  Future<List<PostModel>> getPosts();

  @POST("/posts")
  Future<PostModel> createPost(@Body() Map<String, dynamic> body);

  @PUT("/posts/{id}")
  Future<PostModel> updatePost(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("/posts/{id}")
  Future<void> deletePost(@Path("id") int id);
}

// @RestApi()
// abstract class PostApiService {
//   factory PostApiService(Dio dio, {String baseUrl}) = _PostApiService;
//
//   @GET('/posts')
//   Future<List<PostResponseDto>> getPosts();
//
//   @POST('/posts')
//   Future<PostResponseDto> createPost(@Body() PostRequestDto dto);
// }
