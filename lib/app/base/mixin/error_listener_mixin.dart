import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/print_log.dart';
import '../../../presentation/dialog/dialog_request.dart';
import '../base_ui_status.dart';
import '../../../presentation/dialog/dialog_controller.dart';

///
/// 1. mixin
///
mixin ErrorListenerMixin<T extends BaseUiStatus, W extends ConsumerStatefulWidget>
    on ConsumerState<W> {
  late ProviderSubscription<T> _subscription;

  void setupErrorListener(WidgetRef ref, ProviderListenable<T> provider) {
    _subscription = ref.listenManual<T>(provider, (prev, next) {
      QcLog.d('ErrorListenerMixin listenManual ==== ${prev?.error} , ${next.error}');
      if (next.error != null) {
        DialogController(
          ref,
        ).showDialog(DialogRequest(type: DialogType.error, title: "에러", message: next.error!.message));
      }
    });
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
