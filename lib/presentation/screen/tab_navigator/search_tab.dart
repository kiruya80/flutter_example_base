import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_base/presentation/screen/search_query_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/print_log.dart';
import '../detail_screen.dart';


final _homeNavKey = GlobalKey<NavigatorState>();

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _homeNavKey,
      onGenerateRoute: (settings) {
        if (settings.name == '/search/detail') {
          return MaterialPageRoute(
            builder: (_) => DetailScreen(title: 'search Detail'),
          );
        }
        return MaterialPageRoute(
          builder: (_) => ProfileScreen2(),
        );
      },
    );
  }
}
class ProfileScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Go to detail from search'),
        onPressed: () => _homeNavKey.currentState?.pushNamed('/search/detail'),
      ),
    );
  }
}