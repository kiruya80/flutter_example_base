import 'package:flutter/material.dart';
import 'package:flutter_example_base/app/routes/route_helper.dart';
import 'package:flutter_example_base/domain/common/entities/route_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/print_log.dart';
import '../../../app/routes/app_routes_info.dart';
import '../../../shared/state/base_con_state.dart';
import '../../widgets/item_title.dart';
import '../../widgets/router_move_item.dart';

class SearchTab extends ConsumerStatefulWidget {
  final ScrollController? mainNavScrollController;

  const SearchTab({super.key,  this.mainNavScrollController});

  @override
  ConsumerState<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends BaseConState<SearchTab> {
  @override
  Widget build(BuildContext context) {
    QcLog.d('build ===== $isThisPageVisible');

    final url = AppRoutesInfo.searchDetail.fullPath(
      pathParams: {'id': '123'},
      queryParams: {'tab': 'settings'},
    );

    /// fullPath ==== detail/123?tab=settings
    QcLog.d('fullPath ==== $url');

    final url2 = AppRoutesInfo.searchDetailFullPath(id: '123', query: {'tab': 'settings'});

    /// searchDetailFullPath ==== /search/detail/123?tab=settings
    QcLog.d('searchDetailFullPath ==== $url2');

    return Stack(
      children: [
        // 배경 이미지
        Positioned.fill(child: Image.network('https://picsum.photos/1080/1920', fit: BoxFit.cover)),

        SingleChildScrollView(
          controller: widget.mainNavScrollController,
          child: Column(
            children: [
              ItemTitle('context Go path'),

              RouterMoveItem('go(/search/detail)', () {
                context.go('/search/detail');
              }, isError: true),

              RouterMoveItem('go(/search/detail/123)', () {
                context.go('/search/detail/123');
              }),

              RouterMoveItem('go(/search/detail/123?query=ddddddd)', () {
                context.go(AppRoutesInfo.searchDetailFullPath(id: '123', query: {'query': 'ddddddd'}));
              }),

              ItemTitle('context push'),

              RouterMoveItem('push(/search/detail/123)', () {
                context.push('/search/detail/123');
              }),

              RouterMoveItem('push(/search/detail/123?query=ddddddd)', () {
                context.push(
                  AppRoutesInfo.searchDetailFullPath(id: '123', query: {'query': 'ddddddd'}),
                );
              }),

              ItemTitle('홈의 상세 페이지 이동 [go & push]'),

              /// 브랜치로 전환(현재탭 스택 제거) home 이동후 detail 이동
              /// 뒤로가기시 홈으로 가능
              RouterMoveItem('go(/home/detail)', () {
                context.go('/home/detail');
              }),

              /// 현재탭 위에 /home/detai 쌓임
              /// 뒤로가기시 현재탭으로
              RouterMoveItem('push(/home/detail)', () {
                context.push('/home/detail');
              }),

              /// home 이동후 detail
              RouterMoveItem('go(/home/homeCard)', () {
                // context.go('${AppTabRoutes.home.path}/${AppTabRoutes.detail.path}'); // context.go('/home/detail');
                //     context.pushNamed('details', pathParameters: {'id': '123'});
                context.go('/home/homeCard');
              }),
              RouterMoveItem('push(/home/homeCard)', () {
                context.push('/home/homeCard');
              }),
            ],
          ),
        ),
      ],
    );
  }
}
