import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/print_log.dart';
import '../../../app/routes/app_routes_info.dart';
import '../../../shared/state/base_con_state.dart';
import '../../widgets/item_title.dart';
import '../../widgets/router_move_item.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends BaseConState<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    QcLog.d('build ===== $isThisPageVisible');
    // final shellRouteState = StatefulShellRoute.of(context);
    // print('현재 탭 인덱스: ${shellRouteState.currentIndex}');

    return Scaffold(
      appBar: AppBar(title: Text(AppRoutesInfo.tabProfile.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ItemTitle('context goNamed'),

            RouterMoveItem('goNamed(profileDetail)', () {
              context.goNamed(AppRoutesInfo.profileDetail.name);
            }, isError: true),
            RouterMoveItem(
              'goNamed(profileDetail, \npathParameters: {id: 123})',
              () {
                context.goNamed(
                  AppRoutesInfo.profileDetail.name,
                  pathParameters: {'id': '123'},
                );
              },
            ),
            RouterMoveItem(
              'goNamed(profileDetail, \nqueryParameters: {title: profile})',
              () {
                context.goNamed(
                  AppRoutesInfo.profileDetail.name,
                  queryParameters: {'title': 'profile'},
                );
              },
              isError: true,
            ),

            ItemTitle('context pushNamed'),
            RouterMoveItem(
              'push(/profile/detail, \npathParameters: {id: 123}',
              () {
                context.pushNamed(
                  AppRoutesInfo.profileDetail.name,
                  pathParameters: {'id': '123'},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
