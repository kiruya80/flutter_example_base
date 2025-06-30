import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/utils/common_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/print_log.dart';
import '../../shared/state/base_con_state.dart';
import '../../shared/widgets/common_edge_to_edge_page.dart';

class EdgeToEdgePage extends ConsumerStatefulWidget {
  const EdgeToEdgePage({super.key});

  @override
  ConsumerState<EdgeToEdgePage> createState() => _EdgeToEdgePageState();
}

class _EdgeToEdgePageState extends BaseConState<EdgeToEdgePage> {
  // 100개의 샘플 텍스트 리스트 생성
  final items = List.generate(30, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    CommonUtils.isTablet(context);
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    QcLog.d('statusBarHeight === $statusBarHeight , bottomInset === $bottomInset');

    // return getEdgeToEdge1();
    // return getEdgeToEdge2();
    // return material();
    // return CommonEdgeToEdgePage(child: getEdgeToEdge());

    return CommonEdgeToEdgePage(
      child: ListView.builder(
        /// 상하단에 공간
        /// 상단은 스테이터스바 겹치지 않고
        /// 하단은 네비게이션에 가르지 않게
        padding: EdgeInsets.only(top: statusBarHeight, bottom: bottomInset),
        itemCount: items.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(items[index]),
            subtitle: Text('This is item number ${index + 1}'),
          );
        },
      ),
    );
  }

  getEdgeToEdge() {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.lightGreenAccent.withValues(
      //   alpha:0.5,
      // ),
      // backgroundColor: Colors.lightGreenAccent.withOpacity(0.1),
      // appBar: AppBar(title: const Text('EdgeToEdge'), backgroundColor: Colors.transparent),
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView.builder(
          /// 상하단에 공간
          /// 상단은 스테이터스바 겹치지 않고
          /// 하단은 네비게이션에 가르지 않게
          padding: EdgeInsets.only(top: statusBarHeight, bottom: bottomInset),
          itemCount: items.length,
          itemBuilder: (_, index) {
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(items[index]),
              subtitle: Text('This is item number ${index + 1}'),
            );
          },
        ),
      ),
    );
  }

  getEdgeToEdge1() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text('Title'),
        backgroundColor: Colors.transparent, // 중요
        // backgroundColor: Colors.cyanAccent,
        elevation: 0,
      ),
      body: SafeArea(
        top: false, // 직접 처리할 것이므로 false
        bottom: false,
        maintainBottomViewPadding: true,
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
      ),
    );
  }

  material() {
    return Scaffold(
      appBar: AppBar(title: const Text('Material 3 Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('Elevated Button'),
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: () {}, child: const Text('Filled Button')),
            const SizedBox(height: 20),
            OutlinedButton(onPressed: () {}, child: const Text('Outlined Button')),
          ],
        ),
      ),
    );
  }
}
