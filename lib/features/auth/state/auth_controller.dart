import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_flutter/features/auth/data/auth_repository.dart';
import 'package:mini_flutter/features/auth/domain/auth.dart';

class AuthController extends Notifier<AuthState> {
  // Instance of the Auth repository
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  AuthState build() {
    // We check if there is a user on the secure storage
    // If there is a user, we restore it
    _restore();
    // We return the current state sets as unknown
    return const AuthState.unknown();
  }

  // Restore the user if there is one session on the secure storage
  Future<void> _restore() async {
    // Calling reporistory to restore the user
    final user = await _repo.restore();
    // We defined the status of the authentication, unauthenticated if there is no user
    // or authenticated if there is a user
    state = user == null
        ? const AuthState.unauthenticated()
        : AuthState.authenticated(user);
  }

  Future<void> login(String email, String password) async {
    final user = await _repo.login(email, password);
    state = AuthState.authenticated(user);
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AuthState.unauthenticated();
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
