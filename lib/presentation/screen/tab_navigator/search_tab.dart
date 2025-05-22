import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            // context.go('/search/detail');
            context.go('${AppTabRoutes.search.path}/${AppTabRoutes.search.path}');
          },
          child: Text('Go to search Detail'),
        ),
      ),
    );
  }
}
