import '../../core/error/failures.dart';
import '../../domain/auth/entities/user.dart';
import '../../domain/common/entities/route_info.dart';
import '../../shared/base/base_ui_status.dart';

class AuthState extends BaseUiStatus {
  final bool? isLoggedIn;
  final User? user;
  final String? errorMessage;

  const AuthState({
    this.isLoggedIn,
    this.user,
    this.errorMessage,
    super.isLoading,
    super.error,
    super.navigateTo,
  });

  factory AuthState.initial() =>
      const AuthState(isLoading: false, isLoggedIn: false);

  factory AuthState.loggedOut() =>
      AuthState(isLoggedIn: false, isLoading: false);

  factory AuthState.loggedIn(User user) =>
      AuthState(isLoggedIn: true, user: user, isLoading: false);

  AuthState copyWith({
    bool? isLoggedIn,
    User? user,
    String? errorMessage,

    bool? isLoading,
    Failure? error,
    RouteInfo? navigateTo,
  }) {
    return AuthState(
      isLoggedIn: isLoading ?? this.isLoggedIn,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,

      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      navigateTo: navigateTo ?? this.navigateTo,
    );
  }
}
