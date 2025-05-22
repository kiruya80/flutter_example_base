import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/print_log.dart';
import '../detail_screen.dart';
import '../home_screen.dart';

final _homeNavKey = GlobalKey<NavigatorState>();

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _homeNavKey,
      onGenerateRoute: (settings) {
        if (settings.name == '/home/detail') {
          return MaterialPageRoute(
            builder: (_) => DetailScreen(title: 'Home Detail'),
          );
        }
        return MaterialPageRoute(
          builder: (_) => HomeScreen2(),
        );
      },
    );
  }
}
class HomeScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Go to Detail from Home'),
        onPressed: () => _homeNavKey.currentState?.pushNamed('/home/detail'),
      ),
    );
  }
}