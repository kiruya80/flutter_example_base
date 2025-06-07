import 'package:flutter/cupertino.dart';

import '../../domain/common/entities/route_info.dart';
import 'app_router.dart';

///
///  router 컨트럴러
///
/// 추후 딥링크도 적용되게
///
class RouterController {
  static final RouterController instance = RouterController._();

  RouterController._();

  Future<void> pushName(RouteInfo routeInfo) async {
    Navigator.of(
      AppRouter.globalNavigatorKey.currentContext!,
    ).pushNamed(routeInfo.path, arguments: routeInfo.queryParams);
  }
}
