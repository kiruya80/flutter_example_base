import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// CommonDefaultEdgePage 에서 스크롤 최하단에 도달하는 경우
/// 각탭등 화면에서 더보기 데이터 호출을 위해서
///
final scrollReachedBottomProvider = StateProvider.family<bool, String>((ref, tabId) => false);
