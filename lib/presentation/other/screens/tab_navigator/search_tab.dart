import 'package:flutter/material.dart';
import 'package:flutter_example_base/domain/entities/route_info.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/base_state.dart';
import '../../../../core/utils/print_log.dart';
import '../../../app/app_routes.dart';
import '../../../widgets/router_move_item.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends BaseState<SearchTab> {
  @override
  Widget build(BuildContext context) {
    QcLog.d('build ===== $isThisPageVisible');

    final url = AppTabRoutes.searchDetail.fullPath(
      pathParams: {'id': '123'},
      queryParams: {'tab': 'settings'},
    );

    /// fullPath ==== detail/123?tab=settings
    QcLog.d('fullPath ==== $url');

    final url2 = AppTabRoutes.searchDetailFullPath(id: '123', query: {'tab': 'settings'});

    /// searchDetailFullPath ==== /search/detail/123?tab=settings
    QcLog.d('searchDetailFullPath ==== $url2');

    return Scaffold(
      appBar: AppBar(title: Text(AppTabRoutes.search.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('context Go path'),
            const SizedBox(height: 10),

            RouterMoveItem('go(/search/detail)', () {
              context.go('/search/detail');
            }, isError: true),

            RouterMoveItem('go(/search/detail/123)', () {
              context.go('/search/detail/123');
            }),

            RouterMoveItem('go(/search/detail/123?query=ddddddd)', () {
              context.go(AppTabRoutes.searchDetailFullPath(id: '123', query: {'query': 'ddddddd'}));
            }),

            const SizedBox(height: 20),
            Text('context push'),
            const SizedBox(height: 10),

            RouterMoveItem('push(/search/detail/123)', () {
              context.push('/search/detail/123');
            }),

            RouterMoveItem('push(/search/detail/123?query=ddddddd)', () {
              context
                  .push(AppTabRoutes.searchDetailFullPath(id: '123', query: {'query': 'ddddddd'}));
            }),

            Text('home detail Go & Push'),
            const SizedBox(height: 10),

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
    );
  }
}
