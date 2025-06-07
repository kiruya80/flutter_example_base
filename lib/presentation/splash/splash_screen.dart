import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_routes_info.dart';
import '../../core/utils/print_log.dart';
import '../../shared/state/base_con_state.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseConState<SplashPage> {
  @override
  void initState() {
    super.initState();
    QcLog.d('initState ====== ');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _init();
    });
  }

  Future<void> _init() async {
    if (mounted) {
      context.goNamed(AppRoutesInfo.tabHome.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            //             RouterMoveItem('dialogQueueProvider add', () async {
            //               // 다이얼로그 요청 추가
            //               ref.read(dialogQueueProvider.notifier).enqueue(
            //                     DialogRequest(title: '알림', message: '작업이 완료되었습니다.'),
            //                   );
            //               ref.read(dialogQueueProvider.notifier).enqueue(
            //                     DialogRequest(title: '알림2', message: '작업이 완료되었습니다.22'),
            //                   );
            //
            //               ref.read(dialogQueueProvider.notifier).enqueue(
            //                     DialogRequest(title: '안내', message: '로딩이 완료되었습니다.'),
            //                   );
            //               QcLog.d('Queue length ==== ${ref.read(dialogQueueProvider.notifier)..length}');
            // // 다이얼로그 처리 후 큐 제거
            // //             ref.read(dialogQueueProvider.notifier).dequeue();
            //             }),
          ],
        ),
      ),
    );
  }
}
