import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final RouteObserver<ModalRoute<void>> conWidgetRouteObserver =
    RouteObserver<ModalRoute<void>>();

abstract class BaseConState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T>
    with RouteAware {
  String _location = '';
  bool _didPop = false;

  /// 현재 라우팅 경로 (예: "/home/detail/123")
  String get currentLocation => _location;

  /// 현재 이 페이지가 화면에 보이는 상태인지
  bool get isThisPageVisible =>
      mounted && _didPop && ModalRoute.of(context)!.isCurrent;

  /// 페이지 트리에 있는지만 확인 (화면에 보이는지 여부와는 무관)
  bool get isActivePage => mounted;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    QcLog.d('didChangeDependencies ===== ');

    // RouteObserver에 등록
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      conWidgetRouteObserver.subscribe(this, route);
    }

    // final currentUri = GoRouter.of(context).routerDelegate.currentConfiguration.uri;
    _location = getCurrentPath(context);
    print('currentUri.path == ${_location}'); // 예: /home/detail/123
  }

  String getCurrentPath(BuildContext context) {
    final delegate = GoRouter.of(context).routerDelegate;
    final uri = delegate.currentConfiguration.uri;
    return uri.toString(); // ex: /home/detail/123
  }

  @override
  void dispose() {
    conWidgetRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() => _didPop = true;

  @override
  void didPopNext() => _didPop = true;

  @override
  void didPop() => _didPop = false;

  @override
  void didPushNext() => _didPop = false;
}

//
// abstract class BaseState<T extends StatefulWidget> extends State<T> with RouteAware {
//   bool _isCurrent = false;
//
//   /// 같은 Navigator 안에서는 둘다 true
//   bool get isSafeToUpdate => mounted && _isCurrent;
//
//   @override
//   void initState() {
//     super.initState();
//     final routeMatch = GoRouter.of(context).routeInformationProvider.value;
//     QcLog.d('현재 route info: ${routeMatch.uri}  , ${routeMatch.uri.toString()}');
//     // final state = GoRouterState.of(context);
//     // debugPrint('state ===== ${state.name} , ${state.uri}');
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     final modalRoute = ModalRoute.of(context);
//     if (modalRoute is PageRoute) {
//       conWidgetRouteObserver.subscribe(this, modalRoute);
//     }
//   }
//
//   @override
//   void dispose() {
//     conWidgetRouteObserver.unsubscribe(this);
//     super.dispose();
//   }
//
//   /// 페이지가 처음 보여질 때
//   @override
//   void didPush() {
//     _isCurrent = true;
//   }
//
//   /// 하위 화면에서 돌아왔을 때
//   @override
//   void didPopNext() {
//     _isCurrent = true;
//   }
//
//   /// 이 화면이 pop 되었을 때
//   @override
//   void didPop() {
//     _isCurrent = false;
//   }
//
//   /// 다른 화면이 위에 올라올 때
//   @override
//   void didPushNext() {
//     _isCurrent = false;
//   }
// }

// abstract class BaseState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
//   bool _isCurrent = false;
//
//   bool get isSafeToUpdate => mounted && _isCurrent;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     WidgetsBinding.instance.addObserver(this);
//     _updateIsCurrent();
//   }
//
//   void _updateIsCurrent() {
//     _isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//     }
//     _updateIsCurrent();
//   }
//
//   @override
//   void didPush() => _updateIsCurrent();
//   @override
//   void didPopNext() => _updateIsCurrent();
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
// }
