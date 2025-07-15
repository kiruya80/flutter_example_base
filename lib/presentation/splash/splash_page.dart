import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example_base/core/utils/common_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_routes_info.dart';
import '../../core/utils/print_log.dart';
import '../../shared/state/base_con_state.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseConState<SplashPage> {
  // 100개의 샘플 텍스트 리스트 생성
  final items = List.generate(100, (index) => 'Item ${index + 1}');

  @override
  void initState() {
    super.initState();
    QcLog.d('initState ====== ');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _init();
    });
  }

  Future<void> _init() async {
    if (mounted) {
      context.goNamed(AppRoutesInfo.tabHome.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonUtils.isTablet(context);

    return Scaffold(
      appBar: AppBar(title: Text('SplashPage')),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.blue,
        child: Center(child: Column(children: [CircularProgressIndicator()])),
      ),
    );
  }
}
