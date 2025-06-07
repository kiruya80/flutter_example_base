import 'package:go_router/go_router.dart';

import 'home_routes.dart';
import 'post_routes.dart';
import 'profile_routes.dart';
import 'search_routes.dart';

///
/// 탭 라우터
///
class TabRouter {
  /// 홈화면 탭
  static final List<StatefulShellBranch> tabBranches = [
    StatefulShellBranch(routes: homeTabRoutes),
    StatefulShellBranch(routes: postTabRoutes),
    StatefulShellBranch(routes: profileTabRoutes),
    StatefulShellBranch(routes: searchTabRoutes),
  ];
}
