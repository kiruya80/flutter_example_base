import '../../domain/auth/entities/user.dart';

class AuthState {
  final bool? isLoggedIn;
  final User? user;
  final bool? isLoading;
  final String? errorMessage;

  const AuthState({
    this.isLoggedIn,
    this.user,
    this.isLoading,
    this.errorMessage,
  });

  factory AuthState.initial() => const AuthState(
        isLoading: false,
        isLoggedIn: false,
      );

  factory AuthState.loggedOut() => AuthState(
        isLoggedIn: false,
        isLoading: false,
      );

  factory AuthState.loggedIn(User user) => AuthState(
        isLoggedIn: true,
        user: user,
        isLoading: false,
      );

  AuthState copyWith({
    bool? isLoggedIn,
    User? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      isLoggedIn: isLoading ?? this.isLoggedIn,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
