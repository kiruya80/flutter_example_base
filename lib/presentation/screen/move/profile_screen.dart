import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/print_log.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    QcLog.d('ProfileScreen ===== ');
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Tab')),
      body: Column(
        children: [
          ElevatedButton(
              child: Text('Go to Detail from Profile'),
              onPressed: () {
                context.push('/profile/detail');
                // context.pushNamed('/profile/details', pathParameters: {'id': '123'});
              }),
          ElevatedButton(
            onPressed: () {
              context.pop(); // 뒤로 가기
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
