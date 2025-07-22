import 'package:flutter/cupertino.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/controller/dialog_controller.dart';
import '../base/base_ui_status.dart';
import '../base/base_view_model.dart';

///
/// 1. mixin
///  ㄴ BaseUiStatus의 상태 값에 따라 다이얼로그
///  mixin이나 ViewModel은 “무엇을 띄울지”까지만 결정
///
///  	•	첫 번째 제네릭 <T>는 ViewModel의 상태 (PostListState)를 의미하고
///     T extends BaseUiStatus를 사용하는 이유는 프로바이더의 상태에서 isLoading을 가져오기 위해
///
/// 	•	두 번째 제네릭 <W>는 ConsumerStatefulWidget (즉 화면 위젯 클래스, PostListScreen)를 의미합니다.
///     void dispose() 에서 ProviderSubscription<T> _subscription 해제를 위해서
///
///  	•	LoadingListenerMixin, ErrorListenerMixin, NavigationListenerMixin
/// 	•	각각 isLoading, error, navigateTo를 수신하여 적절한 다이얼로그 또는 네비게이션 실행
///
///  LoadingListenerMixin, ErrorListenerMixin, NavigationListenerMixin – 상태 리스너 믹스인
///
/// 위젯에서 ViewModel/mixin > settup에서 프로바이더를 설정하고
/// 프로바이더 listener로 감지
///
/// 예: ViewModel에서 로딩 시작 → mixin에서 감지 → dialogController.enqueue
///
/// → DialogQueueListener 감지 → showDialog(CircularProgressIndicator) 실행
///
/// → DialogController.enqueue(dialogRequest) → DialogQueueListener 감지 → showDialog(...)
///
// mixin LoadingListenerMixin<T>  {
mixin LoadingListenerMixin<T extends BaseUiStatus, W extends ConsumerStatefulWidget>
    on ConsumerState<W> {
  late ProviderSubscription<T> _subscription;

  void setupLoadingListener(ProviderListenable<T> provider) {
    _subscription = ref.listenManual<T>(provider, (prev, next) {
      QcLog.d(
        'LoadingListenerMixin listenManual ==== ${prev?.isLoading} , ${next.isLoading} / ${next.error}',
      );
      // final wasLoading = prev?.isLoading ?? false;
      final isLoading = next.isLoading;

      // if (wasLoading == false && isLoading == true) {
      if (isLoading == true) {
        DialogController(ref).showLoading();
      }

      // if (wasLoading == true && isLoading == false) {
      if (isLoading == false) {
        DialogController(ref).hideLoading();
      }
    });
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

// mixin LoadingListenerMixin<T extends StatefulWidget> on State<T> {
//   late ProviderSubscription<BaseUiStatus> _subscription;
//
//   void setupLoadingListener(WidgetRef ref, ProviderListenable<BaseUiStatus> provider) {
//     _subscription = ref.listenManual<BaseUiStatus>(
//       provider,
//           (_, next) {
//         if (next.isLoading) {
//           DialogController.instance.showLoading();
//         } else {
//           DialogController.instance.hideLoading();
//         }
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     QcLog.d('dispose === ');
//     _subscription.close();
//     super.dispose();
//   }
// }

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
