import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes/app_routes_info.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/print_log.dart';
import '../../../shared/state/base_con_state.dart';
import '../../widgets/item_title.dart';
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

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // });
  }

  @override
  Widget build(BuildContext context) {
    QcLog.d('build ===== $isThisPageVisible');
    CommonUtils.isTablet(context);

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
            ///
            ///
            ///
            ItemTitle('context Go & Push'),
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

            ItemTitle('Setting go & push'),

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
      floatingActionButton: FloatingActionButton(
        heroTag: 'edgeToEdge',
        onPressed: () {
          context.pushNamed(AppRoutesInfo.edgeToEdge.name);
          ///
          // showModalBottomSheet(
          //   context: context,
          //   backgroundColor: Colors.transparent,
          //   builder: (context) {
          //     return ClipRRect(
          //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          //       child: BackdropFilter(
          //         filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          //         child: Container(
          //           height: 300,
          //           color: Colors.white.withOpacity(0.4),
          //           child: Center(child: Text('iOS 스타일 시트')),
          //         ),
          //       ),
          //     );
          //   },
          // );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
