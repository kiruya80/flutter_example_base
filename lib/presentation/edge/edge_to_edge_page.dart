import 'dart:ui';

import 'package:flutter/cupertino.dart';
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
    // final primaryColor = Theme.of(context).primaryColor;
    final primaryColor = Theme.of(context).colorScheme.primary;

    final brightness = MediaQuery.of(context).platformBrightness;

    if (brightness == Brightness.dark) {
      QcLog.d("디바이스 테마 : 🌙 다크 모드입니다");
    } else {
      QcLog.d("디바이스 테마 : ☀️ 라이트 모드입니다");
    }

    return CommonEdgeToEdgePage(
      backgroundColor: Colors.white,
      // statusBarColor: primaryColor,
      // isStatusBlur: true,
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



    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   body: Stack(
    //     children: [
    //       // 전체 배경 (예: 이미지나 컬러)
    //       Container(
    //         decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //             colors: [Colors.blue.shade300, Colors.purple.shade300],
    //             begin: Alignment.topCenter,
    //             end: Alignment.bottomCenter,
    //           ),
    //         ),
    //       ),
    //       // 배경 이미지 또는 배경색
    //       Image.network(
    //         'https://picsum.photos/600/800',
    //         fit: BoxFit.cover,
    //         height: double.infinity,
    //         width: double.infinity,
    //       ),
    //
    //       // ✅ 상태바 영역에만 blur + 반투명 배경
    //       ClipRect(
    //         child: BackdropFilter(
    //           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
    //           child: Container(
    //             height: statusBarHeight,
    //             color: Colors.white.withOpacity(0.2), // 반투명 오버레이
    //           ),
    //         ),
    //       ),
    //
    //       // 본문
    //       Positioned.fill(
    //         child: Column(
    //           children: [
    //             SizedBox(height: statusBarHeight + kToolbarHeight), // 상태바 + 앱바 높이만큼 띄우기
    //             Expanded(
    //               child: Center(
    //                 child: Text(
    //                   '상단 상태바 영역에 블러 적용됨',
    //                   style: TextStyle(fontSize: 18, color: Colors.white),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  getIosStyle() {

    /// 2. ios 스타일
    return CupertinoPageScaffold(
      /// 상단 앱바
      // navigationBar: const CupertinoNavigationBar(
      //   middle: Text('Cupertino Navigation'),
      //   backgroundColor: Color(0xCCFFFFFF), // 반투명 흰색
      //   border: null, // 테두리 제거하면 더 깔끔
      // ),
      /// 상단 앱바에서 백버튼 제거
      navigationBar: const CupertinoNavigationBar(
        automaticallyImplyLeading: false, // ⛔ 자동 백버튼 생성 방지
        middle: null, // 타이틀 없음
        leading: null, // 백버튼 없음
        border: null, // 하단 경계선 없음
        backgroundColor: Color(0xCCFFFFFF), // 반투명 + 블러
      ),
      child: ListView.builder(
        // padding: const EdgeInsets.only(top: 100),
        itemCount: 30,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Item $index'),
        ),
      ),
      // child: Center(
      //   child: CupertinoButton(
      //     child: const Text('뒤로가기'),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      // ),
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
