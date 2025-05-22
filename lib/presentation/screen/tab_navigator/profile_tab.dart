import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/print_log.dart';
import '../detail_screen.dart';
import '../profile_screen.dart';

final _homeNavKey = GlobalKey<NavigatorState>();

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _homeNavKey,
      onGenerateRoute: (settings) {
        if (settings.name == '/profile/Detail') {
          return MaterialPageRoute(
            builder: (_) => DetailScreen(title: 'profile Detail'),
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
        child: Text('Go to Detail from profile'),
        onPressed: () => _homeNavKey.currentState?.pushNamed('/profile/Detail'),
      ),
    );
  }
}