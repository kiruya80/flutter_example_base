import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../models/auth_model.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  // @POST("/login")
  @POST("/posts")
  Future<AuthModel> login(@Body() Map<String, dynamic> body);

  @POST("/logout")
  Future<void> logout();
}
