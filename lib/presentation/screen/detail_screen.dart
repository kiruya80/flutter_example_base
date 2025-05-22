import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_base/utils/print_log.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatefulWidget {
  final String? title;

  const DetailScreen({super.key, this.title});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    QcLog.d('DetailScreen =====  ');
    return Scaffold(
      appBar: AppBar(title:   Text('${widget.title}')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop(); // 뒤로 가기
              }
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
