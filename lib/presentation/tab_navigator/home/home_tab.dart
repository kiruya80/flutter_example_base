import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers/dialog_queue_manager.dart';
import '../../../app/providers/global_loading_provider.dart';
import '../../../app/routes/app_routes_info.dart';
import '../../../app/services/loading/dialog_queue_manager.dart';
import '../../utils/loading_dialog_manager.dart';
import '../../../core/utils/print_log.dart';
import '../../../domain/common/entities/test_usual.dart';
import '../../../shared/state/base_con_state.dart';
import '../../widgets/router_move_item.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends BaseConState<HomeTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QcLog.d('build ===== $isThisPageVisible');

    TestUsual mTestUsual2 = TestUsual(id: '112233', isSelected: false);

    TestUsual mTestUsual = TestUsual(id: '232323', isSelected: false, content: 'ccccc');
    QcLog.d('mTestUsual ===== ${mTestUsual.toString()}');
    var testUsual = mTestUsual.copyWith(content: 'lllllll');
    QcLog.d('testUsual ===== ${testUsual.toJson()}');
// JSON 직렬화
    final json = mTestUsual.toJson();

// 역직렬화
    final postFromJson = TestUsual.fromJson(json);
    QcLog.d('postFromJson ===== ${postFromJson.toJson()}');
    return Scaffold(
      appBar: AppBar(title: Text(AppRoutesInfo.tabHome.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RouterMoveItem('로딩 매니져', () async {
              // LoadingDialogManager.show();
              // await Future.delayed(const Duration(seconds: 5));
              // LoadingDialogManager.hide();

              final loading = ref.read(globalLoadingProvider.notifier);
              loading.state = true;
              LoadingDialogManager.show();
              await Future.delayed(const Duration(seconds: 5));
              loading.state = false;
              LoadingDialogManager.hide();
            }),
            const SizedBox(height: 20),

            RouterMoveItem('다이얼로그 큐 매니져', () async {
              ref.read(dialogQueueProvider.notifier).clear();
              QcLog.d('Queue length ==== ${ref.read(dialogQueueProvider.notifier).length}');
              // 다이얼로그 요청 추가
              ref.read(dialogQueueProvider.notifier).enqueue(
                    DialogRequest(
                        title: '알림',
                        message: '작업이 완료되었습니다.',
                        onConfirmed: () {
                          QcLog.d('onConfirmed ==== 알림 ');
                        }),
                  );
              await Future.delayed(const Duration(seconds: 3));
              ref.read(dialogQueueProvider.notifier).enqueue(
                    DialogRequest(
                        title: '알림22222',
                        message: '작업이 완료되었습니다.22222',
                        onConfirmed: () {
                          QcLog.d('onConfirmed ==== 알림22222 ');
                        }),
                  );

              // ref.read(dialogQueueProvider.notifier).enqueue(
              //   DialogRequest(title: '안내', message: '로딩이 완료되었습니다.'),
              // );
              QcLog.d('Queue length ==== ${ref.read(dialogQueueProvider.notifier).length}');
// 다이얼로그 처리 후 큐 제거
//             ref.read(dialogQueueProvider.notifier).dequeue();
            }),
            const SizedBox(height: 20),

            RouterMoveItem('로딩 & 다이얼로그 큐 매니져', () async {
              ref.read(dialogQueueProvider.notifier).clear();
              QcLog.d('Queue length ==== ${ref.read(dialogQueueProvider.notifier).length}');



              final loading = ref.read(globalLoadingProvider.notifier);
              loading.state = true;
              LoadingDialogManager.show();

              // 다이얼로그 요청 추가
              ref.read(dialogQueueProvider.notifier).enqueue(
                DialogRequest(
                    title: '알림',
                    message: '작업이 완료되었습니다.',
                    onConfirmed: () {
                      QcLog.d('onConfirmed ==== 알림 ');
                    }),
              );
              await Future.delayed(const Duration(seconds: 3));
              ref.read(dialogQueueProvider.notifier).enqueue(
                DialogRequest(
                    title: '알림22222',
                    message: '작업이 완료되었습니다.22222',
                    onConfirmed: () {
                      QcLog.d('onConfirmed ==== 알림22222 ');
                    }),
              );




              await Future.delayed(const Duration(seconds: 3));
              loading.state = false;
              LoadingDialogManager.hide();





              // ref.read(dialogQueueProvider.notifier).enqueue(
              //   DialogRequest(title: '안내', message: '로딩이 완료되었습니다.'),
              // );
              QcLog.d('Queue length ==== ${ref.read(dialogQueueProvider.notifier).length}');
// 다이얼로그 처리 후 큐 제거
//             ref.read(dialogQueueProvider.notifier).dequeue();
            }),
            const SizedBox(height: 40),

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
