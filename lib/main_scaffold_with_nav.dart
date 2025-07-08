import 'package:flutter/material.dart';
import 'package:flutter_example_base/presentation/dialog/dialog_queue_listener.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app/routes/app_router.dart';
import 'core/theme/app_theme_provider.dart';
import 'core/utils/print_log.dart';

/// 바텀네비게이터
class MainScaffoldWithNav extends StatelessWidget {
  final StatefulNavigationShell shell;

  const MainScaffoldWithNav({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: shell.currentIndex,
        type: BottomNavigationBarType.fixed, // 4개 이상일 경우 필요
        onTap: (index) {
          QcLog.d(
            'state before ===== ${GoRouterState.of(context).topRoute.toString()} , ${GoRouterState.of(context).uri} , ${shell.currentIndex} ',
          );

          // if (index == shell.currentIndex) {
          if (TabChangeObserver.onTabChanged(index)) {
            /// todo 만약 홈탭으로 돌아오고 리빌드 하고 싶을때는 프로바이더나 이벤트 버스등 명시적 호출 필요
            /// if (index == 0) {
            ///   eventBus.fire(HomeTabSelectedEvent());
            ///   homeTabNotifier.refresh();
            /// }
            ///
            /// 동일한 탭 다시 클릭하는 경우 홈으로 이동하게
            shell.goBranch(index, initialLocation: true);
          } else {
            shell.goBranch(index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}

class TabChangeObserver {
  static int _lastIndex = 0;

  static bool onTabChanged(int newIndex) {
    if (_lastIndex != newIndex) {
      debugPrint('🟢 탭 변경: $_lastIndex -> $newIndex');
      _lastIndex = newIndex;
      return false;
    } else {
      return true;
    }
  }
}
