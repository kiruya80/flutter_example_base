import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/error/failures.dart';
import '../../domain/auth/entities/user.dart';
import '../../domain/common/entities/route_info.dart';
import '../../shared/base/base_ui_status.dart';

part 'auth_state.freezed.dart';

part 'auth_state.g.dart';

@freezed
abstract class AuthState with _$AuthState implements BaseUiStatus {
  const factory AuthState({
    bool? isLoggedIn,
    User? user,
    String? errorMessage,
    bool? isLoading,
    Failure? error,
    RouteInfo? navigateTo,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);

  factory AuthState.initial() =>
      const AuthState(isLoggedIn: false, isLoading: false, error: null, navigateTo: null);

  factory AuthState.loggedOut() =>
      const AuthState(isLoggedIn: false, isLoading: false, error: null, navigateTo: null);

  factory AuthState.loggedIn(User user) =>
      AuthState(isLoggedIn: true, isLoading: false, user: user, error: null, navigateTo: null);
}

// class AuthState extends BaseUiStatus {
//   final bool? isLoggedIn;
//   final User? user;
//   final String? errorMessage;
//
//   const AuthState({
//     this.isLoggedIn,
//     this.user,
//     this.errorMessage,
//     super.isLoading,
//     super.error,
//     super.navigateTo,
//   });
//
//   factory AuthState.initial() =>
//       const AuthState(isLoading: false, isLoggedIn: false);
//
//   factory AuthState.loggedOut() =>
//       AuthState(isLoggedIn: false, isLoading: false);
//
//   factory AuthState.loggedIn(User user) =>
//       AuthState(isLoggedIn: true, user: user, isLoading: false);
//
//   AuthState copyWith({
//     bool? isLoggedIn,
//     User? user,
//     String? errorMessage,
//
//     bool? isLoading,
//     Failure? error,
//     RouteInfo? navigateTo,
//   }) {
//     return AuthState(
//       isLoggedIn: isLoading ?? this.isLoggedIn,
//       user: user ?? this.user,
//       errorMessage: errorMessage ?? this.errorMessage,
//
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//       navigateTo: navigateTo ?? this.navigateTo,
//     );
//   }
// }
