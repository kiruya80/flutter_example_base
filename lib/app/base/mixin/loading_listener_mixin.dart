import 'package:flutter/cupertino.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base_ui_status.dart';
import '../../../presentation/dialog/dialog_controller.dart';

///
/// 1. mixin
///
// mixin LoadingListenerMixin<T>  {
mixin LoadingListenerMixin<T extends StatefulWidget> on State<T> {
  late ProviderSubscription<BaseUiStatus> _subscription;
  // ProviderSubscription? _loadingSubscription;

  void setupLoadingListener(WidgetRef ref, ProviderListenable<BaseUiStatus> provider) {
    _subscription = ref.listenManual<BaseUiStatus>(
      provider,
          (_, next) {
        if (next.isLoading) {
          DialogController.instance.showLoading();
        } else {
          DialogController.instance.hideLoading();
        }
      },
    );
  }

  @override
  void dispose() {
    QcLog.d('dispose === ');
    _subscription.close();
    super.dispose();
  }

  // void setupLoadingListener(WidgetRef ref, ProviderListenable<T> provider) {
  //   _loadingSubscription = ref.listenManual<T>(provider, (previous, next) {
  //     final wasLoading = _getIsLoading(previous);
  //     final isLoading = _getIsLoading(next);
  //
  //     if (wasLoading != isLoading) {
  //       if (isLoading) {
  //         DialogController.instance.showLoading();
  //       } else {
  //         DialogController.instance.hideLoading();
  //       }
  //     }
  //   });
  // }

  // void disposeLoadingListener() {
  //   _loadingSubscription?.close();
  // }
  // bool _getIsLoading(dynamic state) {
  //   try {
  //     return state?.isLoading == true;
  //   } catch (_) {
  //     return false;
  //   }
  // }
}

///
/// 2. ProviderLoadingListener
///  ✅ 로딩 리스너 등록
///  proSub = ProviderLoadingListener.listenManual(ref, postListViewModelProvider);
///
/// dispose에서 해제 proSub?.close();
///
// class ProviderLoadingListener {
//   ///
//   /// state가 `isLoading`이라는 bool 필드를 가진다고 가정합니다.
//   /// ProviderBaseState
//   ///
//   // static ProviderSubscription listenManual<T>(WidgetRef ref, ProviderListenable<T> provider) {
//   //   return ref.listenManual<T>(provider, (prev, next) {
//   static ProviderSubscription listenManual<ProviderBaseState>(
//     WidgetRef ref,
//     ProviderListenable<ProviderBaseState> provider,
//   ) {
//     return ref.listenManual<ProviderBaseState>(provider, (prev, next) {
//       final prevLoading = _getIsLoading(prev);
//       final nextLoading = _getIsLoading(next);
//       QcLog.d('listenManual ==== prevLoading nextLoading ===== ${prevLoading}, ${nextLoading}');
//
//       if (prevLoading != nextLoading) {
//         if (nextLoading) {
//           DialogController.instance.showLoading();
//         } else {
//           DialogController.instance.hideLoading();
//         }
//       }
//     });
//   }
//
//   static bool _getIsLoading(dynamic state) {
//     if (state is ProviderBaseState) {
//       return state.isLoading == true;
//     } else {
//       return false;
//     }
//     // try {
//     //   return state.isLoading == true;
//     // } catch (_) {
//     //   return false;
//     // }
//   }
// }
