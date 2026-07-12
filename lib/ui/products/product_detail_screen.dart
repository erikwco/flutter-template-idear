// lib/ui/products/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_flutter/domain/product.dart';
import 'package:mini_flutter/state/providers.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productoAsync = ref.watch(_productProvider(id));

    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFA1A1AA),
      ),
      body: productoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            'Error: $e',
            style: const TextStyle(color: Color(0xFFA1A1AA)),
          ),
        ),
        data: (p) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Nombre y código: texto normal, ya NO vuelan ──
              Hero(
                tag: 'product-nombre-$id',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    p.nombre,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(p.codigo, style: const TextStyle(color: Color(0xFF71717A))),
              const SizedBox(height: 24),

              // ── El precio: MISMO tag que en la card ──
              // Vuela de la lista (16px) a acá (32px). El Hero interpola
              // el tamaño solo → el número cyan "crece" durante el vuelo.
              Hero(
                tag: 'product-$id', // ← MISMO tag que en ProductCard
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    p.priceLabel,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 32, // ← grande en el detalle
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00E5C8),
                    ),
                  ),
                ),
              ),

              if (p.descripcion != null) ...[
                const SizedBox(height: 16),
                Text(
                  p.descripcion!,
                  style: const TextStyle(color: Color(0xFFA1A1AA)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Un producto por id. `.family` parametriza el provider con el id.
final _productProvider = FutureProvider.family<Product, String>((
  ref,
  id,
) async {
  return ref.read(productApiProvider).get(id);
});
