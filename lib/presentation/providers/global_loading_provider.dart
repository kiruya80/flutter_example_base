import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// 로딩 여부를 전역으로 관리
/// 글로벌 로딩 프로바이더
///
final globalLoadingProvider = StateProvider<bool>((ref) => false);