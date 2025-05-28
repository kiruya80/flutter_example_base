import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchQueryScreen extends StatefulWidget {
  final String? keyword;

  const SearchQueryScreen({super.key, this.keyword});

  @override
  State<SearchQueryScreen> createState() => _SearchQueryScreenState();
}

class _SearchQueryScreenState extends State<SearchQueryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Tab')),
      body: Column(
        children: [
          Text('keyword : ${widget.keyword}'),
          ElevatedButton(
            child: Text('Go to Detail from Search'),
            onPressed: () => context.push('/search/detail'),
          ),
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
