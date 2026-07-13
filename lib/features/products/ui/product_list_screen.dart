import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:mini_flutter/features/products/state/product_list_controller.dart';
import 'package:mini_flutter/features/products/ui/error_view.dart';
import 'package:mini_flutter/features/products/ui/product_card.dart';
import 'package:mini_flutter/features/products/ui/product_skeleton.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch → esta pantalla se reconstruye sola cuando cambia el estado.
    final productos = ref.watch(
      productListProvider,
    ); // AsyncValue<List<Product>>

    return FScaffold(
      child: SafeArea(
        child: productos.when(
          loading: () => const ProductSkeleton(), // ← shimmer
          error: (e, _) => ErrorView(
            message: 'No pudimos cargar los productos',
            onRetry: () => ref.read(productListProvider.notifier).refresh(),
          ),
          data: (items) => RefreshIndicator(
            onRefresh: () => ref.read(productListProvider.notifier).refresh(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, i) => ProductCard(product: items[i]),
            ),
          ),
        ),
      ),
    );
  }
}
