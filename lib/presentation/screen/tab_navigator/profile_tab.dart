import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';



class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTabRoutes.profile.name)),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // context.go('/profile/detail');
            context.go('${AppTabRoutes.profile.path}/${AppTabRoutes.detail.path}');
          },
          child: Text('Go to profile Detail'),
        ),
      ),
    );
  }
}
