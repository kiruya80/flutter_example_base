abstract class Failure {
  final String message;

  const Failure(this.message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}