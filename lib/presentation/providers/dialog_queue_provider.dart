import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dialog/dialog_request.dart';

// final dialogQueueProvider = StateNotifierProvider<DialogQueueManager, Queue<DialogRequest>>(
//   (ref) => DialogQueueManager(),
// );

final dialogQueueProvider = StateNotifierProvider<DialogQueueNotifier, Queue<DialogRequest>>(
  (ref) => DialogQueueNotifier(),
);

///
/// 일반 다이얼로그 큐 (FIFO)
///
class DialogQueueNotifier extends StateNotifier<Queue<DialogRequest>> {
  DialogQueueNotifier() : super(Queue());

  DialogRequest? get current => state.isNotEmpty ? state.first : null;

  bool get isEmpty => state.isEmpty;

  int get length => state.length;

  void enqueue(DialogRequest request) {
    state = Queue.of([...state, request]);
  }

  void dequeue() {
    // if (state.isNotEmpty) {
    //   state.removeFirst();
    //   state = Queue.of(state);
    // }
    final newQueue = Queue.of(state);
    if (newQueue.isNotEmpty) {
      newQueue.removeFirst();
      state = newQueue;
    }
  }

  void clear() {
    state.clear();
    state = Queue();
  }
}

///
/// 다이얼로그 큐 매니져
///
/// DialogQueueManager (또는 DialogQueueProvider)는 단순히 다이얼로그 요청들을
/// 관리하는 상태 저장소 역할만 합니다.
/// 실제로 showDialog()를 호출해서 화면에 다이얼로그를 띄우는 건
/// DialogQueueListener 같은 UI 위젯 쪽에서 합니다.
///
/// 다이얼로그 요청 관리
/// DialogQueueManager (StateNotifier)
/// ❌ 호출 안 함 (상태만 관리)
///
// class DialogQueueManager extends StateNotifier<Queue<DialogRequest>> {
//   DialogQueueManager() : super(Queue());
//
//   ///
//   /// 1.	enqueue()를 호출하면 DialogRequest가 큐에 추가됨.
//   ///	2.	현재 다이얼로그가 표시 중이지 않다면, 자동으로 showDialog()가 실행됨.
//   ///	3.	다이얼로그가 닫히면 dequeue()로 큐에서 제거되고, 다음 다이얼로그가 있으면 자동으로 이어서 표시됨.
//   ///
//   void enqueue(DialogRequest request) {
//     state = Queue.of([...state, request]);
//     QcLog.d('enqueue ==== ${state.isNotEmpty} , $length');
//     // _tryShowNext();
//   }
//
//   void dequeue() {
//     QcLog.d('dequeue ==== ${state.isNotEmpty} , $length');
//     if (state.isNotEmpty) {
//       final updated = Queue<DialogRequest>.from(state);
//       updated.removeFirst();
//       state = updated;
//       QcLog.d('dequeue ==== ${state.isNotEmpty} , $length');
//     }
//   }
//
//   void clear() {
//     state = Queue();
//   }
//
//   DialogRequest? get current => state.isNotEmpty ? state.first : null;
//
//   bool get isEmpty => state.isEmpty;
//
//   int get length => state.length;
// }
