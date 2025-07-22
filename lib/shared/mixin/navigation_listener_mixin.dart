import 'package:flutter_example_base/core/extensions/string_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/print_log.dart';
import '../../app/routes/router_controller.dart';
import '../base/base_ui_status.dart';

///
/// 1. mixin
/// 	•	ViewModel이 특정 이벤트 후 화면 전환을 원할 때:
/// 	•	예: 글 작성 완료 후 → 리스트 화면으로 이동
/// 	•	로그인 성공 후 → 메인 화면으로 이동
///
mixin NavigationListenerMixin<T extends BaseUiStatus, W extends ConsumerStatefulWidget>
    on ConsumerState<W> {
  late ProviderSubscription<T> _subscription;

  void setupNavigationListener(ProviderListenable<T> provider) {
    _subscription = ref.listenManual<T>(provider, (prev, next) {
      QcLog.d('listenManual ==== ${prev?.error} , ${next.error}');
      if (next.navigateTo != null && next.navigateTo?.path.isNotNullOrEmpty == true) {
        RouterController.instance.pushName(next.navigateTo!);
      }
    });
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
