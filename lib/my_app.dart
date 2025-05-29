import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app/routes/app_router.dart';
import 'core/utils/print_log.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    QcLog.d('My App build');

    /// 기본
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    // );

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    //   // home: const CounterScreen(),
    //   home: const PostListScreen(),
    // );

    /// 바텀네비게이터
    // return MaterialApp.router(
    //   routerConfig: AppRouter.shellTabRouter,
    //   title: 'GoRouter Tabs Demo',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    // );

    // final router = ref.watch(rootRouterProvider);
    // return MaterialApp.router(
    //   routerConfig: router,
    // );

    return MaterialApp.router(
      routerConfig: AppRouter.appRouter,
      title: 'Post App',
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
        type: BottomNavigationBarType.fixed, // 4개 이상일 경우 필요
        onTap: (index) {
          QcLog.d(
            'state before ===== ${GoRouterState.of(context).topRoute.toString()} , ${GoRouterState.of(context).uri} , ${shell.currentIndex} ',
          );

          // if (index == shell.currentIndex) {
          if (TabChangeObserver.onTabChanged(index)) {
            /// todo 만약 홈탭으로 돌아오고 리빌드 하고 싶을때는 프로바이더나 이벤트 버스등 명시적 호출 필요
            /// if (index == 0) {
            ///   eventBus.fire(HomeTabSelectedEvent());
            ///   homeTabNotifier.refresh();
            /// }
            ///
            /// 동일한 탭 다시 클릭하는 경우 홈으로 이동하게
            shell.goBranch(index, initialLocation: true);
          } else {
            shell.goBranch(index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}

class TabChangeObserver {
  static int _lastIndex = 0;

  static bool onTabChanged(int newIndex) {
    if (_lastIndex != newIndex) {
      debugPrint('🟢 탭 변경: $_lastIndex -> $newIndex');
      _lastIndex = newIndex;
      return false;
    } else {
      return true;
    }
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// class MainScaffold extends StatelessWidget {
//   final Widget child;
//
//   const MainScaffold({super.key, required this.child});
//
//   // static   List<String> tabs = ['/home', '/search', '/profile'];
//   static List<String> tabs = [
//     AppTabRoutes.home.path,
//     AppTabRoutes.search.path,
//     AppTabRoutes.profile.path,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final location = GoRouterState.of(context).uri.toString();
//     final currentIndex = tabs.indexWhere((tab) => location.startsWith(tab));
//     QcLog.d('build  location : $location , currentIndex : $currentIndex');
//
//     return Scaffold(
//       body: child,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex < 0 ? 0 : currentIndex,
//         onTap: (index) => context.go(tabs[index]),
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: AppTabRoutes.home.name),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: AppTabRoutes.search.name),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: AppTabRoutes.profile.name),
//         ],
//       ),
//     );
//   }
// }
