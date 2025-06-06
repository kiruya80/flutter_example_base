import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/routes/app_router.dart';
import 'dialog_controller.dart';
import 'dialog_request.dart';

///
/// DialogQueueListener – 큐 리스너 위젯
///
/// 	•	MaterialApp.router의 builder에 넣어 전역 다이얼로그 큐 소비
/// 	•	ref.listen으로 dialogQueue가 바뀔 때 자동으로 다이얼로그 띄움
///
class DialogQueueListener extends ConsumerStatefulWidget {
  final Widget child;

  const DialogQueueListener({super.key, required this.child});

  @override
  ConsumerState<DialogQueueListener> createState() => _DialogQueueListenerState();
}

class _DialogQueueListenerState extends ConsumerState<DialogQueueListener> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(_processQueue);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(dialogQueueProvider, (previous, next) => _processQueue());

    ref.listen<List<DialogRequest>>(dialogQueueProvider, (prev, next) async {
      QcLog.d(
        'ref.listen dialogQueueProvider ==== ${next.isNotEmpty} & ${prev?.length} , ${next.length} ,'
        '${ref.read(isDialogShowingProvider)}',
      );
      if (ref.read(isDialogShowingProvider)) return;
      if (next.isEmpty) return;

      final request = next.first;
      await _showDialogByType(AppRouter.globalNavigatorKey.currentContext!, request);
    });

    return widget.child;
  }

  Future<void> _processQueue() async {
    QcLog.d('_processQueue ====  ');
    final isShowing = ref.read(isDialogShowingProvider);
    final queue = ref.read(dialogQueueProvider);

    if (isShowing || queue.isEmpty) return;
    final request = queue.first;

    ref.read(isDialogShowingProvider.notifier).state = true;
    if (request.type == DialogType.loading) {
      ref.read(isLoadingDialogShowingProvider.notifier).state = true;
    }

    await _showDialogByType(AppRouter.globalNavigatorKey.currentContext!, request);

    // 다이얼로그 닫힌 후 상태 정리
    // ref.read(dialogQueueProvider.notifier).state = queue.skip(1).toList();
    // ref.read(isDialogShowingProvider.notifier).state = false;
    // if (request.type == DialogType.loading) {
    //   ref.read(isLoadingDialogShowingProvider.notifier).state = false;
    // }

    QcLog.d('다이얼로그 종료 후 큐 갱신 ==== ');

    /// 다이얼로그 상태 false 업데이트
    ref.read(isDialogShowingProvider.notifier).state = false;

    /// 다이얼로그 큐 또는 로딩 다이얼로그 false 업데이트
    if (request.type == DialogType.loading) {
      ref.read(isLoadingDialogShowingProvider.notifier).state = false;
    } else {
      final queue = ref.read(dialogQueueProvider);
      ref.read(dialogQueueProvider.notifier).state = queue.skip(1).toList();
    }
  }

  Future<void> _showDialogByType(BuildContext context, DialogRequest request) async {
    QcLog.d('_showDialogByType  ==== ${request.toString()}');
    ref.read(isDialogShowingProvider.notifier).state = true;
    switch (request.type) {
      case DialogType.loading:
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) =>   Center(child: GestureDetector(
              onLongPress: () {
                if (kDebugMode) {
                  Navigator.of(context).pop();
                }
              },
              child: CircularProgressIndicator())),
        );
        break;
      case DialogType.error:
      case DialogType.success:
        await showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Text(request.title ?? ''),
                content: Text(request.message ?? ''),
                actions: [
                  if (request.onCancelled != null)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        request.onCancelled?.call();
                      },
                      child: const Text('취소'),
                    ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      request.onConfirmed?.call();
                    },
                    child: const Text('확인'),
                  ),
                ],
              ),
        );
        break;
      case DialogType.custom:
      case DialogType.info:
        await showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Text(request.title ?? '알림'),
                content: Text(request.message ?? ''),
                actions: [
                  if (request.onCancelled != null)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        request.onCancelled?.call();
                      },
                      child: const Text('취소'),
                    ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      request.onConfirmed?.call();
                    },
                    child: const Text('확인'),
                  ),
                ],
              ),
        );
        break;

      case DialogType.confirm:
        await showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Text(request.title ?? ''),
                content: request.customWidget ?? Text(request.message ?? ''),
                actions: [
                  if (request.onCancelled != null)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        request.onCancelled?.call();
                      },
                      child: const Text('취소'),
                    ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      request.onConfirmed?.call();
                    },
                    child: const Text('확인'),
                  ),
                ],
              ),
        );
        break;
    }
  }

  // bool _isShowingDialog = false;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   DialogController.instance.register(
  //     showLoading: _showLoading,
  //     hideLoading: _hideLoading,
  //     enqueueDialog: (request) {
  //       ref.read(dialogQueueProvider.notifier).enqueue(request);
  //     },
  //   );
  // }
  //
  // void _showLoading() {
  //   QcLog.d('_showLoading ===== ${DialogController.instance.isLoadingVisible}');
  //   // if (DialogController.instance.isLoadingVisible) return;
  //   // DialogController.instance.isLoadingVisible = true;
  //   // ref.read(globalLoadingProvider.notifier).state = true;
  //
  //   showDialog(
  //     context: AppRouter.globalNavigatorKey.currentContext!,
  //     barrierDismissible: false,
  //     builder: (_) => const Center(child: CircularProgressIndicator()),
  //   );
  // }
  //
  // void _hideLoading() {
  //   QcLog.d('_showLoading ===== ${DialogController.instance.isLoadingDisable}');
  //   if (DialogController.instance.isLoadingDisable == false) {
  //     return;
  //   }
  //
  //   if (Navigator.of(AppRouter.globalNavigatorKey.currentContext!, rootNavigator: true).canPop()) {
  //     Navigator.of(AppRouter.globalNavigatorKey.currentContext!, rootNavigator: true).pop();
  //   }
  //
  //   DialogController.instance.markLoadingHidden(); // ✅ 안전하게 상태 변경
  //   // DialogController.instance.isLoadingVisible = false;
  //   ref.read(globalLoadingProvider.notifier).state = false;
  // }
  //
  // void _tryShowNextDialog() {
  //   final isLoading = ref.read(globalLoadingProvider);
  //   final queue = ref.read(dialogQueueProvider);
  //
  //   if (_isShowingDialog || isLoading || queue.isEmpty) return;
  //
  //   final request = queue.first;
  //   _isShowingDialog = true;
  //   DialogController.instance.markDialogVisible();
  //
  //   showDialog(
  //     context: AppRouter.globalNavigatorKey.currentContext!,
  //     barrierDismissible: false,
  //     builder:
  //         (_) => AlertDialog(
  //           title: Text(request.title ?? ''),
  //           content: Text(request.message?? ''),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(AppRouter.globalNavigatorKey.currentContext!).pop();
  //                 request.onConfirmed?.call();
  //               },
  //               child: const Text('확인'),
  //             ),
  //             if (request.onCancelled != null)
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(AppRouter.globalNavigatorKey.currentContext!).pop();
  //                   request.onCancelled?.call();
  //                 },
  //                 child: const Text('취소'),
  //               ),
  //           ],
  //         ),
  //   ).then((_) {
  //     ref.read(dialogQueueProvider.notifier).dequeue();
  //     DialogController.instance.markDialogHidden();
  //     _isShowingDialog = false;
  //     _tryShowNextDialog(); // 다음 다이얼로그가 있으면 또 표시
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   // _loadingSub.close();
  //   // _dialogSub.close();
  //   super.dispose();
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   ref.listen(globalLoadingProvider, (prev, next) {
  //     if (!next) _tryShowNextDialog();
  //   });
  //
  //   ref.listen(dialogQueueProvider, (prev, next) {
  //     _tryShowNextDialog();
  //   });
  //
  //   return widget.child;
  // }
}

// class _DialogQueueListenerState extends ConsumerState<DialogQueueListener> {
//   bool _isShowingDialog = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     DialogController.instance.register(
//       showLoading: _showLoading,
//       hideLoading: _hideLoading,
//       enqueueDialog: (request) {
//         ref.read(dialogQueueProvider.notifier).enqueue(request);
//       },
//     );
//   }
//
//   ///
//   /// 로딩 다이얼로그 띄위기
//   /// 현재 로딩이 있으면 패스
//   /// 일반 다이얼로그가 있는 경우는??
//   ///
//   void _showLoading() {
//     final loading = ref.read(globalLoadingProvider);
//     QcLog.d('_showLoading === $loading , _isShowingDialog == $_isShowingDialog');
//     if (loading == true) {
//       return;
//     }
//     ref.read(globalLoadingProvider.notifier).state = true;
//
//     _showLoadingDialog();
//   }
//
//   void _showLoadingDialog() {
//     showDialog(
//       context: AppRouter.globalNavigatorKey.currentContext!,
//       barrierDismissible: false,
//       builder:
//           (_) => Center(
//             child: GestureDetector(
//               onLongPress: () {
//                 if (kDebugMode) {
//                   _hideLoading();
//                 }
//               },
//               child: CircularProgressIndicator(),
//             ),
//           ),
//     );
//   }
//
//   ///
//   /// 다이얼로그 감추기
//   /// 로딩이 있는 경우와 일반 다이얼로그가 없는 경우에는
//   ///
//   void _hideLoading() {
//     final loading = ref.read(globalLoadingProvider);
//     QcLog.d('_hideLoading === $loading, _isShowingDialog == $_isShowingDialog');
//     if (loading == false || _isShowingDialog) {
//       return;
//     }
//
//     _hideDialog();
//   }
//
//   void _hideDialog() {
//     if (Navigator.of(AppRouter.globalNavigatorKey.currentContext!, rootNavigator: true).canPop()) {
//       Navigator.of(AppRouter.globalNavigatorKey.currentContext!, rootNavigator: true).pop();
//     }
//   }
//
//   void _tryShowNextDialog() {
//     final loading = ref.read(globalLoadingProvider);
//     final queue = ref.read(dialogQueueProvider);
//     QcLog.d('_tryShowNextDialog === $loading ${queue.isNotEmpty ? queue.first : ''}');
//
//     if (_isShowingDialog || loading || queue.isEmpty) return;
//
//     final request = queue.first;
//     _isShowingDialog = true;
//
//     showDialog(
//       context: AppRouter.globalNavigatorKey.currentContext!,
//       barrierDismissible: false,
//       builder: (_) => _buildDialog(request),
//     ).then((_) {
//       ref.read(dialogQueueProvider.notifier).dequeue();
//       _isShowingDialog = false;
//       _tryShowNextDialog();
//     });
//   }
//
//   Widget _buildDialog(DialogRequest request) {
//     return AlertDialog(
//       title: Text(request.title),
//       content: Text(request.message),
//       actions: [
//         if (request.type == DialogRequestType.confirm)
//           TextButton(
//             onPressed: () {
//               Navigator.of(AppRouter.globalNavigatorKey.currentContext!).pop();
//               request.onCancelled?.call();
//             },
//             child: const Text('취소'),
//           ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(AppRouter.globalNavigatorKey.currentContext!).pop();
//             request.onConfirmed?.call();
//           },
//           child: const Text('확인'),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // ref.listen(globalLoadingProvider, (prev, next) {
//     //   QcLog.d('listen ===== globalLoadingProvider === $prev , $next |  ${ref.read(globalLoadingProvider.notifier).state}');
//     //   if (next == true) {
//     //     _showLoadingDialog();
//     //   } else {
//     //     if (_isShowingDialog == false) _hideDialog();
//     //     // _hideLoading();
//     //   }
//     // });
//     //
//     // ref.listen(dialogQueueProvider, (prev, next) {
//     //   _tryShowNextDialog();
//     // });
//
//     return widget.child;
//   }
// }

// class _DialogQueueListenerState extends ConsumerState<DialogQueueListener> {
//   bool _isShowing = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // register controller methods
//     DialogController.instance.register(
//       showLoading: _showLoading,
//       hideLoading: _dismissDialog,
//       showDialog: _showDialog,
//     );
//
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   // 로딩 다이얼로그 상태 리스너
//     //   ref.listen<bool>(globalLoadingProvider, (prev, next) {
//     //     if (next && !_isShowing) {
//     //       _showLoading();
//     //     } else if (!next && _isShowing) {
//     //       _dismissDialog();
//     //     }
//     //   });
//     //
//     //   // 일반 다이얼로그 큐 상태 리스너
//     //   ref.listen<Queue<DialogRequest>>(dialogQueueProvider, (prev, next) {
//     //     if (!_isShowing && ref.read(globalLoadingProvider) == false && next.isNotEmpty) {
//     //       _showDialog(next.first);
//     //     }
//     //   });
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // 로딩 다이얼로그 상태 리스너
//     ref.listen<bool>(globalLoadingProvider, (prev, next) {
//       if (next && !_isShowing) {
//         _showLoading();
//       } else if (!next && _isShowing) {
//         _dismissDialog();
//       }
//     });
//
//     // 일반 다이얼로그 큐 상태 리스너
//     ref.listen<Queue<DialogRequest>>(dialogQueueProvider, (prev, next) {
//       if (!_isShowing && ref.read(globalLoadingProvider) == false && next.isNotEmpty) {
//         _showDialog(next.first);
//       }
//     });
//
//     return widget.child;
//   }
//
//   void _showLoading() {
//     QcLog.d('_showLoading === ');
//     _isShowing = true;
//     showDialog(
//       context: AppRouter.globalNavigatorKey.currentContext!,
//       barrierDismissible: false,
//       builder: (_) => const Center(child: CircularProgressIndicator()),
//     );
//   }
//
//   void _dismissDialog() {
//     QcLog.d('_dismissDialog === ');
//     Navigator.of(AppRouter.globalNavigatorKey.currentContext!, rootNavigator: true).pop();
//     _isShowing = false;
//
//     // 로딩이 끝났고 큐에 다이얼로그가 있다면
//     final queue = ref.read(dialogQueueProvider);
//     if (queue.isNotEmpty) {
//       Future.microtask(() => _showDialog(queue.first));
//     }
//   }
//
//   void _showDialog(DialogRequest request) async {
//     QcLog.d('_showDialog === $request');
//     if (_isShowing == true) {
//       return;
//     }
//     _isShowing = true;
//
//     await showDialog(
//       context: AppRouter.globalNavigatorKey.currentContext!,
//       barrierDismissible: false,
//       builder:
//           (_) => AlertDialog(
//             title: Text(request.title),
//             content: Text(request.message),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(AppRouter.globalNavigatorKey.currentContext!).pop();
//                   request.onConfirmed?.call();
//                 },
//                 child: const Text('확인'),
//               ),
//             ],
//           ),
//     );
//
//     ref.read(dialogQueueProvider.notifier).dequeue();
//     _isShowing = false;
//
//     final queue = ref.read(dialogQueueProvider);
//     if (queue.isNotEmpty) {
//       Future.microtask(() => _showDialog(queue.first));
//     }
//   }
//
// }
