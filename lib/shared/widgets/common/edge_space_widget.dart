import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/device_info_utils.dart';

///
/// 엣지투엣지인 화면인 경우 탑 또는 바텀 빈공간 주기
///
/// 엣지이던 아니던 하드웨어가 있던 없던
/// 예) 바텀네이게이션 위 동일한 마진위에 위젯이 위치하게
///
/// android os 15미만인 경우라도 top은 엣지투엣지가 먹는다
///
class BottomEdgeSpaceWidget extends ConsumerStatefulWidget {
  final bool isBottom;
  final bool isEdgeToEdge;

  const BottomEdgeSpaceWidget({super.key, this.isBottom = true, this.isEdgeToEdge = true});

  @override
  ConsumerState<BottomEdgeSpaceWidget> createState() => _BottomEdgeSpaceWidgetState();
}

class _BottomEdgeSpaceWidgetState extends ConsumerState<BottomEdgeSpaceWidget> {
  @override
  Widget build(BuildContext context) {
    // return SizedBox(height: getEdgeSpaceHeight());
    return SizedBox(
      height: DeviceInfoUtils.instance.getEdgeSpaceHeight(
        context,
        isBottom: widget.isBottom,
        isEdgeToEdge: widget.isEdgeToEdge,
      ),
    );
  }

  // static const double DEFAULT_TOP_MAGGIN = 20.0;
  // static const double DEFAULT_BOTTOM_MAGGIN = 34.0;
  // double getEdgeSpaceHeight() {
  //   QcLog.d('getEdgeSpaceHeight ==== ${widget.isEdgeToEdge}');
  //   if (widget.isEdgeToEdge == false) {
  //     /// 엣지가 아닌 경우는 0 반환
  //     return 0;
  //   }
  //
  //   double extraMargin = 0;
  //
  //   /// 아이폰 se3 > EdgeInsets.zero
  //   final padding = MediaQuery.of(context).padding;
  //
  //   /// 엣지 화면인지
  //   if (widget.isBottom) {
  //     if (Platform.isAndroid && DeviceInfoUtils.instance.sdkInt < 35) {
  //       /// android os 15, sdk 35 미만인 경우 bottom은 엣지투엣지가 안되서 0
  //       extraMargin = padding.bottom;
  //     } else {
  //       /// 아이폰 하드웨어키, 안드로이드 os15이전 버전등은 EdgeInsets이 0으로 기본 마진 주기
  //       if (Platform.isIOS && isHomeBtnIos()) {
  //         /// ios 홈버튼이 있는 경우
  //         extraMargin = 0;
  //       } else {
  //         extraMargin = padding.bottom == 0 ? DEFAULT_BOTTOM_MAGGIN : padding.bottom;
  //       }
  //     }
  //   } else {
  //     /// 아이폰 하드웨어키, 안드로이드 os15이전 버전등은 EdgeInsets이 0으로 기본 마진 주기
  //     /// android os 15, sdk 35 미만인 경우, top은 엣지투엣지가 먹는다 top
  //     extraMargin = padding.top == 0 ? DEFAULT_TOP_MAGGIN : padding.top;
  //   }
  //
  //   QcLog.d(
  //     'padding  ======= ${MediaQuery.of(context).padding} ,'
  //     'return extraMargin: $extraMargin',
  //   );
  //   return extraMargin;
  // }
  //
  // bool isHomeBtnIos() {
  //   if (MediaQuery.of(context).padding.bottom > 0) {
  //     // 홈 인디케이터 있는 iPhone → 하드웨어키 없음
  //     return false;
  //   } else {
  //     // 홈 인디케이터 없음 → 하드웨어 홈버튼 있을 가능성 높음
  //     return true;
  //   }
  // }
}
