import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_flutter/state/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider); // reactivo
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (protegida)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Hola, ${auth.user?.email ?? ''}'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go('/live'),
              child: const Text('Ver demo de Stream'),
            ),
            FilledButton(
              onPressed: () => context.go('/products'),
              child: const Text('Ver listado de productos'),
            ),
          ],
        ),
      ),
    );
  }
}
