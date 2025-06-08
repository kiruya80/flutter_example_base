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

/// 큐에 쌓이는 다이얼로그들
final dialogQueueProvider = StateProvider<List<DialogRequest>>((ref) => []);

/// 현재 다이얼로그가 떠 있는지 여부
final isDialogShowingProvider = StateProvider<bool>((ref) => false);

/// 로딩 다이얼로그 전용 상태
final isLoadingDialogShowingProvider = StateProvider<bool>((ref) => false);

class DialogController {
  final WidgetRef ref;

  DialogController(this.ref);

  bool get hasDialogs => ref.read(dialogQueueProvider).isNotEmpty;

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
      ref.read(dialogQueueProvider.notifier).state = ref.read(dialogQueueProvider).skip(1).toList();
    }

    /// 로딩 빼기
    _popDialogIfShowing(DialogType.loading);

    /// 상태 변경
    ref.read(isDialogShowingProvider.notifier).state = false;
    ref.read(isLoadingDialogShowingProvider.notifier).state = false;
  }

  void dismissCurrentDialog() {
    if (ref.read(dialogQueueProvider).isNotEmpty) {
      ref.read(dialogQueueProvider.notifier).state = ref.read(dialogQueueProvider).skip(1).toList();
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
    QcLog.d('dequeue ====  ${ref.read(dialogQueueProvider.notifier).state.length}');
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
