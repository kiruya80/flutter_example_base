import 'package:async/async.dart';

///
/// ?
///
class SimpleCancelableCompleter<T> {
  CancelableCompleter<T> _completer = CancelableCompleter<T>();

  bool get isCompleted => _completer.isCompleted;
  bool get isRunning => !_completer.isCompleted;

  Future<T?> get future => _completer.operation.valueOrCancellation();

  void complete([T? value]) {
    if (!_completer.isCompleted) {
      _completer.complete(value);
    }
  }

  void cancel() {
    if (!_completer.isCompleted) {
      _completer.operation.cancel();
    }
  }
}