import 'package:flutter/cupertino.dart';

///
/// 라우터 옵져버 
///
class MyRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint('➡️ Pushed: ${route.settings.name ?? route.settings}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint('⬅️ Popped: ${route.settings.name ?? route.settings}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint('🔁 Replaced: ${oldRoute?.settings} -> ${newRoute?.settings}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    debugPrint('🗑️ Removed: ${route.settings}');
  }
}
