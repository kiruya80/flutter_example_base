import 'package:flutter/material.dart';
import 'package:flutter_example_base/presentation/splash/splash_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/print_log.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    QcLog.d('initState ====== ');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _init();
    });
  }

  Future<void> _init() async {
    final result = await ref.read(splashViewModelProvider.notifier).checkAuthStatus();

    if (!mounted) return;

    result
        ? context.go('/posts') // 로그인 성공
        : context.go('/posts'); // 비로그인도 목록은 접근 가능하게
    // context.go('/login'); // 로그인 필수라면 이 라인 사용
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
