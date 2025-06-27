import 'package:flutter/material.dart';
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
    // if (mounted) {
    //   context.goNamed(AppRoutesInfo.tabHome.name);
    // }
  }

  @override
  Widget build(BuildContext context) {
    CommonUtils.isTablet(context);

    // return Scaffold(
    //   appBar: AppBar(title: Text('SplashPage')),
    //   backgroundColor: Colors.white,
    //   body: Container(
    //       color: Colors.blue,
    //     child: Center(
    //       child: Column(
    //         children: [
    //           CircularProgressIndicator(),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    // return getEdgeToEdge();

    return material();

  }

  ///
  /// 기본적으로 AppBar는 body 위에 위치하지만, body는 AppBar 아래부터 시작합니다.
  ///
  /// extendBodyBehindAppBar: true,를 하면
  /// body가 상단 status bar + AppBar 영역까지 확장
  /// AppBar가 투명하면, 마치 화면 맨 위부터 body가 그려지는 것처럼 보임
  ///
  /// kToolbarHeight : AppBar 높이 (보통 56dp)
  ///
  getEdgeToEdge() {
    final paddingTop = MediaQuery.of(context).padding.top;
    // 실제 시스템 바 영역 (상태바, 내비게이션바)
    final viewPadding = MediaQuery.of(context).viewPadding;
    // 키보드 등으로 인해 “가려지는 영역”
    final viewInsets = MediaQuery.of(context).viewInsets;
    // viewPadding === EdgeInsets(0.0, 28.6, 0.0, 48.0) , viewInsets === EdgeInsets.zero
    QcLog.d('paddingTop === $paddingTop , viewPadding === $viewPadding , viewInsets === $viewInsets');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Title'),
        backgroundColor: Colors.transparent, // 중요
        elevation: 0,
      ),
      body: SafeArea(
        top: false, // 직접 처리할 것이므로 false
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.orange],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(items[index]),
                subtitle: Text('This is item number ${index + 1}'),
              );
            },
          ),
        ),
      ));

    //   body: Padding(
    //     padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    //     child: CustomScrollView(
    //       slivers: [
    //         SliverAppBar(
    //           backgroundColor: Colors.transparent,
    //           elevation: 0,
    //           pinned: true,
    //           expandedHeight: 120,
    //           flexibleSpace: FlexibleSpaceBar(
    //             title: Text('제목'),
    //           ),
    //         ),
    //         SliverList(
    //           delegate: SliverChildBuilderDelegate(
    //                 (context, index) => ListTile(title: Text('Item $index')),
    //             childCount: 100,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  material() {
          return Scaffold(
      appBar: AppBar(
        title: const Text('Material 3 Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated Button'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {},
              child: const Text('Filled Button'),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
          ],
        ),
      ),
    );
  }
}
