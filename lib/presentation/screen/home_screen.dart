import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/print_log.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    QcLog.d('HomeScreen ===== ');

    return Scaffold(
      appBar: AppBar(title: const Text('Home Tab')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.push('/home/detail');
              // context.push('/details/:232');
            },
            child: const Text('push to home Details'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     context.push('/details/:232');
          //   },
          //   child: const Text('push to Details'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     context.pushNamed('details', pathParameters: {'id': '123'});
          //   },
          //   child: const Text('goNamed Details'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     context.push('/search?keyword=flutter');
          //   },
          //   child: const Text('push to search'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     context.pushNamed('search', queryParameters: {'keyword': 'flutter'});
          //   },
          //   child: const Text('goNamed search'),
          // ),
        ],
      ),
    );
  }
}
