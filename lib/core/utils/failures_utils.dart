
import 'package:dio/dio.dart';

import '../error/failures.dart';

class FailuresUtils {
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
      return CacheFailure(( e as CacheException).message);
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
}