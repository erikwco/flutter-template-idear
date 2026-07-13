import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_flutter/features/live/state/clock.dart';

class LiveScreen extends ConsumerWidget {
  const LiveScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clock = ref.watch(clockProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream en vivo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.go('/home'),
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: clock.when(
              data: (t) => Text(
                '${t.hour}:${t.minute}:${t.second}',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              error: (e, _) => Text('Error: $e'),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            child: const Text('Home'),
          ),
        ],
      ),
    );
  }
}
