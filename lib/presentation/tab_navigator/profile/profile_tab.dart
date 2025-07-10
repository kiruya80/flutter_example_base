import 'package:flutter/material.dart';
import 'package:flutter_example_base/core/extensions/color_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/print_log.dart';
import '../../../app/routes/app_routes_info.dart';
import '../../../core/theme/app_theme_provider.dart';
import '../../../shared/state/base_con_state.dart';
import '../../../shared/widgets/edge_custom_scrollview.dart';
import '../../widgets/item_title.dart';
import '../../widgets/router_move_item.dart';

enum EdgeToEdgeType { Default, Common, Refresh, CommonRefresh, CustomScrollView, iosCupertino }

class ProfileTab extends ConsumerStatefulWidget {
  final ScrollController? mainNavScrollController;

  const ProfileTab({super.key, this.mainNavScrollController});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends BaseConState<ProfileTab> {
  bool? isDark;

  @override
  Widget build(BuildContext context) {
    QcLog.d('build ===== $isThisPageVisible');
    // final shellRouteState = StatefulShellRoute.of(context);
    // print('현재 탭 인덱스: ${shellRouteState.currentIndex}');

    /// theme
    final appThemeMode = ref.watch(appThemeModeProvider);
    isDark = appThemeMode == ThemeMode.dark;
    QcLog.d("앱 테마 : ${isDark == true ? "🌙 다크 모드입니다" : "☀️ 라이트 모드입니다"}");

    return EdgeCustomScrollview(
      content: SingleChildScrollView(
        controller: widget.mainNavScrollController,
        child: _getMoveEdgeToEdge(),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      isRefresh: false,
      //   isMoreDataScroll: MoreDataScroll.HAS,
    );
  }

  _content() {
    return Container(
      color: Colors.deepPurple.withOpacitySafe(0.6),
      child: SingleChildScrollView(
        controller: widget.mainNavScrollController,
        child: _getMoveEdgeToEdge(),
      ),
    );
  }

  _getMoveEdgeToEdge() {
    return Column(
      children: [
        ItemTitle('앱 테마 : ${isDark == true ? "🌙 다크 모드" : "☀️ 라이트 모드"}'),

        RouterMoveItem('테마 변경', () {
          QcLog.d('테마변경 === ');
          // final appThemeMode = ref.read(appThemeModeProvider);
          // isDark = appThemeMode == ThemeMode.dark;
          ref.read(appThemeModeProvider.notifier).state =
              (isDark ?? false) ? ThemeMode.light : ThemeMode.dark;
        }),

        RouterMoveItem('edgeToEdge Default', () {
          context.pushNamed(
            AppRoutesInfo.edgeToEdge.name,
            pathParameters: {'id': 'id_123'},
            queryParameters: {'type': EdgeToEdgeType.Default.name, 'isAppbar': 'false'},
          );
        }),

        RouterMoveItem('edgeToEdge Common', () {
          context.pushNamed(
            AppRoutesInfo.edgeToEdge.name,
            pathParameters: {'id': 'id_123'},
            queryParameters: {'type': EdgeToEdgeType.Common.name, 'isAppbar': 'false'},
          );
        }),

        RouterMoveItem('edgeToEdge Common Appbar', () {
          context.pushNamed(
            AppRoutesInfo.edgeToEdge.name,
            pathParameters: {'id': 'id_123'},
            queryParameters: {'type': EdgeToEdgeType.Common.name, 'isAppbar': 'true'},
          );
        }),

        RouterMoveItem('edgeToEdge Refresh', () {
          context.pushNamed(
            AppRoutesInfo.edgeToEdge.name,
            pathParameters: {'id': 'id_123'},
            queryParameters: {'type': EdgeToEdgeType.Refresh.name, 'isAppbar': 'true'},
          );
        }),

        RouterMoveItem('edgeToEdge CommonRefresh', () {
          context.pushNamed(
            AppRoutesInfo.edgeToEdge.name,
            pathParameters: {'id': 'id_123'},
            queryParameters: {'type': EdgeToEdgeType.CommonRefresh.name, 'isAppbar': 'true'},
          );
        }),

        RouterMoveItem('CustomScrollView', () {
          context.pushNamed(
            AppRoutesInfo.edgeToEdge.name,
            pathParameters: {'id': 'id_123'},
            queryParameters: {'type': EdgeToEdgeType.CustomScrollView.name, 'isAppbar': 'false'},
          );
        }),

        RouterMoveItem('CustomScrollView isAppbar', () {
          context.pushNamed(
            AppRoutesInfo.edgeToEdge.name,
            pathParameters: {'id': 'id_123'},
            queryParameters: {'type': EdgeToEdgeType.CustomScrollView.name, 'isAppbar': 'true'},
          );
        }),

        RouterMoveItem('edgeToEdge iosCupertino', () {
          context.pushNamed(
            AppRoutesInfo.edgeToEdge.name,
            pathParameters: {'id': 'id_123'},
            queryParameters: {'type': EdgeToEdgeType.iosCupertino.name, 'isAppbar': 'true'},
          );
        }),

        RouterMoveItem('=====', () {}),
        RouterMoveItem('=====', () {}),
        RouterMoveItem('=====', () {}),
        RouterMoveItem('=====', () {}),
        RouterMoveItem('=====', () {}),
        RouterMoveItem('=====', () {}),
        RouterMoveItem('=====', () {}),
        RouterMoveItem('=====', () {}),
        RouterMoveItem('=====', () {}),
        RouterMoveItem('=====', () {}),
        RouterMoveItem('=====', () {}),
        RouterMoveItem('=====', () {}),
      ],
    );
  }

  ///
  /// router 이동 테스트
  ///
  _getMoveRouter() {
    return Column(
      children: [
        ItemTitle('context goNamed'),

        RouterMoveItem('goNamed(profileDetail)', () {
          context.goNamed(AppRoutesInfo.profileDetail.name);
        }, isError: true),
        RouterMoveItem('goNamed(profileDetail, \npathParameters: {id: 123})', () {
          context.goNamed(AppRoutesInfo.profileDetail.name, pathParameters: {'id': '123'});
        }),
        RouterMoveItem('goNamed(profileDetail, \nqueryParameters: {title: profile})', () {
          context.goNamed(AppRoutesInfo.profileDetail.name, queryParameters: {'title': 'profile'});
        }, isError: true),

        ItemTitle('context pushNamed'),
        RouterMoveItem('push(/profile/detail, \npathParameters: {id: 123}', () {
          context.pushNamed(AppRoutesInfo.profileDetail.name, pathParameters: {'id': '123'});
        }),
      ],
    );
  }
}
