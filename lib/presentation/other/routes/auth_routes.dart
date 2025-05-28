import 'package:go_router/go_router.dart';

import '../screens/move/login_screen.dart';
import '../../app/app_routes.dart';

///
/// auth 모듈 전용 routes
///
final List<GoRoute> authRoutes = [
  GoRoute(
    name: AppRoutes.login.name,
    path: AppRoutes.login.path,
    builder: (context, state) => const LoginScreen(),
    redirect: (context, state) {},
  ),
];
