import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes/app_router.dart';

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
class DialogQueueManager extends StateNotifier<Queue<DialogRequest>> {
  DialogQueueManager() : super(Queue());

  ///
  /// 1.	enqueue()를 호출하면 DialogRequest가 큐에 추가됨.
  ///	2.	현재 다이얼로그가 표시 중이지 않다면, 자동으로 showDialog()가 실행됨.
  ///	3.	다이얼로그가 닫히면 dequeue()로 큐에서 제거되고, 다음 다이얼로그가 있으면 자동으로 이어서 표시됨.
  ///
  void enqueue(DialogRequest request) {
    state = Queue.of([...state, request]);
    QcLog.d('enqueue ==== ${state.isNotEmpty} , $length');
    // _tryShowNext();
  }

  void dequeue() {
    QcLog.d('dequeue ==== ${state.isNotEmpty} , $length');
    if (state.isNotEmpty) {
      final updated = Queue<DialogRequest>.from(state);
      updated.removeFirst();
      state = updated;
      QcLog.d('dequeue ==== ${state.isNotEmpty} , $length');
    }
  }

  void clear() {
    state = Queue();
  }

  DialogRequest? get current => state.isNotEmpty ? state.first : null;

  bool get isEmpty => state.isEmpty;

  int get length => state.length;
}

// app/services/dialog_request.dart

class DialogRequest {
  final String title;
  final String message;
  final VoidCallback? onConfirmed;

  DialogRequest({required this.title, required this.message, this.onConfirmed});
}
