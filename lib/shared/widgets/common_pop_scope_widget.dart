import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';

///
///
/// 안드로이드 키보드 올라오는 경우 백키 처리 위젯
/// 일부 안드로이드 버전에서 백키시 1.키보드내리고 언포커스, 2.키보드만 내리기 등 다르다
///
class CommonPopScopeWidget extends StatefulWidget {
  final bool? canPop;

  /// 뒤로 가기 막아야할때 false
  final Widget child;
  final Function? onPressedPopScope; // 백버튼

  const CommonPopScopeWidget({super.key, this.canPop, this.onPressedPopScope, required this.child});

  @override
  State<CommonPopScopeWidget> createState() => _CommonPopScopeWidgetState();
}

class _CommonPopScopeWidgetState extends State<CommonPopScopeWidget> {
  FocusScopeNode? currentFocus;
  bool isCanPop = false;
  bool regListener = false;

  bool? canPop;

  @override
  void dispose() {
    if (Platform.isAndroid) {
      currentFocus?.removeListener(_focusListener);
    }
    super.dispose();
  }

  void _focusListener() {
    _defaultCanPop();
  }

  @override
  void initState() {
    super.initState();
    canPop = widget.canPop;
  }

  /**
   * 영역 터치
      I/flutter ( 6643): build hasPrimaryFocus =====   false
      I/flutter ( 6643): build hasFocus =====   false
      I/flutter ( 6643): build focusedChild =====   FocusNode#1f2bf(context: Focus)
      /// currentFocus.hasFocus 추가이유는 영역터치로 키보드 내리는 경우 hasPrimaryFocus값이 true로 변경 안됨
   */
  _defaultCanPop() {
    isCanPop =
        (currentFocus?.hasPrimaryFocus == true && currentFocus?.hasFocus == true) ||
        (currentFocus?.hasPrimaryFocus == false && currentFocus?.hasFocus == false);
  }

  @override
  Widget build(BuildContext context) {
    /// ios인 경우 스와이프 백을 막아야할때 canPop으로 설정
    if (Platform.isIOS == true) {
      return PopScope(canPop: canPop ?? true, child: widget.child);
    }

    /// 안드로이드 인 경우 키보드 올라오는 경우, 백키로 키보드 내리기 위해서
    currentFocus = FocusScope.of(context);
    if (!regListener) {
      currentFocus?.addListener(_focusListener);
      regListener = true;
    }

    _defaultCanPop();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        // final route = ModalRoute.of(context);
        // final routeName = route?.settings.name;
        QcLog.d(
          'onPopInvokedWithResult ======== didPop: $didPop , $result ,'
          ' canPop: $canPop, isCanPop: $isCanPop,  ',
        );
        // if (Platform.isIOS == true) {
        //   return;
        // }

        if (currentFocus?.hasPrimaryFocus == false &&
            currentFocus?.focusedChild != null &&
            currentFocus?.focusedChild?.hasPrimaryFocus == true) {
          FocusManager.instance.primaryFocus?.unfocus();
          FocusScope.of(context).unfocus();
          return;
        }

        if (canPop != null) {
          /// canPop 값을 넘겨받고
          /// true : 화면 종료
          /// false : 백키 막기
          if (canPop == true) {
            Navigator.pop(context, result);
          } else {
            if (widget.onPressedPopScope != null) {
              widget.onPressedPopScope!(result);
            }
            return;
          }
        } else {
          if (!didPop) {
            /// 리턴값이 있어 pop을 해야하는 경우 maybePop 로 하는 경우
            /// 다시 onPopInvokedWithResult 반복된다
            /// auto router는 maybePop만 있어 Navigator.pop으로 한다
            /// maybePop는 왜 안되는지
            if (widget.onPressedPopScope != null) {
              widget.onPressedPopScope!();
            } else {
              Navigator.pop(context, result);
            }

            /// context.router.maybePop(result); 무한 반복
          }
        }
      },
      child: widget.child,
    );
  }
}
