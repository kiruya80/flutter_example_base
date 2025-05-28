import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/state/base_state.dart';
import '../../../core/utils/print_log.dart';
import '../../app/app_routes_info.dart';
import '../../widgets/router_move_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends BaseState<HomeTab> {
  @override
  Widget build(BuildContext context) {
    QcLog.d('build ===== $isThisPageVisible');

    return Scaffold(
      appBar: AppBar(title: Text(AppTabRoutesInfo.home.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('context Go & Push'),
            const SizedBox(height: 10),
            RouterMoveItem('go(/home/detail)', () {
              // context.go('${AppTabRoutes.home.path}/${AppTabRoutes.detail.path}'); // context.go('/home/detail');
              //     context.pushNamed('details', pathParameters: {'id': '123'});
              context.go('/home/detail');
            }),

            RouterMoveItem('go(/detail)', () {
              context.go('/detail');
            }, isError: true),

            RouterMoveItem('push(/home/detail)', () {
              context.push('/home/detail');
            }),

            RouterMoveItem('push(/detail)', () {
              context.push('/detail');
            }, isError: true),

            RouterMoveItem('go(/home/homeCard)', () {
              // context.go('${AppTabRoutes.home.path}/${AppTabRoutes.detail.path}'); // context.go('/home/detail');
              //     context.pushNamed('details', pathParameters: {'id': '123'});
              context.go('/home/homeCard');
            }),
            RouterMoveItem('push(/home/homeCard)', () {
              context.push('/home/homeCard');
            }),

            const SizedBox(height: 20),
            Text('Setting go & push'),
            const SizedBox(height: 10),

            /// 스택 리셋 back 불가
            RouterMoveItem('go(/setting) 스택 리셋', () {
              context.go(AppRoutesInfo.setting.path);
            }),

            /// 스택 리셋 back 불가
            RouterMoveItem('goNamed(/setting) 스택 리셋', () {
              context.goNamed(AppRoutesInfo.setting.name);
            }),

            /// 스택 추가 back 가능
            RouterMoveItem('push(/setting) 스택 추가', () {
              context.push(AppRoutesInfo.setting.path);
            }),

            /// 스택 추가 back 가능
            RouterMoveItem('pushNamed(/setting) 스택 추가', () {
              context.pushNamed(AppRoutesInfo.setting.name);
            }),
          ],
        ),
      ),
    );
  }
}
