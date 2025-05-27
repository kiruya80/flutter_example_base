import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_base/utils/print_log.dart';
import 'package:go_router/go_router.dart';

import '../../core/base_state.dart';

class SettingScreen extends StatefulWidget {

  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends BaseState<SettingScreen> {
  @override
  void initState() {
    super.initState();
    // _loadDataSafely();
  }

  Future<void> _loadDataSafely() async {
    await Future.delayed(const Duration(seconds: 2));

    // ✅ 안전하게 상태 업데이트
    if (!isThisPageVisible) return;

    showDialog(context: context, builder: (_) => const AlertDialog(content: Text('데이터 도착')));
  }

  @override
  Widget build(BuildContext context) {
    QcLog.d('build =====  $isThisPageVisible ');
    final name = GoRouter.of(context).routeInformationProvider.value.uri.toString();
    QcLog.d('name =====  $name ');
    // final routeMatchList = GoRouter.of(context).routerDelegate.currentConfiguration;
    // QcLog.d('routeMatchList =====  ${routeMatchList.toString()} ');

    final matches = GoRouter.of(context).routerDelegate.currentConfiguration.matches;

    for (final match in matches) {
      print('Matched Route : ${match.route.toString()}');
    }

    // final currentLocation = GoRouter.of(context).location;
    // print('현재 경로: $currentLocation');

    return Scaffold(
      appBar: AppBar(title: Text('Setting')),
      body: Center(
        child: Column(
          children: [
            Text('id:'),
            ElevatedButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop(); // 뒤로 가기
                }
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
