// 팝업 제어용 클래스
import 'dart:ui';

import 'package:flutter_example_base/core/utils/print_log.dart';

import 'dialog_request.dart';

///
/// 다이얼로그 컨트럴
///
class DialogController {

  late void Function() _showLoading;
  late void Function() _hideLoading;
  late void Function(DialogRequest request) _enqueueDialog;

  void showLoading() => _showLoading();
  void hideLoading() => _hideLoading();

  bool _isLoadingVisible = false;
  bool _isDialogVisible = false;

  // 상태 변경 함수
  void markLoadingVisible() => _isLoadingVisible = true;
  void markLoadingHidden() => _isLoadingVisible = false;
  void markDialogVisible() => _isDialogVisible = true;
  void markDialogHidden() => _isDialogVisible = false;

  set isLoadingVisible(bool value) {
    _isLoadingVisible = value;
  }

  set isDialogVisible(bool value) {
    _isDialogVisible = value;
  }

  bool get isLoadingVisible => _isLoadingVisible;
  bool get isDialogVisible => _isDialogVisible;
  bool get isAnyDialogVisible => _isLoadingVisible || _isDialogVisible;


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
      _enqueueDialog(request);
    };
  }


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
}

final dialogController = DialogController();