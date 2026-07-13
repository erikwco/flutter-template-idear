import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_flutter/core/network/dio_provider.dart';
import 'package:mini_flutter/features/auth/domain/auth.dart';

class AuthApi {
  final Dio _dio;
  AuthApi(this._dio);

  /// POST /auth/login → { id, email, access, refresh }
  /// El server manda user y tokens juntos → devolvemos ambos con un record.
  Future<({User user, Token token})> login(
    String email,
    String password,
  ) async {
    final res = await _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    final d = res.data as Map<String, dynamic>;
    return (
      user: User(id: d['id'] as String, email: d['email'] as String),
      token: Token(
        access: d['access'] as String,
        refresh: d['refresh'] as String,
      ),
    );
  }

  /// GET /auth/me → { id, email }  (el interceptor inyecta el Bearer)
  Future<User> me() async {
    final res = await _dio.get('/auth/me');
    final d = res.data as Map<String, dynamic>;
    return User(id: d['id'] as String, email: d['email'] as String);
  }

  /// POST /auth/refresh { refresh } → { access, refresh }
  Future<Token> refresh(String refreshToken) async {
    final res = await _dio.post(
      '/auth/refresh',
      data: {'refresh': refreshToken},
    );
    final d = res.data as Map<String, dynamic>;
    return Token(
      access: d['access'] as String,
      refresh: d['refresh'] as String,
    );
  }
}

final authApiProvider = Provider<AuthApi>(
  (ref) => AuthApi(ref.watch(dioProvider)),
);
