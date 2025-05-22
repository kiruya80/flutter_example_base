import 'package:flutter/material.dart';
import 'package:flutter_example_base/presentation/routes/app_router.dart';

import 'package:flutter_example_base/utils/print_log.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    QcLog.d('My App build');

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    // );
    // return MaterialApp.router(
    //     theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    //     routerConfig: shellRouter);

    return MaterialApp.router(
      routerConfig: shellTabRouter,
      title: 'GoRouter Tabs Demo',
      // theme: ThemeData(primarySwatch: Colors.blue),
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    );
  }
}


class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  static const tabs = ['/home', '/search', '/profile'];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = tabs.indexWhere((tab) => location.startsWith(tab));
    QcLog.d('build  location : $location , currentIndex : $currentIndex');

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex < 0 ? 0 : currentIndex,
        onTap: (index) => context.go(tabs[index]),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}