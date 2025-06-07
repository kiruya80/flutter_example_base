import 'dart:ui';

import 'package:flutter/cupertino.dart';

///
/// 다이얼로그 모델 정의
///
///  DialogRequest, DialogType – 다이얼로그 요청 모델
///
enum DialogType { loading, confirm, error, success, custom }

class DialogRequest {
  final DialogType type;
  final String? title;
  final String? message;
  final Widget? customWidget;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  DialogRequest({
    required this.type,
    this.title,
    this.message,
    this.customWidget,
    this.onConfirm,
    this.onCancel,
  });

  factory DialogRequest.loading() => DialogRequest(type: DialogType.loading);

  factory DialogRequest.error(String msg, {VoidCallback? onConfirm}) =>
      DialogRequest(type: DialogType.error, message: msg, onConfirm: onConfirm);

  factory DialogRequest.success(String msg, {VoidCallback? onConfirm}) =>
      DialogRequest(
        type: DialogType.success,
        message: msg,
        onConfirm: onConfirm,
      );

  factory DialogRequest.confirm(
    String msg, {
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) => DialogRequest(
    type: DialogType.confirm,
    message: msg,
    onConfirm: onConfirm,
    onCancel: onCancel,
  );

  factory DialogRequest.custom(Widget widget) =>
      DialogRequest(type: DialogType.custom, customWidget: widget);

  @override
  String toString() {
    return 'DialogRequest{type: $type, title: $title, message: $message, customWidget: $customWidget, onConfirm: $onConfirm, onCancel: $onCancel}';
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
