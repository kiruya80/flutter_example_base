import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IntroPage extends ConsumerStatefulWidget {
  const IntroPage({super.key});

  @override
  ConsumerState<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends ConsumerState<IntroPage> {
  @override
  void initState() {
    super.initState();
    QcLog.d('initState ====== ');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _moveToSplash();
    });
  }

  Future<void> _moveToSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go('/splash');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'MyApp',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
