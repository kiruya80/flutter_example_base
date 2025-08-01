import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/print_log.dart';
import '../../shared/state/base_con_state.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final String? id;

  /// path
  final String? title;
  final String? query;

  const DetailScreen({super.key, this.id, this.title, this.query});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends BaseConState<DetailScreen> {
  @override
  void initState() {
    super.initState();
    _loadDataSafely();
  }

  Future<void> _loadDataSafely() async {
    await Future.delayed(const Duration(seconds: 2));

    // ✅ 안전하게 상태 업데이트
    if (isThisPageVisible == false) {
      return;
    }
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(content: Text('데이터 도착')),
    );
  }

  @override
  Widget build(BuildContext context) {
    QcLog.d('build =====  $isThisPageVisible ');
    QcLog.d(
      'path ===== id: ${widget.id} , queryStr query : ${widget.query} ,  title : ${widget.title}',
    );
    // final currentLocation = GoRouter.of(context).location;
    // print('현재 경로: $currentLocation');

    return Scaffold(
      appBar: AppBar(title: Text('${widget.title}')),
      body: Center(
        child: Column(
          children: [
            Text(
              'id: ${widget.id} , queryStr query : ${widget.query} ,  title : ${widget.title}',
            ),
            ElevatedButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop(); // 뒤로 가기
                }
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
