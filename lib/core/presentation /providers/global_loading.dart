import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// 글로벌 로딩 프로바이더
///
final globalLoadingProvider = StateProvider<bool>((ref) => false);