import 'package:flutter_example_base/core/extensions/string_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/print_log.dart';
import '../../app/di/scroll_notifier.dart';

///
/// 1. mixin
/// 스크롤 하단인 경우
///
mixin ScrollBottomListenerMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String? tabId;
  ProviderSubscription<bool>? _subscription;

  void onScrollBottomReached();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (tabId.isNotNullOrEmpty == false) {
      // GoRouter에서 현재 탭의 route.name 추출
      final routeName = GoRouterState.of(context).topRoute?.name;
      if (routeName.isNotNullOrEmpty == false) return;
      tabId = routeName!;
      QcLog.d("📦 tabId ====$tabId");

      _subscription = ref.listenManual<bool>(scrollReachedBottomProvider(tabId!), (prev, next) {
        if (next == true) {
          onScrollBottomReached();
        }
      });
    }
  }

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }
}
