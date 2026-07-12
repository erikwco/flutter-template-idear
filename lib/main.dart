// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'router.dart';
import 'theme.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final theme = kodearTheme();

    return MaterialApp.router(
      title: 'Mini Flutter',
      // Material sigue de fondo (infra: navegación, overlays) pero pintado con
      // una aproximación de tu theme de forui, para que no choque visualmente.
      theme: theme.toApproximateMaterialTheme(),
      // forui trae sus propias localizaciones (labels de sus widgets).
      supportedLocales: FLocalizations.supportedLocales,
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      routerConfig: router,
      // Acá inyectamos forui POR ENCIMA de toda la app (una sola vez).
      builder: (_, child) => FTheme(
        data: theme,
        child: FToaster(child: FTooltipGroup(child: child!)),
      ),
    );
  }
}
