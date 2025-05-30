import 'package:flutter/material.dart';
import 'package:flutter_example_base/app/services/loading/dialog_queue_manager.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/providers/dialog_queue_manager.dart';
import '../../app/routes/app_router.dart';

///
/// 실제 다이얼로그
///
/// 다이얼로그 보여주기/리스닝
/// DialogQueueListener (Widget)
/// ✅ showDialog() 호출해서 화면에 띄움1
///
class DialogQueueListener extends ConsumerStatefulWidget {
  final Widget child;

  const DialogQueueListener({super.key, required this.child});

  @override
  ConsumerState<DialogQueueListener> createState() => _DialogQueueListenerState();
}

class _DialogQueueListenerState extends ConsumerState<DialogQueueListener> {
  bool _isShowing = false;

  @override
  void didUpdateWidget(DialogQueueListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    QcLog.d('didUpdateWidget ==== ');
    // _processQueue();
  }

  @override
  void initState() {
    super.initState();
    QcLog.d('initState ==== ');
    // WidgetsBinding.instance.addPostFrameCallback((_) => _processQueue());
  }

  @override
  Widget build(BuildContext context) {
    //   ref.listen(dialogQueueProvider, (_, __) => _processQueue());
    ref.listen(dialogQueueProvider, (previous, next) async {
      QcLog.d('build listen ===== $_isShowing,  ${previous?.isEmpty},  ${next.isEmpty}');
      if (_isShowing || next.isEmpty) return;
      processQueue(next.first);
    });

    return widget.child;
  }

  void processQueue(DialogRequest dialog) async {
    // final dialog = next.first;
    _isShowing = true;

    await showDialog(
      // context: AppRouter.globalNavigatorKey.currentState!.overlay!.context,
      context: AppRouter.globalNavigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(dialog.title),
        content: Text(dialog.message),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.of(context).pop();
              AppRouter.globalNavigatorKey.currentState?.pop();
              dialog.onConfirmed?.call(); // 확인 시 콜백 실행
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );

    setState(() {
      _isShowing = false;
      ref.read(dialogQueueProvider.notifier).dequeue();
      QcLog.d('_isShowing ===== $_isShowing');
    });
  }

  void _processQueue() async {
    final queue = ref.read(dialogQueueProvider);

    if (!_isShowing && queue.isNotEmpty) {
      _isShowing = true;

      final request = queue.first;

      await showDialog(
        // context: AppRouter.globalNavigatorKey.currentState!.overlay!.context,
        context: AppRouter.globalNavigatorKey.currentContext!,
        builder: (_) => AlertDialog(
          title: Text(request.title),
          content: Text(request.message),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                AppRouter.globalNavigatorKey.currentState?.pop();
              },
              child: const Text('확인'),
            )
          ],
        ),
      );

      ref.read(dialogQueueProvider.notifier).dequeue();

      _isShowing = false;

      WidgetsBinding.instance.addPostFrameCallback((_) => _processQueue());
    }
  }
}
