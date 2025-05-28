import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// dio 프로바이더
///
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));

  return dio;
});
