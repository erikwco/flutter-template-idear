enum AuthStatus { unknown, authenticated, unauthenticated }

class User {
  final String id;
  final String email;
  const User({required this.id, required this.email});
}

// Tokens emitidos por el server
class Token {
  final String access;
  final String refresh;
  const Token({required this.access, required this.refresh});
}

class AuthState {
  final AuthStatus status;
  final User? user;
  const AuthState(this.status, {this.user});

  const AuthState.unknown() : this(AuthStatus.unknown);
  const AuthState.unauthenticated() : this(AuthStatus.unauthenticated);
  const AuthState.authenticated(User user)
    : this(AuthStatus.authenticated, user: user);
}
