import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_flutter/domain/auth.dart';
import 'package:mini_flutter/state/auth_controller.dart';
import 'package:mini_flutter/ui/home_screen.dart';
import 'package:mini_flutter/ui/live_screen.dart';
import 'package:mini_flutter/ui/login_screen.dart';
import 'package:mini_flutter/ui/products/product_list_screen.dart';
import 'package:mini_flutter/ui/products/product_detail_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  // Bridge between Riverpod and Gorouter: Listenable
  final authListenable = ValueNotifier<AuthState>(
    ref.read(authControllerProvider),
  );
  ref.onDispose(authListenable.dispose);
  ref.listen(authControllerProvider, (_, next) => authListenable.value = next);

  return GoRouter(
    initialLocation: '/home',
    refreshListenable: authListenable,
    // GUARD que correr con cada navegacion y ante un cambio de auth
    redirect: (context, state) {
      final status = ref.read(authControllerProvider).status;
      final inLogin = state.matchedLocation == '/login';

      if (status == AuthStatus.unknown) return null;
      if (status == AuthStatus.unauthenticated) {
        return inLogin ? null : '/login';
      }
      return inLogin ? '/home' : null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
      GoRoute(path: '/live', builder: (_, _) => const LiveScreen()),
      GoRoute(path: '/products', builder: (_, _) => const ProductListScreen()),
      GoRoute(
        path: '/products/:id',
        builder: (_, s) =>
            ProductDetailScreen(id: s.pathParameters['id']!), // próxima parte
      ),
    ],
  );
});
