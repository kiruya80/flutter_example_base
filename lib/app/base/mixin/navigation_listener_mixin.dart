import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base_ui_status.dart';

///
/// 1. mixin
/// 	•	ViewModel이 특정 이벤트 후 화면 전환을 원할 때:
/// 	•	예: 글 작성 완료 후 → 리스트 화면으로 이동
/// 	•	로그인 성공 후 → 메인 화면으로 이동
///
// mixin ErrorListenerMixin<T>  {
mixin NavigationListenerMixin<T extends StatefulWidget> on State<T> {
  late ProviderSubscription<BaseUiStatus> _subscription;

  void setupNavigationListener(WidgetRef ref, ProviderListenable<BaseUiStatus> provider) {
    _subscription = ref.listenManual<BaseUiStatus>(provider, (_, next) {
      if (next.navigateTo != null) {
        Navigator.of(context).pushNamed(next.navigateTo!);
      }
    });
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
