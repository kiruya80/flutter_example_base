import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

part 'failures.g.dart';

/// Failure 추상화로 앱 전반에서 오류 일관 처리 가능
@freezed
abstract class Failure with _$Failure {
  const factory Failure(String message, {String? code}) = _Failure;

  factory Failure.fromJson(Map<String, dynamic> json) => _$FailureFromJson(json);
}

/// Failure는 UI에 전달하거나 상태로 표현할 수 있는 오류 표현
@freezed
abstract class CacheFailure with _$CacheFailure implements Failure {
  const factory CacheFailure(String message, {String? code}) = _CacheFailure;

  factory CacheFailure.fromJson(Map<String, dynamic> json) => _$CacheFailureFromJson(json);
}

/// Failure는 UI에 전달하거나 상태로 표현할 수 있는 오류 표현
@freezed
abstract class ServerFailure with _$ServerFailure implements Failure {
  const factory ServerFailure(String message, {String? code}) = _ServerFailure;

  factory ServerFailure.fromJson(Map<String, dynamic> json) => _$ServerFailureFromJson(json);
}

/// Exception은 실제 오류 발생 (throw/catch) 용도로 사용
@freezed
abstract class CacheException with _$CacheException implements Failure {
  const factory CacheException(String message, {String? code}) = _CacheException;

  factory CacheException.fromJson(Map<String, dynamic> json) => _$CacheExceptionFromJson(json);
}
