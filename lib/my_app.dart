import 'package:flutter/material.dart';
import 'package:flutter_example_base/presentation/routes/app_router.dart';

import 'package:flutter_example_base/utils/print_log.dart';

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
    return MaterialApp.router(routerConfig: router);
  }
}
