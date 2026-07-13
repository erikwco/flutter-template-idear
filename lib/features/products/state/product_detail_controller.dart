import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_flutter/features/products/data/product_api.dart';
import 'package:mini_flutter/features/products/domain/product.dart';

final productProvider = FutureProvider.family<Product, String>((ref, id) {
  return ref.watch(productApiProvider).get(id);
});
