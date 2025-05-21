import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailPathScreen extends StatefulWidget {
  final String? id;

  const DetailPathScreen({super.key, this.id});

  @override
  State<DetailPathScreen> createState() => _DetailPathScreenState();
}

class _DetailPathScreenState extends State<DetailPathScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Column(
        children: [
          Text('id : ${widget.id}'),
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
