import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    // 6 filas fantasma que "respiran" en loop infinito.
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, _) =>
          Container(
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF27272A,
                  ), // zinc-800: base del placeholder
                  borderRadius: BorderRadius.circular(12),
                ),
              )
              .animate(onPlay: (c) => c.repeat()) // loop
              .shimmer(
                duration: 1200.ms,
                color: const Color(
                  0x3300E5C8,
                ), // cyan Kodear al ~20% de opacidad
              ),
    );
  }
}
