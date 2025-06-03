// import 'package:flutter/material.dart';
// import 'package:async/async.dart';
// import 'package:flutter_example_base/core/utils/print_log.dart';
//
// import '../../app/routes/app_router.dart';
//
// class LoadingDialogManager {
//   CancelableCompleter<void>? _completer;
//
//   bool get isShowing => _completer?.isCompleted == false;
//
//   Future<void> show() async {
//     if (isShowing) return; // 이미 로딩 중이면 무시
//
//     _completer = CancelableCompleter<void>();
//
//     showDialog<void>(
//       // context: context,
//       context: _getDialogContext(),
//       barrierDismissible: false,
//       builder: (_) => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     ).then((_) {
//       // 다이얼로그가 닫히면 완료 처리
//       _completer?.complete();
//     });
//     QcLog.d('showDialog === ');
//
//     // 다이얼로그가 닫힐 때까지 기다림
//     await _completer?.operation.valueOrCancellation();
//   }
//
//   void dismiss() {
//     QcLog.d('dismiss ===  $isShowing');
//     if (!isShowing) return;
//
//     Navigator.of(_getDialogContext()).pop(); // 다이얼로그 닫기
// //       Navigator.of(AppRouter.globalNavigatorKey.currentContext!).pop();
//     _completer?.complete();
//     _completer = null;
//   }
//
//   /// ✅ 현재 다이얼로그가 떠 있는 context를 가져오는 방식 (예시)
//   BuildContext _getDialogContext() {
//     return AppRouter.globalNavigatorKey.currentContext!;
//   }
// }
//
// // class LoadingDialogManager {
// //   CancelableCompleter<void>? _completer;
// //
// //   Future<void> showLoadingDialog(BuildContext context) async {
// //     if (_completer?.isCompleted == false) return; // 이미 띄워졌으면 무시
// //
// //     _completer = CancelableCompleter<void>();
// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (_) => const Center(child: CircularProgressIndicator()),
// //     ).then((_) {
// //       _completer?.complete();
// //     });
// //
// //     await _completer?.operation.valueOrCancellation();
// //   }
// //
// //   void dismiss() {
// //     if (_completer?.isCompleted == false) {
// //       Navigator.of(AppRouter.globalNavigatorKey.currentContext!).pop();
// //       _completer?.complete();
// //     }
// //     _completer = null;
// //   }
// // }
