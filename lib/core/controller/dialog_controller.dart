import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/routes/app_router.dart';
import '../../domain/common/entities/dialog_request.dart';
import '../utils/print_log.dart';

///
/// 팝업 제어용 클래스
///
///  DialogController – 다이얼로그 큐 컨트롤러
///
/// 	•	다이얼로그 큐 관리 전담
/// 	•	enqueue, dequeue, currentDialog 등 제공
///
///

// 큐에 쌓이는 다이얼로그들
final dialogQueueProvider = StateProvider<List<DialogRequest>>((ref) => []);

// 현재 다이얼로그가 떠 있는지 여부
final isDialogShowingProvider = StateProvider<bool>((ref) => false);

// 로딩 다이얼로그 전용 상태
final isLoadingDialogShowingProvider = StateProvider<bool>((ref) => false);

class DialogController {
  final WidgetRef ref;

  DialogController(this.ref);

  ///
  ///  큐에 넣기 (일반, 로딩)
  ///
  ///   DialogController(
  ///           ref,
  ///         ).showDialog(DialogRequest(type: DialogType.error, title: "에러", message: next.error!.message));
  ///
  void enqueue(DialogRequest request) {
    QcLog.d('enqueue ======= ${request.toString()}');
    final queue = ref.read(dialogQueueProvider);
    ref.read(dialogQueueProvider.notifier).state = [...queue, request];
  }

  ///
  /// 로딩 띄우기
  ///
  void showLoading({String? message}) {
    /// 로딩이 있는 경우는 패스
    final isLoading = ref.read(isLoadingDialogShowingProvider);
    if (isLoading) return;

    /// 큐에 넣기
    enqueue(DialogRequest(type: DialogType.loading, message: message));
  }

  ///
  /// 로딩 지우기
  ///
  void hideLoading() {
    /// 로딩이 없는 경우는 패스
    final isLoading = ref.read(isLoadingDialogShowingProvider);
    if (isLoading == false) return;

    /// 큐가 있는 경우 큐에서 빼기
    if (ref.read(dialogQueueProvider).isNotEmpty) {
      ref.read(dialogQueueProvider.notifier).state =
          ref.read(dialogQueueProvider).skip(1).toList();
    }

    /// 로딩 빼기
    _popDialogIfShowing(DialogType.loading);

    /// 상태 변경
    ref.read(isDialogShowingProvider.notifier).state = false;
    ref.read(isLoadingDialogShowingProvider.notifier).state = false;
  }

  void dismissCurrentDialog() {
    if (ref.read(dialogQueueProvider).isNotEmpty) {
      ref.read(dialogQueueProvider.notifier).state =
          ref.read(dialogQueueProvider).skip(1).toList();
    }
    ref.read(isDialogShowingProvider.notifier).state = false;
  }

  ///
  /// 로딩 팝업 닫기
  ///
  void _popDialogIfShowing(DialogType type) {
    final context = AppRouter.globalNavigatorKey.currentContext!;
    if (context.mounted && ref.read(isDialogShowingProvider)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  ///
  /// 큐에서 꺼내기
  ///
  void dequeue() {
    QcLog.d(
      'dequeue ====  ${ref.read(dialogQueueProvider.notifier).state.length}',
    );
    final queue = [...ref.read(dialogQueueProvider)];

    if (queue.isNotEmpty) {
      queue.removeAt(0);
      ref.read(dialogQueueProvider.notifier).state = queue;
    }
  }

  void clear() {
    ref.read(dialogQueueProvider.notifier).state = [];
    ref.read(isDialogShowingProvider.notifier).state = false;
    ref.read(isLoadingDialogShowingProvider.notifier).state = false;
  }

  // void enqueue(DialogRequest request) {
  //   final queue = [...ref.read(dialogQueueProvider)];
  //   QcLog.d('enqueue ==== ${request.toString()} , ${queue.length}');
  //   queue.add(request);
  //   ref.read(dialogQueueProvider.notifier).state = queue;
  // }
  //
  //
  // DialogRequest? get currentDialog {
  //   final queue = ref.read(dialogQueueProvider);
  //   return queue.isNotEmpty ? queue.first : null;
  // }
  //
  // bool get hasDialogs => ref.read(dialogQueueProvider).isNotEmpty;
}

// class DialogController {
//   static final DialogController instance = DialogController._();
//
//   DialogController._();
//
//   final _queue = Queue<DialogRequest>();
//   bool _isShowing = false;
//
//   void showLoading() => _enqueue(DialogRequest.loading());
//
//
//   void showError(String message) => _enqueue(DialogRequest.error(message));
//
//   void showSuccess(String message) => _enqueue(DialogRequest.success(message));
//
//   void showConfirm(String message, VoidCallback onYes, VoidCallback onNo) =>
//       _enqueue(DialogRequest.confirm(message, onYes, onNo));
//
//   void showCustom(Widget widget) => _enqueue(DialogRequest.custom(widget));
//
//   void hideLoading() => _dismiss();
//   ///
//   /// 다이얼로그가 들어오면 큐에 넣고 다음 시작
//   ///
//   void _enqueue(DialogRequest request) {
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
//       case DialogType.loading:
//         _showDialog(const Center(child: CircularProgressIndicator()));
//         break;
//       case DialogType.error:
//         _showDialog(AlertDialog(title: const Text('Error'), content: Text(request.message!)));
//         break;
//       case DialogType.success:
//         _showDialog(AlertDialog(title: const Text('Success'), content: Text(request.message!)));
//         break;
//       case DialogType.confirm:
//         _showDialog(
//           AlertDialog(
//             title: const Text('Confirm'),
//             content: Text(request.message!),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   // Navigator.of(navigatorKey.currentContext!).pop();
//                   Navigator.of(AppRouter.globalNavigatorKey.currentContext!).pop();
//                   request.onCancelled?.call();
//                 },
//                 child: const Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigator.of(navigatorKey.currentContext!).pop();
//                   Navigator.of(AppRouter.globalNavigatorKey.currentContext!).pop();
//                   request.onConfirmed?.call();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//         break;
//       case DialogType.custom:
//         _showDialog(request.customWidget!);
//         break;
//       case DialogType.info:
//         // TODO: Handle this case.
//         throw UnimplementedError();
//     }
//   }
//
//   void _showDialog(Widget dialog) {
//     showDialog(
//       context: AppRouter.globalNavigatorKey.currentContext!,
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
//       // navigatorKey.currentState?.pop();
//       Navigator.of(AppRouter.globalNavigatorKey.currentContext!).pop();
//       _isShowing = false;
//       _tryNext();
//     }
//   }
// }

///
/// 2.
///
// class DialogController {
//   static final DialogController instance = DialogController._();
//   DialogController._();
//
//   late void Function() _showLoading;
//   late void Function() _hideLoading;
//   late void Function(DialogRequest request) _enqueueDialog;
//
//   bool _isLoadingVisible = false;
//   bool _isDialogVisible = false;
//
//   set isLoadingVisible(bool value) {
//     _isLoadingVisible = value;
//   }
//
//   set isDialogVisible(bool value) {
//     _isDialogVisible = value;
//   }
//
//   bool get isLoadingVisible => _isLoadingVisible;
//
//   bool get isDialogVisible => _isDialogVisible;
//
//   // 상태 변경 함수
//   void markLoadingVisible() => _isLoadingVisible = true;
//
//   void markLoadingHidden() => _isLoadingVisible = false;
//
//   void markDialogVisible() => _isDialogVisible = true;
//
//   void markDialogHidden() => _isDialogVisible = false;
//
//
//   /// 로딩 닫기 가능 유무
//   /// 로딩이 있거나  일반 다이얼로그가 있다면 불가
//   bool get isLoadingDisable => _isLoadingVisible == false || _isDialogVisible;
//
//   ///
//   /// DialogQueueListener에서 등록
//   ///
//   void register({
//     required void Function() showLoading,
//     required void Function() hideLoading,
//     required void Function(DialogRequest request) enqueueDialog,
//   }) {
//     _showLoading = () {
//       QcLog.d('_showLoading ===== $_isLoadingVisible');
//       if (_isLoadingVisible) return;
//       _isLoadingVisible = true;
//       showLoading();
//     };
//
//     _hideLoading = () {
//       QcLog.d('_hideLoading ===== $_isLoadingVisible , $_isDialogVisible');
//       if (!_isLoadingVisible && !_isDialogVisible) return;
//       _isLoadingVisible = false;
//       hideLoading();
//     };
//
//     _enqueueDialog = (request) {
//       QcLog.d('_enqueueDialog ===== $request');
//       enqueueDialog(request);
//     };
//   }
//
//   /// 로딩 띄우기
//   void showLoading() => _showLoading();
//
//   /// 로딩 지우기
//   void hideLoading() => _hideLoading();
//
//   /// 일반 다이얼로그 띄우기
//   void showAppDialog({
//     required String title,
//     required String message,
//     DialogType type = DialogType.info,
//     VoidCallback? onConfirmed,
//     VoidCallback? onCancelled,
//   }) {
//     _enqueueDialog(
//       DialogRequest(
//         title: title,
//         message: message,
//         type: type,
//         onConfirmed: onConfirmed,
//         onCancelled: onCancelled,
//       ),
//     );
//   }
//
//   void showError(String message) {
//     _enqueueDialog(
//       DialogRequest(
//         title: '에러',
//         message: message,
//         type: DialogType.error,
//         // onConfirmed: onConfirmed,
//       ),
//     );
//   }
// }

///
/// 3.
///
// class DialogController {
//   static final DialogController instance = DialogController._();
//   DialogController._();
//
//   final _queue = Queue<DialogRequest>();
//   bool _isShowing = false;
//
//   void showLoading() => _enqueue(DialogRequest.loading());
//   void showError(String message) => _enqueue(DialogRequest.error(message));
//
//   void hideLoading() {
//     if (_isShowing) {
//       navigatorKey.currentState?.pop();
//       _isShowing = false;
//       _tryNext();
//     }
//   }
//
//   void _enqueue(DialogRequest request) {
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
//       case DialogType.loading:
//         _showDialog(const Center(child: CircularProgressIndicator()));
//         break;
//       case DialogType.error:
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
