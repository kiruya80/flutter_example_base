import 'package:flutter/material.dart';
import 'package:flutter_example_base/domain/entities/route_info.dart';
import 'package:go_router/go_router.dart';

import '../../../core/base_state.dart';
import '../../../utils/print_log.dart';
import '../../routes/app_routes.dart';
import '../../widgets/router_move_item.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends BaseState<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    QcLog.d('build ===== $isThisPageVisible');
    // final shellRouteState = StatefulShellRoute.of(context);
    // print('현재 탭 인덱스: ${shellRouteState.currentIndex}');

    return Scaffold(
      appBar: AppBar(title: Text(AppTabRoutes.profile.name)),
      body: Center(
        child: Column(
          children: [
            Text('context goNamed'),
            const SizedBox(height: 30),

            RouterMoveItem('goNamed(profileDetail)', () {
              context.goNamed(AppTabRoutes.profileDetail.name);
            }, isError: true),

            RouterMoveItem('goNamed(profileDetail, pathParameters: {id: 123})', () {
              context.goNamed(AppTabRoutes.profileDetail.name, pathParameters: {'id': '123'});
            }),

            RouterMoveItem('goNamed(profileDetail, queryParameters: {title: profile})', () {
              context.goNamed(
                AppTabRoutes.profileDetail.name,
                queryParameters: {'title': 'profile'},
              );
            }, isError: true),
          ],
        ),
      ),
    );
  }
}
