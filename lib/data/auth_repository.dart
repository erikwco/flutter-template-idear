import 'package:mini_flutter/data/auth_api.dart';
import 'package:mini_flutter/data/secure_store.dart';
import 'package:mini_flutter/domain/auth.dart';

class AuthRepository {
  final AuthApi api;
  final SecureStore store;
  AuthRepository({required this.api, required this.store});

  Future<User> login(String email, String password) async {
    final r = await api.login(email, password);
    await store.saveTokens(r.token.access, r.token.refresh);
    return r.user;
  }

  Future<User?> restore() async {
    final t = await store.readAccess();
    if (t == null) return null;
    try {
      return await api.me();
    } catch (_) {
      return null;
    }
  }

  Future<void> logout() => store.clear();
}
