import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/print_log.dart';
import '../../routes/app_routes.dart';
import '../detail_screen.dart';
import '../move/home_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTabRoutes.home.name)),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // context.go('${AppTabRoutes.home.path}/${AppTabRoutes.detail.path}'); // context.go('/home/detail');
            //     context.pushNamed('details', pathParameters: {'id': '123'});
            /// path parameter 사용하기
            //     context.push('/home/detail/:id=aaaa?title=home');
            //     context.goNamed(AppTabRoutes.homeDetail.path, pathParameters: {'id': '123'}, queryParameters: {'title':'home'});
            context.goNamed(AppTabRoutes.homeDetail.name);
          },
          child: Text('Go to Home Detail'),
        ),
      ),
    );
  }
}
