import 'package:mini_flutter/data/auth_api.dart';
import 'package:mini_flutter/data/secure_store.dart';
import 'package:mini_flutter/domain/auth.dart';

class AuthRepository {
  final SecureStore store;
  AuthRepository(this.store);

  Future<User> login(String email, String password) async {
    /*  demo */
    final res = await ApiClient(
      store,
    ).dio.post('/auth/login', data: {'email': email, 'password': password});
    final t = Token(access: res.data['access'], refresh: res.data['refresh']);
    await store.saveTokens(t.access, t.refresh);
    return User(id: res.data['id'], email: email);
    // await Future.delayed(const Duration(milliseconds: 700));
    // if (email == 'erik@gibbor.app' && password == '1234') {
    //   await store.saveTokens('fake-access', 'fake-refresh');
    //   return const User(id: 'fake-id', email: 'erik@gibbor.com');
    // }
    // throw Exception('Invalid credentials');
  }

  Future<User?> restore() async {
    final t = await store.readAccess();
    if (t == null) return null;
    // REAL = valida el token contra /auth/me
    return User(id: 'fake-id', email: 'erik@gibbor.com');
  }

  Future<void> logout() => store.clear();
}
