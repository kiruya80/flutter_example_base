import 'dart:ui';

///
/// 다이얼로그 모델 정의
///
enum DialogRequestType { info, confirm, error }
// enum _DialogType { loading, error, success, confirm, custom }

class DialogRequest {
  final String title;
  final String message;
  final DialogRequestType type;
  final VoidCallback? onConfirmed;
  final VoidCallback? onCancelled;

  DialogRequest({
    required this.title,
    required this.message,
    this.type = DialogRequestType.info,
    this.onConfirmed,
    this.onCancelled,
  });
}
// class _DialogRequest {
//   final _DialogType type;
//   final String? message;
//   final Widget? customWidget;
//   final VoidCallback? onConfirm;
//   final VoidCallback? onCancel;
//
//   _DialogRequest._({
//     required this.type,
//     this.message,
//     this.customWidget,
//     this.onConfirm,
//     this.onCancel,
//   });
//
//   factory _DialogRequest.loading() => _DialogRequest._(type: _DialogType.loading);
//   factory _DialogRequest.error(String msg) => _DialogRequest._(type: _DialogType.error, message: msg);
//   factory _DialogRequest.success(String msg) => _DialogRequest._(type: _DialogType.success, message: msg);
//   factory _DialogRequest.confirm(String msg, VoidCallback onConfirm, VoidCallback onCancel) =>
//       _DialogRequest._(type: _DialogType.confirm, message: msg, onConfirm: onConfirm, onCancel: onCancel);
//   factory _DialogRequest.custom(Widget widget) => _DialogRequest._(type: _DialogType.custom, customWidget: widget);
// }