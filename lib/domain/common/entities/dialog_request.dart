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
      DialogRequest(type: DialogType.success, message: msg, onConfirm: onConfirm);

  factory DialogRequest.confirm(String msg, {VoidCallback? onConfirm, VoidCallback? onCancel}) =>
      DialogRequest(
        type: DialogType.confirm,
        message: msg,
        onConfirm: onConfirm,
        onCancel: onCancel,
      );

  factory DialogRequest.custom(Widget widget) =>
      DialogRequest(type: DialogType.custom, customWidget: widget);
}
