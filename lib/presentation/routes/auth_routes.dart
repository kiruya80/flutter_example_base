import 'package:flutter_example_base/presentation/screen/login_screen.dart';
import 'package:go_router/go_router.dart';

///
/// auth 모듈 전용 routes
///
final List<GoRoute> authRoutes = [
  GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
];
