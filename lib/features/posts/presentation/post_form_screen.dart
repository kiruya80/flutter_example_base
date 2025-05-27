import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostFormScreen extends StatelessWidget {
  const PostFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('새 글 작성')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/posts');
          },
          child: const Text('작성 완료'),
        ),
      ),
    );
  }
}
