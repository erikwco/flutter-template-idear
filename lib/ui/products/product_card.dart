// lib/ui/products/product_card.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_flutter/domain/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/products/${product.id}'), // navega al detalle
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF18181B), // zinc-900
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF27272A)),
        ),
        child: Row(
          children: [
            // ── Nombre + código: texto normal, NO vuela ──
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero #1: el nombre (tag propio)
                  Hero(
                    tag: 'product-nombre-${product.id}',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        product.nombre,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.codigo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF71717A),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // ── El precio es lo ÚNICO que vuela ──
            // El Hero envuelve un solo Text (un "leaf"), no un Column.
            // Por eso ya no puede tirar overflow durante la transición.
            Hero(
              tag: 'product-${product.id}', // ← MISMO tag que en el detalle
              child: Material(
                color: Colors.transparent, // Hero necesita un Material ancestro
                child: Text(
                  product.priceLabel,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 16, // ← chico en la lista
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00E5C8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
