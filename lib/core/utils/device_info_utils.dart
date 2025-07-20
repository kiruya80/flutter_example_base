import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';

import '../constants/app_constants.dart';

///
/// 디바이스 유틸
///
/// final deviceInfo = DeviceInfoUtils(); or
/// DeviceInfoUtils.instance
///
class DeviceInfoUtils {
  // 싱글톤 인스턴스
  static final DeviceInfoUtils _instance = DeviceInfoUtils._internal();

  static DeviceInfoUtils get instance => _instance;

  // factory constructor
  factory DeviceInfoUtils() {
    return _instance;
  }

  // private constructor
  DeviceInfoUtils._internal();

  // 디바이스 정보 저장
  late final String deviceModel;
  late final String osVersion;
  late int _sdkInt;
  late final String deviceId;

  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  int get sdkInt => _sdkInt;
  static const double DEFAULT_TOP_MAGGIN = 20.0;
  static const double DEFAULT_BOTTOM_MAGGIN = 34.0;

  /// 초기화 (앱 시작 시 1회 호출)
  ///
  /// 엣지투엣지 안드로이드는 os 15, sdk 35부터
  ///
  /// isAndroid
  /// deviceModel : SM-S931N ,
  /// osVersion : 15 ,
  /// sdkInt : 35 ,
  /// deviceId : AP3A.123456.123.A2
  ///
  /// isIOS
  /// deviceModel : iPhone17,1 ,
  /// osVersion :  18.1 ,
  /// sdkInt : 0 ,
  /// deviceId : C1B56CFB-F109-1234-5678-CE9A7C8B5AC3 ,
  ///
  Future<void> init() async {
    _sdkInt = 0;
    if (Platform.isAndroid) {
      final info = await _deviceInfoPlugin.androidInfo;
      // deviceModel = '${info.manufacturer} ${info.model}'; // info.manufacturer samsung
      deviceModel = info.model;
      osVersion = info.version.release;
      _sdkInt = info.version.sdkInt;
      deviceId = info.id;
    } else if (Platform.isIOS) {
      final info = await _deviceInfoPlugin.iosInfo;
      deviceModel = info.utsname.machine;
      // osVersion = '${info.systemName}|${info.systemVersion}'; // info.systemName : iOS
      osVersion = info.systemVersion;
      deviceId = info.identifierForVendor ?? 'unknown';
    } else {
      deviceModel = 'Unknown';
      osVersion = 'Unknown';
      _sdkInt = -1;
      deviceId = 'Unknown';
    }

    QcLog.d(
      'init device  : deviceModel : $deviceModel , osVersion : $osVersion , '
      'sdkInt : $_sdkInt , deviceId : $deviceId , ',
    );
  }

  /// 화면 넓이 가져오기
  /// 팝업에서는 1/2 최대
  ///
  double getDisplayWidth(BuildContext context) {
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
  double getDisplayHeight(BuildContext context) {
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
  bool isTablet(BuildContext context) {
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

  ///
  /// EdgeToEdge 인 경우 바텀까지 다 사용하는 경우
  /// 바텀 여유공간 높이 가져오기 왜? 하단에 버튼등이 있는 경우 네비게이션이나 홈 인디게이터와 겹쳐서
  ///
  ///
  /// 아이폰 8 - EdgeInsets(0.0, 20.0, 0.0, 0.0) , bottomInset : 0.0, extraMargin: DEFAULT_BOTTOM_MAGGIN,
  /// 아이폰15프로 맥스 - EdgeInsets(0.0, 59.0, 0.0, 34.0) , bottomInset : 34.0, extraMargin: 0.0,
  ///
  /// 안드로이드 하드웨어키 - EdgeInsets(0.0, 24.0, 0.0, 0.0) , bottomInset : 0.0, === return extraMargin: 16.0,
  /// 안드로이드 소프트키 - EdgeInsets(0.0, 28.6, 0.0, 0.0) , bottomInset : 0.0, === return extraMargin:  16.0,
  ///
  /// 갤럭시 S25[os15]  엣지투엣지
  /// ㄴ EdgeInsets(0.0, 34.7, 0.0, 48.0) , bottomInset : 48.0, === return extraMargin: 0.0
  ///
  double getEdgeSpaceHeight(
    BuildContext context, {
    bool? isBottom = true,
    bool? isEdgeToEdge = true,
  }) {
    // QcLog.d('getEdgeSpaceHeight ==== $isBottom');

    if (isEdgeToEdge == false) {
      /// 엣지가 아닌 경우는 0 반환
      return 0;
    }

    double extraMargin = 0;

    /// 아이폰 se3 > EdgeInsets.zero
    final padding = MediaQuery.of(context).padding;

    /// 엣지 화면인지
    if (isBottom == true) {
      if (Platform.isAndroid && DeviceInfoUtils.instance.sdkInt < 35) {
        /// android os 15, sdk 35 미만인 경우 bottom은 엣지투엣지가 안되서 0
        extraMargin = padding.bottom;
      } else {
        /// 아이폰 하드웨어키, 안드로이드 os15이전 버전등은 EdgeInsets이 0으로 기본 마진 주기
        if (Platform.isIOS && isHomeBtnIos(context)) {
          /// ios 홈버튼이 있는 경우
          extraMargin = 0;
        } else {
          extraMargin = padding.bottom == 0 ? DEFAULT_BOTTOM_MAGGIN : padding.bottom;
        }
      }
    } else {
      /// 아이폰 하드웨어키, 안드로이드 os15이전 버전등은 EdgeInsets이 0으로 기본 마진 주기
      /// android os 15, sdk 35 미만인 경우, top은 엣지투엣지가 먹는다 top
      extraMargin = padding.top == 0 ? DEFAULT_TOP_MAGGIN : padding.top;
    }

    QcLog.d(
      'padding  ======= $isBottom , ${MediaQuery.of(context).padding} ,'
      'return extraMargin: $extraMargin',
    );
    return extraMargin;
  }

  ///
  /// 홈버튼을 가지고 있는지
  ///
  bool isHomeBtnIos(BuildContext context) {
    if (MediaQuery.of(context).padding.bottom > 0) {
      // 홈 인디케이터 있는 iPhone → 하드웨어키 없음
      return false;
    } else {
      // 홈 인디케이터 없음 → 하드웨어 홈버튼 있을 가능성 높음
      return true;
    }
  }
}
