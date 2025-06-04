import 'dart:ui';

import 'package:flutter_example_base/core/utils/print_log.dart';

import 'dialog_request.dart';

// final dialogController = DialogController();

///
/// 팝업 제어용 클래스
///
/// 다이얼로그 컨트럴
///

///
/// 2.
///
class DialogController {
  static final DialogController instance = DialogController._();
  DialogController._();

  late void Function() _showLoading;
  late void Function() _hideLoading;
  late void Function(DialogRequest request) _enqueueDialog;

  bool _isLoadingVisible = false;
  bool _isDialogVisible = false;

  set isLoadingVisible(bool value) {
    _isLoadingVisible = value;
  }

  set isDialogVisible(bool value) {
    _isDialogVisible = value;
  }

  bool get isLoadingVisible => _isLoadingVisible;

  bool get isDialogVisible => _isDialogVisible;

  // 상태 변경 함수
  void markLoadingVisible() => _isLoadingVisible = true;

  void markLoadingHidden() => _isLoadingVisible = false;

  void markDialogVisible() => _isDialogVisible = true;

  void markDialogHidden() => _isDialogVisible = false;


  /// 로딩 닫기 가능 유무
  /// 로딩이 있거나  일반 다이얼로그가 있다면 불가
  bool get isLoadingDisable => _isLoadingVisible == false || _isDialogVisible;

  ///
  /// DialogQueueListener에서 등록
  ///
  void register({
    required void Function() showLoading,
    required void Function() hideLoading,
    required void Function(DialogRequest request) enqueueDialog,
  }) {
    _showLoading = () {
      QcLog.d('_showLoading ===== $_isLoadingVisible');
      if (_isLoadingVisible) return;
      _isLoadingVisible = true;
      showLoading();
    };

    _hideLoading = () {
      QcLog.d('_hideLoading ===== $_isLoadingVisible , $_isDialogVisible');
      if (!_isLoadingVisible && !_isDialogVisible) return;
      _isLoadingVisible = false;
      hideLoading();
    };

    _enqueueDialog = (request) {
      QcLog.d('_enqueueDialog ===== $request');
      enqueueDialog(request);
    };
  }

  /// 로딩 띄우기
  void showLoading() => _showLoading();

  /// 로딩 지우기
  void hideLoading() => _hideLoading();

  /// 일반 다이얼로그 띄우기
  void showAppDialog({
    required String title,
    required String message,
    DialogRequestType type = DialogRequestType.info,
    VoidCallback? onConfirmed,
    VoidCallback? onCancelled,
  }) {
    _enqueueDialog(
      DialogRequest(
        title: title,
        message: message,
        type: type,
        onConfirmed: onConfirmed,
        onCancelled: onCancelled,
      ),
    );
  }

  void showError(String message) {
    _enqueueDialog(
      DialogRequest(
        title: '에러',
        message: message,
        type: DialogRequestType.error,
        // onConfirmed: onConfirmed,
      ),
    );
  }
}

///
/// 1.
///
// class DialogController {
//   static final DialogController instance = DialogController._();
//   DialogController._();
//
//   final _queue = Queue<_DialogRequest>();
//   bool _isShowing = false;
//
//   void showLoading() => _enqueue(_DialogRequest.loading());
//   void hideLoading() => _dismiss();
//
//   void showError(String message) => _enqueue(_DialogRequest.error(message));
//   void showSuccess(String message) => _enqueue(_DialogRequest.success(message));
//   void showConfirm(String message, VoidCallback onYes, VoidCallback onNo) =>
//       _enqueue(_DialogRequest.confirm(message, onYes, onNo));
//   void showCustom(Widget widget) => _enqueue(_DialogRequest.custom(widget));
//
//   void _enqueue(_DialogRequest request) {
//     _queue.add(request);
//     _tryNext();
//   }
//
//   void _tryNext() {
//     if (_isShowing || _queue.isEmpty) return;
//
//     final request = _queue.removeFirst();
//     _isShowing = true;
//
//     switch (request.type) {
//       case _DialogType.loading:
//         _showDialog(const Center(child: CircularProgressIndicator()));
//         break;
//       case _DialogType.error:
//         _showDialog(AlertDialog(title: const Text('Error'), content: Text(request.message!)));
//         break;
//       case _DialogType.success:
//         _showDialog(AlertDialog(title: const Text('Success'), content: Text(request.message!)));
//         break;
//       case _DialogType.confirm:
//         _showDialog(AlertDialog(
//           title: const Text('Confirm'),
//           content: Text(request.message!),
//           actions: [
//             TextButton(onPressed: () {
//               Navigator.of(navigatorKey.currentContext!).pop();
//               request.onCancel?.call();
//             }, child: const Text('Cancel')),
//             ElevatedButton(onPressed: () {
//               Navigator.of(navigatorKey.currentContext!).pop();
//               request.onConfirm?.call();
//             }, child: const Text('OK')),
//           ],
//         ));
//         break;
//       case _DialogType.custom:
//         _showDialog(request.customWidget!);
//         break;
//     }
//   }
//
//   void _showDialog(Widget dialog) {
//     showDialog(
//       context: navigatorKey.currentContext!,
//       barrierDismissible: false,
//       builder: (_) => dialog,
//     ).then((_) {
//       _isShowing = false;
//       _tryNext();
//     });
//   }
//
//   void _dismiss() {
//     if (_isShowing) {
//       navigatorKey.currentState?.pop();
//       _isShowing = false;
//       _tryNext();
//     }
//   }
// }

///
/// 3.
///
// class DialogController {
//   static final DialogController instance = DialogController._();
//   DialogController._();
//
//   final _queue = Queue<_DialogRequest>();
//   bool _isShowing = false;
//
//   void showLoading() => _enqueue(_DialogRequest.loading());
//   void showError(String message) => _enqueue(_DialogRequest.error(message));
//
//   void hideLoading() {
//     if (_isShowing) {
//       navigatorKey.currentState?.pop();
//       _isShowing = false;
//       _tryNext();
//     }
//   }
//
//   void _enqueue(_DialogRequest request) {
//     _queue.add(request);
//     _tryNext();
//   }
//
//   void _tryNext() {
//     if (_isShowing || _queue.isEmpty) return;
//     final request = _queue.removeFirst();
//     _isShowing = true;
//
//     switch (request.type) {
//       case _DialogType.loading:
//         _showDialog(const Center(child: CircularProgressIndicator()));
//         break;
//       case _DialogType.error:
//         _showDialog(AlertDialog(content: Text(request.message!)));
//         break;
//     }
//   }
//
//   void _showDialog(Widget dialog) {
//     showDialog(
//       context: navigatorKey.currentContext!,
//       barrierDismissible: false,
//       builder: (_) => dialog,
//     ).then((_) {
//       _isShowing = false;
//       _tryNext();
//     });
//   }
// }