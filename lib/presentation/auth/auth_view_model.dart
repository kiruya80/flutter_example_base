import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/failures.dart';
import '../../domain/auth/entities/user.dart';
import '../../domain/auth/usecases/login.dart';
import 'auth_state.dart';

///
/// 뷰모델 생성자로
/// ✅ 정답: 유스케이스(loginProvider)를 넘기는 것이 정석입니다
///
/// ✅ 왜 유스케이스를 넘기나요?
///
/// 🔹 클린 아키텍처의 핵심 원칙: 레이어 간의 의존은 “안쪽으로”만 가능
/// 	•	ViewModel은 유스케이스(도메인 계층)에 의존
/// 	•	유스케이스는 레포지토리에 의존
/// 	•	레포지토리는 data source에 의존
///
/// 그래서 ViewModel은 절대 repository에 직접 접근하면 안 됩니다.
///
//  AuthViewModel
//    ↓ 의존
//  Login (UseCase)
//    ↓ 의존
//  AuthRepository
//    ↓ 의존
//  AuthRemoteDataSource (Retrofit)
///
// 🔹 AuthViewModel: ViewModel은 UseCase만 알고 있음
class AuthViewModel extends StateNotifier<AuthState> {
  final Login login;

  AuthViewModel(this.login) : super(AuthState.initial());

  Future<bool> loginUser(int userId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await login(LoginParams(id:'$userId'));
    return result.fold(
      (Failure failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
        return false;
      },
      (_) {
        // state = state.copyWith(isLoading: false);
        state =  AuthState.loggedIn(User());
        return true;
      },
    );
  }
}
