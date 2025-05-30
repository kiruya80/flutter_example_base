import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';

import '../../app/routes/app_router.dart';

///
/// 로딩 다이얼로그
///
class LoadingDialogManager {
  static bool _isShowing = false;

  static bool get isShowing => _isShowing;

  static Future<void> show() async {
    if (_isShowing) return;
    _isShowing = true;

    QcLog.d('loading show =====');
    showDialog(
      // context: AppRouter.globalNavigatorKey.currentState!.overlay!.context,
      context: AppRouter.globalNavigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (_) {
        return PopScope(
          canPop: !_isShowing, // 로딩 중이면 뒤로 가기 불가
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  static void hide() {
    if (_isShowing) {
      QcLog.d('loading hide =====');
      AppRouter.globalNavigatorKey.currentState?.pop();
      _isShowing = false;
    }
  }
}
