import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';
import '../models/error_model.dart';
import '../repositories/auth_repo_google.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepoGoogle _authRepository;

  AuthViewModel(this._authRepository) : super(AuthState.initial()) {
    final user = _authRepository.getCurrentUser();
    if (user != null) {
      state = AuthState.authenticated(user);
    }
  }

  Future<void> signInWithGoogle() async {
    state = AuthState.loading(); // Set loading state
    try {
      final user = await _authRepository.signIn();
      if (user != null) {
        state = AuthState.authenticated(user); // Set authenticated state
      } else {
        state = AuthState.error(ErrorModel(message: 'Sign in failed.'));
      }
    } catch (e) {
      state = AuthState.error(ErrorModel(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    state = AuthState.loading(); // Set loading state
    try {
      await _authRepository.logout();
      state = AuthState.unauthenticated(); // Set unauthenticated state
    } catch (e) {
      state = AuthState.error(ErrorModel(message: e.toString()));
    }
  }

  AuthState getAuthState() {
    return state;
  }

  Future<void> anonSignIn() async {
    state = AuthState.loading(); // Set loading state
    try {
      final user = await _authRepository.anonSignIn();
      if (user != null) {
        state = AuthState.authenticated(user); // Set authenticated state
      } else {
        state = AuthState.error(ErrorModel(message: 'Sign in failed.'));
      }
    } catch (e) {
      state = AuthState.error(ErrorModel(message: e.toString()));
    }
  }
}

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(AuthRepoGoogle());
});
