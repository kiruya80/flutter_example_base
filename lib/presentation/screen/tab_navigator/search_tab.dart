import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_base/utils/print_log.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTabRoutes.search.name)),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final url = AppTabRoutes.searchDetail.fullPath(
              pathParams: {'id': '123'},
              queryParams: {'tab': 'settings'},
            );
            QcLog.d('fullPath ==== $url');

            context.go('${AppTabRoutes.home.path}/${AppTabRoutes.searchDetail.path}/123');
            context.go('${AppTabRoutes.home.path}/${AppTabRoutes.searchDetail.pathWithParams({'id': '123'})}');
            context.go(AppTabRoutes.searchDetailPath('123'));

            context.goNamed(
              AppTabRoutes.searchDetail.name,
              pathParameters: {'id': '123'},
            );

// → /home/user/123?tab=settings
            // context.go('/search/detail');
          },
          child: Text('Go to search Detail'),
        ),
      ),
    );
  }
}
