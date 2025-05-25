import 'package:flutter/material.dart';
import 'package:flutter_example_base/presentation/routes/app_router.dart';
import 'package:flutter_example_base/presentation/routes/app_routes.dart';
import 'package:flutter_example_base/presentation/routes/tab_navigator/app_router.dart';

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

    // return MaterialApp.router(
    //   routerConfig: shellRouter,
    //   title: 'GoRouter Tabs Demo',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    // );

    /// 바텀네비게이터
    return MaterialApp.router(
      routerConfig: AppRouter.shellTabRouter,
      title: 'GoRouter Tabs Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    );
  }
}

/// 바텀네비게이터
class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell shell;

  const ScaffoldWithNavBar({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: shell.currentIndex,
        onTap: (index) {
          // QcLog.d(
          //   'state before ===== ${GoRouterState.of(context).topRoute.toString()} , ${GoRouterState.of(context).uri} , ${shell.currentIndex} ',
          // );

          TabChangeObserver.onTabChanged(index);
          shell.goBranch(index);

        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}

class TabChangeObserver {
  static int _lastIndex = 0;

  static void onTabChanged(int newIndex) {
    if (_lastIndex != newIndex) {
      debugPrint('🟢 탭 변경: $_lastIndex -> $newIndex');
      _lastIndex = newIndex;
    }
  }
}

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  // static   List<String> tabs = ['/home', '/search', '/profile'];
  static List<String> tabs = [
    AppTabRoutes.home.path,
    AppTabRoutes.search.path,
    AppTabRoutes.profile.path,
  ];

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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: AppTabRoutes.home.name),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: AppTabRoutes.search.name),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: AppTabRoutes.profile.name),
        ],
      ),
    );
  }
}
