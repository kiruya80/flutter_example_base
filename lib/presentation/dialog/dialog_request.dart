import 'dart:ui';

///
/// 다이얼로그 모델 정의
///
enum DialogRequestType { info, confirm, error }

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