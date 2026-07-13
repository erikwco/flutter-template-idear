import 'package:flutter_test/flutter_test.dart';
import 'package:mini_flutter/features/auth/domain/auth.dart';

void main() {
  group('AuthState', () {
    test('unknown y unauthenticated no llevan usuario', () {
      expect(const AuthState.unknown().status, AuthStatus.unknown);
      expect(const AuthState.unknown().user, isNull);
      expect(
        const AuthState.unauthenticated().status,
        AuthStatus.unauthenticated,
      );
    });

    test('authenticated lleva el usuario', () {
      const u = User(id: 'u1', email: 'erik@gibbor.app');
      const s = AuthState.authenticated(u);
      expect(s.status, AuthStatus.authenticated);
      expect(s.user?.email, 'erik@gibbor.app');
    });
  });
}
