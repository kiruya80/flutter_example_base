import 'package:flutter/foundation.dart';

class AppConstants {
  final bool debug = kDebugMode;

  static final double DialogMaxWidth = 450;
  static final double DialogMaxHeight = 400;
}

/// 더보기 데이터 상태
enum MoreDataScroll { HAS, NONE, FAIL }

enum NetState { Init, Loading, Paging, Empty, Completed, Error, CriticalError }
