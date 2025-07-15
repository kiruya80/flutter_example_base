import 'package:flutter/cupertino.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';

import '../constants/app_constants.dart';

class CommonUtils {
  /// 화면 넓이 가져오기
  /// 팝업에서는 1/2 최대
  ///
  static double getDisplayWidth(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    final leftInset = MediaQuery.of(context).padding.left;
    final rightInset = MediaQuery.of(context).padding.right;
    final displayWidth = totalWidth - leftInset - rightInset;
    // QcLog.d('displayWidth ====== $displayWidth , ($leftInset , $rightInset)');
    return displayWidth;
  }

  /// 화면 높이 가져오기
  /// 팝업에서는 1/2 최대
  ///
  static double getDisplayHeight(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top; // 상단 상태바
    final bottomInset = MediaQuery.of(context).padding.bottom; // 하단 시스템 영역 (네비게이션 바 등)
    final displayHeight = totalHeight - statusBarHeight - bottomInset;
    // QcLog.d('displayHeight ====== $displayHeight ($statusBarHeight ,$bottomInset)');
    return displayHeight;
  }

  /// 태블릿인지 여부
  /// 600dp 이상이면 태블릿으로 간주
  ///
  static bool isTablet(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    bool isTablet = shortestSide >= 600;
    QcLog.d('isTablet ====== $isTablet');
    return isTablet;
  }

  // final isTabletProvider = Provider<bool>((ref) {
  //   final context = ref.watch(navigatorKeyProvider).currentContext!;
  //   final shortestSide = MediaQuery.of(context).size.shortestSide;
  //   return shortestSide >= 600;
  // });

  ///
  /// 다이얼로그 가로 길이 가져오기
  /// ctDialogMaxWidth 보다 큰 경우 ctDialogMaxWidth로 설정
  /// 작은 경우는 화면 가로 기준
  ///
  // static double getDialogMaxWidth(BuildContext context) {
  //   double logicalWidth = MediaQuery.of(context).size.width;
  //   final pixelRatio = MediaQuery.of(context).devicePixelRatio;
  //   final physicalWidth = logicalWidth * pixelRatio;
  //   QcLog.d('getDialogMaxWidth ===== $pixelRatio , $logicalWidth, $physicalWidth');
  //
  //   return logicalWidth >= AppConstants.DialogMaxWidth ? AppConstants.DialogMaxWidth : logicalWidth;
  // }

  /// 팝업 최대 높이
  /// 갤럭시 s23 울트라 (3088 x 1440)  height 834(805), width : 411 ,
  ///
  /// 갤럭시 폴드3  (2208 × 1768) ( 2260 × 816) width : 793 (320)
  /// 갤럭시 폴드3  (2208 × 1768) (2268 × 832)
  /// 갤럭시 폴드4,5 (2176 × 1812) (2316 × 904)
  /// 갤럭시 폴드6 ( 2160 × 1856) , (2376 × 968)
  ///
  // static double getDialogMaxHeight(BuildContext context) {
  //   double totalHeight = MediaQuery.of(context).size.height;
  //   final statusBarHeight = MediaQuery.of(context).padding.top; // 상단 상태바
  //   final bottomInset = MediaQuery.of(context).padding.bottom; // 하단 시스템 영역 (네비게이션 바 등)
  //   final logicalHeight = totalHeight - statusBarHeight - bottomInset;
  //
  //   final pixelRatio = MediaQuery.of(context).devicePixelRatio;
  //   final physicalHeight = logicalHeight * pixelRatio;
  //   logUtil.debug('getDialogMaxHeight ===== $logicalHeight , $physicalHeight');
  //
  //   return logicalHeight >= Gc.ctDialogMaxHeight ? Gc.ctDialogMaxHeight : logicalHeight;
  // }

  static const double ctBottomMargin = 20.0;

  ///
  /// 바텀 버튼용 마진 구하기
  ///
  /// 아이폰 8 - EdgeInsets(0.0, 20.0, 0.0, 0.0) , 0.0, 16.0, ==== 16.0
  /// 아이폰15프로 맥스 - EdgeInsets(0.0, 59.0, 0.0, 34.0) , 34.0, 0.0, ==== 34.0
  ///
  /// 안드로이드 하드웨어키 - EdgeInsets(0.0, 24.0, 0.0, 0.0) , 0.0, 16.0, ==== 16.0
  /// 안드로이드 소프트키 - EdgeInsets(0.0, 28.6, 0.0, 0.0) , 0.0, 16.0, ==== 16.0
  ///
  static double getHomeBottomMargin(BuildContext context) {
    /// // iPhone 8: padding.bottom == 0
    /// // iPhone X: padding.bottom > 0 (보통 34px 정도)
    /// // 안드로이드 소프트키 : padding.bottom == 0
    final bottomInset = MediaQuery.of(context).padding.bottom;

    /// bottomInset이 0이 아닌 경우는 설정된 바텀 마진으로
    final extraBottomMargin = bottomInset == 0 ? 20.0 : 0.0;

    QcLog.d(
      'getHomeBottomMargin  ======= ${MediaQuery.of(context).padding} ,'
      ' bottomInset : $bottomInset, extraBottomMargin: $extraBottomMargin',
    );

    return extraBottomMargin;
  }
}
