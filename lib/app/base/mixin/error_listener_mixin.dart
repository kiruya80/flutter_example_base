import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base_ui_status.dart';
import '../../../presentation/dialog/dialog_controller.dart';

///
/// 1. mixin
///
// mixin ErrorListenerMixin<T>  {
mixin ErrorListenerMixin<T extends StatefulWidget> on State<T> {
  late ProviderSubscription<BaseUiStatus> _subscription;

  void setupErrorListener(WidgetRef ref, ProviderListenable<BaseUiStatus> provider) {
    _subscription = ref.listenManual<BaseUiStatus>(provider, (_, next) {
      if (next.error != null) {
        DialogController.instance.showError(next.error.toString());
      }
    });
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
