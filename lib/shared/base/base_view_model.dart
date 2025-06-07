import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/error/failures.dart';
import 'base_ui_status.dart';

///
/// BaseViewModel – 공통 뷰모델
///
/// 	•	모든 ViewModel의 베이스
/// 	•	setLoading, setError, setNavigateTo 등 공통 메서드 제공
///
/// setupErrorListener(ref, postListViewModelProvider);
/// setupLoadingListener(ref, postListViewModelProvider);
/// setupNavigationListener(ref, postListViewModelProvider);
///
abstract class BaseViewModel<T extends BaseUiStatus> extends StateNotifier<T> {
  BaseViewModel(super.state);

  void setLoading(bool isLoading) {
    state = updateState(isLoading: isLoading);
  }

  void setError(Failure error) {
    state = updateState(error: error);
  }

  void setNavigateTo(String route) {
    state = updateState(navigateTo: route);
  }

  T updateState({bool? isLoading, Failure? error, String? navigateTo});

  // BaseViewModel(T state) : super(state);
  //
  // void setLoading(bool isLoading) {
  //   state = updateState(state, isLoading: isLoading);
  // }
  //
  // void setError(Failure error) {
  //   state = updateState(state, error: error, isLoading: false);
  // }
  //
  // void setNavigateTo(String? route) {
  //   state = updateState(state, navigateTo: route);
  // }
  //
  // T updateState(
  //     T current, {
  //       bool? isLoading,
  //       Failure? error,
  //       String? navigateTo,
  //     });
}
