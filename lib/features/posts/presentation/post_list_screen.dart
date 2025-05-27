
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: const Center(child: Text('전체 글 목록')),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.push('/posts/write'),
            child: const Icon(Icons.login),
          ),
          SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: () => context.push('/login'),
            child: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}