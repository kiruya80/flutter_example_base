import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/base_state.dart';
import '../../../../core/utils/print_log.dart';
import '../../../app/app_routes.dart';
import '../../../widgets/router_move_item.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('context goNamed'),
            const SizedBox(height: 10),
            RouterMoveItem('goNamed(profileDetail)', () {
              context.goNamed(AppTabRoutes.profileDetail.name);
            }, isError: true),
            RouterMoveItem('goNamed(profileDetail, \npathParameters: {id: 123})', () {
              context.goNamed(AppTabRoutes.profileDetail.name, pathParameters: {'id': '123'});
            }),
            RouterMoveItem('goNamed(profileDetail, \nqueryParameters: {title: profile})', () {
              context.goNamed(
                AppTabRoutes.profileDetail.name,
                queryParameters: {'title': 'profile'},
              );
            }, isError: true),
            const SizedBox(height: 20),
            Text('context pushNamed'),
            const SizedBox(height: 10),
            RouterMoveItem('push(/profile/detail, \npathParameters: {id: 123}', () {
              context.pushNamed(AppTabRoutes.profileDetail.name, pathParameters: {'id': '123'});
            }),
          ],
        ),
      ),
    );
  }
}
