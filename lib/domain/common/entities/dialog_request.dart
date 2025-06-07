import 'dart:ui';

import 'package:flutter/cupertino.dart';

///
/// 다이얼로그 모델 정의
///
///  DialogRequest, DialogType – 다이얼로그 요청 모델
///
enum DialogType { loading, info, confirm, error, success, custom }

class DialogRequest {
  final DialogType type;
  final String? title;
  final String? message;
  final Widget? customWidget;
  final VoidCallback? onConfirmed;
  final VoidCallback? onCancelled;

  DialogRequest({
    required this.type,
    this.title,
    this.message,
    this.customWidget,
    this.onConfirmed,
    this.onCancelled,
  });

  factory DialogRequest.loading() => DialogRequest(type: DialogType.loading);

  factory DialogRequest.error(String msg) =>
      DialogRequest(type: DialogType.error, message: msg);

  factory DialogRequest.success(String msg) =>
      DialogRequest(type: DialogType.success, message: msg);

  factory DialogRequest.confirm(
    String msg,
    VoidCallback onConfirm,
    VoidCallback onCancel,
  ) => DialogRequest(
    type: DialogType.confirm,
    message: msg,
    onConfirmed: onConfirm,
    onCancelled: onCancel,
  );

  factory DialogRequest.custom(Widget widget) =>
      DialogRequest(type: DialogType.custom, customWidget: widget);

  @override
  String toString() {
    return 'DialogRequest{type: $type, title: $title, message: $message, customWidget: $customWidget, onConfirmed: $onConfirmed, onCancelled: $onCancelled}';
  }
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
