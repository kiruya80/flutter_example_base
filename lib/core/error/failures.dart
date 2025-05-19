import 'package:dio/dio.dart';

/// Failure 추상화로 앱 전반에서 오류 일관 처리 가능
abstract class Failure {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});
}

/// Failure는 UI에 전달하거나 상태로 표현할 수 있는 오류 표현
class CacheFailure extends Failure {
  const CacheFailure(String message, {String? code}) : super(message, code: code);
}

/// Failure는 UI에 전달하거나 상태로 표현할 수 있는 오류 표현
class ServerFailure extends Failure {
  const ServerFailure(String message, {String? code}) : super(message, code: code);
}

/// Exception은 실제 오류 발생 (throw/catch) 용도로 사용
class CacheException implements Exception {
  final String message;
  CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}

/// mapExceptionToFailure()로 예외를 도메인 오류로 매핑 — 매우 좋은 접근!
///
/// 예시)
// try {
//   final data = await repository.getData();
//   state = AsyncValue.data(data);
// } catch (e) {
//   final failure = mapExceptionToFailure(e as Exception);
//   state = AsyncValue.error(failure, StackTrace.current);
// }
///
/// UI : error is Failure ? error.message : '오류가 발생했습니다.'
///
Failure mapExceptionToFailure(Exception e) {
  if (e is CacheException) {
    return CacheFailure(e.message);
  } else if (e is DioException) {
    return ServerFailure("네트워크 오류", code: e.response?.statusCode.toString());
  } else {
    return ServerFailure("알 수 없는 오류");
  }
}

String mapFailureToMessage(Failure failure) {
  if (failure is CacheFailure) {
    return 'Could not retrieve cached data.';
  }
  return 'Unexpected error';
}

Exception mapFailureToException(Failure failure) {
  return Exception(mapFailureToMessage(failure));
}