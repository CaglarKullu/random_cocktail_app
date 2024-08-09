import 'user_model.dart';
import 'error_model.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final ErrorModel? error;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  // Factory constructor to represent the initial state
  factory AuthState.initial() {
    return AuthState(user: null, isLoading: false, error: null);
  }

  // Factory constructor to represent the loading state
  factory AuthState.loading() {
    return AuthState(isLoading: true);
  }

  // Factory constructor to represent the authenticated state
  factory AuthState.authenticated(UserModel user) {
    return AuthState(user: user);
  }

  // Factory constructor to represent the unauthenticated state
  factory AuthState.unauthenticated() {
    return AuthState(user: null);
  }

  // Factory constructor to represent the error state
  factory AuthState.error(ErrorModel error) {
    return AuthState(error: error);
  }

  @override
  String toString() {
    return 'AuthState(user: $user, isLoading: $isLoading, error: $error)';
  }
}
