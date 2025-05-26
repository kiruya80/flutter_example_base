import 'package:flutter/material.dart';
import 'package:flutter_example_base/domain/entities/route_info.dart';
import 'package:flutter_example_base/utils/print_log.dart';
import 'package:go_router/go_router.dart';

import '../../../core/base_state.dart';
import '../../routes/app_routes.dart';
import '../../widgets/router_move_item.dart';

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
      body: Center(
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
              context.push(AppTabRoutes.searchDetailFullPath(id: '123', query: {'query': 'ddddddd'}));
            }),

          ],
        ),
      ),
    );
  }
}
