import 'package:go_router/go_router.dart';

import 'package:flutter_example_base/presentation/screen/detail_path_screen.dart';
import 'package:flutter_example_base/presentation/screen/home_screen.dart';

import 'app_routes.dart';

///
/// home 모듈 전용 routes
///
final List<GoRoute> homeRoutes = [
  GoRoute(
      name: AppRoutes.home.name,
      path: AppRoutes.home.path,
      builder: (context, state) => const HomeScreen()),
  GoRoute(
    path: '/detail/:id',
    builder: (context, state) {
      final id = state.pathParameters['id']!;
      return DetailPathScreen(id: id);
    },
  ),
];
