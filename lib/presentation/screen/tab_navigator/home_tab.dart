import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/base_state.dart';
import '../../../utils/print_log.dart';
import '../../routes/app_routes.dart';
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
      appBar: AppBar(title: Text(AppTabRoutes.home.name)),
      body: Center(
        child: Column(
          children: [
            Text('context Go & Push'),
            const SizedBox(height: 30),
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
          ],
        ),
      ),
    );
  }
}
