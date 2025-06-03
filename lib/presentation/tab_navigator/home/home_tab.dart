import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../dialog/dialog_controller.dart';
import '../../dialog/dialog_request.dart';
import '../../providers/dialog_queue_provider.dart';
import '../../../app/routes/app_routes_info.dart';
import '../../../core/utils/print_log.dart';
import '../../../shared/state/base_con_state.dart';
import '../../widgets/router_move_item.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends BaseConState<HomeTab> {
  late void Function() _cancelLoadingListener;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.listen(dialogQueueProvider, (previous, next) {
      //   QcLog.d('listen ==== dialogQueueProvider ====  $previous , $next');
      // });

      // ref.listen(globalLoadingProvider, (previous, next) {
      //   QcLog.d('listen ==== globalLoadingProvider ====   $previous , $next');
      // });

      // ref.listenManual(dialogQueueProvider, (previous, next) {
      //   QcLog.d('listen ==== dialogQueueProvider ====   $previous , $next');
      // });
      // ref.listenManual(globalLoadingProvider, (previous, next) {
      //   QcLog.d('listen ==== globalLoadingProvider ====   $previous , $next');
      // });

      // _cancelDialogListener = ref.listenManual<Queue<DialogRequest>>(
      //   dialogQueueProvider,
      //       (previous, next) {
      //     QcLog.d('📌 DialogQueue 변경 감지: $next');
      //     _tryShowNextDialog();
      //   },
      // );
      //
      // _cancelLoadingListener = ref.listenManual<bool>(
      //   globalLoadingProvider,
      //       (previous, next) {
      //     QcLog.d('📌 로딩 상태 변경 감지: $next');
      //     _isLoading = next;
      //     _tryShowNextDialog();
      //   },
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    QcLog.d('build ===== $isThisPageVisible');

    // TestUsual mTestUsual2 = TestUsual(id: '112233', isSelected: false);
    // TestUsual mTestUsual = TestUsual(id: '232323', isSelected: false, content: 'ccccc');
    // QcLog.d('mTestUsual ===== ${mTestUsual.toString()}');
    // var testUsual = mTestUsual.copyWith(content: 'lllllll');
    // QcLog.d('testUsual ===== ${testUsual.toJson()}');
    // JSON 직렬화
    // final json = mTestUsual.toJson();
    // 역직렬화
    // final postFromJson = TestUsual.fromJson(json);
    // QcLog.d('postFromJson ===== ${postFromJson.toJson()}');

    return Scaffold(
      appBar: AppBar(title: Text(AppRoutesInfo.tabHome.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RouterMoveItem('로딩 매니져 dialogController', () async {
              dialogController.showLoading();
              await Future.delayed(const Duration(seconds: 5));
              dialogController.hideLoading();
            }),
            const SizedBox(height: 20),
            // RouterMoveItem('로딩 매니져 globalLoadingProvider', () async {
            //   ref.read(globalLoadingProvider.notifier).state = true;
            //   await Future.delayed(const Duration(seconds: 5));
            //   ref.read(globalLoadingProvider.notifier).state = false;
            // }),
            // const SizedBox(height: 20),

            RouterMoveItem('showAppDialog dialogController', () async {
              dialogController.showAppDialog(
                title: '알림',
                message: '작업이 완료되었습니다.',
                type: DialogRequestType.info,
                onConfirmed: () => print('확인 클릭됨'),
              );
              await Future.delayed(const Duration(seconds: 3));

              dialogController.showAppDialog(
                title: '알림22222',
                message: '작업이 완료되었습니다.22222',
                type: DialogRequestType.info,
                onConfirmed: () => print('확인 클릭됨'),
              );

              QcLog.d('Queue length ==== ${ref.read(dialogQueueProvider.notifier).length}');
            }),
            const SizedBox(height: 20),

            RouterMoveItem('showAppDialog dialogQueueProvider', () async {
              // 다이얼로그 요청 추가
              ref
                  .read(dialogQueueProvider.notifier)
                  .enqueue(
                    DialogRequest(
                      title: '알림',
                      message: '작업이 완료되었습니다.',
                      onConfirmed: () {
                        QcLog.d('onConfirmed ==== 알림 ');
                      },
                    ),
                  );
              await Future.delayed(const Duration(seconds: 3));
              ref
                  .read(dialogQueueProvider.notifier)
                  .enqueue(
                    DialogRequest(
                      title: '알림22222',
                      message: '작업이 완료되었습니다.22222',
                      onConfirmed: () {
                        QcLog.d('onConfirmed ==== 알림22222 ');
                      },
                    ),
                  );

              QcLog.d('Queue length ==== ${ref.read(dialogQueueProvider.notifier).length}');
            }),
            const SizedBox(height: 20),

            // RouterMoveItem('로딩 매니져', () async {
            //   ref.read(globalLoadingProvider.notifier).state = true;
            //   LoadingDialogManager.show();
            //   await Future.delayed(const Duration(seconds: 5));
            //   ref.read(globalLoadingProvider.notifier).state = false;
            //   LoadingDialogManager.hide();
            //   QcLog.d('loading state ===  ${ref.read(globalLoadingProvider.notifier).state}');
            // }),
            const SizedBox(height: 20),

            ///
            ///
            ///
            // RouterMoveItem('다이얼로그 큐 매니져', () async {
            //   ref.read(dialogQueueProvider.notifier).clear();
            //   QcLog.d('Queue length ==== ${ref.read(dialogQueueProvider.notifier).length}');
            //   // 다이얼로그 요청 추가
            //   ref
            //       .read(dialogQueueProvider.notifier)
            //       .enqueue(
            //         DialogRequest(
            //           title: '알림',
            //           message: '작업이 완료되었습니다.',
            //           onConfirmed: () {
            //             QcLog.d('onConfirmed ==== 알림 ');
            //           },
            //         ),
            //       );
            //   await Future.delayed(const Duration(seconds: 3));
            //   ref
            //       .read(dialogQueueProvider.notifier)
            //       .enqueue(
            //         DialogRequest(
            //           title: '알림22222',
            //           message: '작업이 완료되었습니다.22222',
            //           onConfirmed: () {
            //             QcLog.d('onConfirmed ==== 알림22222 ');
            //           },
            //         ),
            //       );
            //
            //   QcLog.d('Queue length ==== ${ref.read(dialogQueueProvider.notifier).length}');
            // }),
            // const SizedBox(height: 20),
            //
            // ///
            // ///
            // ///
            // RouterMoveItem('로딩 & 다이얼로그 큐 매니져', () async {
            //   ref.read(dialogQueueProvider.notifier).clear();
            //   QcLog.d('Queue length ==== ${ref.read(dialogQueueProvider.notifier).length}');
            //
            //   ref.read(globalLoadingProvider.notifier).state = true;
            //   final _loadingDialog = LoadingDialogManager();
            //   await _loadingDialog.show(context);
            //
            //   // 다이얼로그 요청 추가
            //   ref
            //       .read(dialogQueueProvider.notifier)
            //       .enqueue(
            //         DialogRequest(
            //           title: '알림',
            //           message: '작업이 완료되었습니다.',
            //           onConfirmed: () {
            //             QcLog.d('onConfirmed ==== 알림 ');
            //           },
            //         ),
            //       );
            //   ref
            //       .read(dialogQueueProvider.notifier)
            //       .enqueue(
            //         DialogRequest(
            //           title: '알림22222',
            //           message: '작업이 완료되었습니다.22222',
            //           onConfirmed: () {
            //             QcLog.d('onConfirmed ==== 알림22222 ');
            //           },
            //         ),
            //       );
            //   QcLog.d('Queue length ==== 로딩중상태 다이얼로그 추가');
            //
            //   await Future.delayed(const Duration(seconds: 3));
            //   _loadingDialog.dismiss();
            //   ref.read(globalLoadingProvider.notifier).state = false;
            //
            //   QcLog.d('loading state ===  ${ref.read(globalLoadingProvider.notifier).state}');
            //
            //   // 다이얼로그 처리 후 큐 제거
            //   //             ref.read(dialogQueueProvider.notifier).dequeue();
            // }),
            // const SizedBox(height: 40),

            ///
            ///
            ///
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
