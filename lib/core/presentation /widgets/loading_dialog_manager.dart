import 'package:flutter/material.dart';

import '../../../app/routes/app_router.dart';

///
/// 로딩 매니져
///
class LoadingDialogManager {
  static bool _isDialogShowing = false;

  static void show({BuildContext? context}) {
    if (_isDialogShowing) return;
    _isDialogShowing = true;

    showDialog(
      // context: context,
      context: AppRouter.globalNavigatorKey.currentState!.overlay!.context,
      barrierDismissible: false,
      builder: (_) {
        return PopScope(
          canPop: !_isDialogShowing, // 로딩 중이면 뒤로 가기 불가
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  static void hide() {
    if (_isDialogShowing) {
      AppRouter.globalNavigatorKey.currentState?.pop();
      //     Navigator.of(context, rootNavigator: true).pop();
      _isDialogShowing = false;
    }
  }
}
