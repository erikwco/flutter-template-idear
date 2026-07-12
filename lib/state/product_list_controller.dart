import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_flutter/domain/product.dart';
import 'package:mini_flutter/state/providers.dart';

class ProductListNotifier extends AsyncNotifier<List<Product>> {
  // build() async → el estado inicial es AsyncLoading AUTOMÁTICAMENTE
  // hasta que este Future resuelva. Ahí Riverpod pasa solo a AsyncData/AsyncError.
  @override
  Future<List<Product>> build() => _fetch();

  Future<List<Product>> _fetch() {
    // Dentro de métodos/build usás ref.read (no watch): no querés re-suscribir acá.
    final api = ref.read(productApiProvider);
    return api.list();
  }

  // Reintento / pull-to-refresh.
  Future<void> refresh() async {
    state = const AsyncLoading(); // volvemos a mostrar el skeleton
    // guard corre _fetch y, si tira excepción, la envuelve en AsyncError
    // (en vez de explotar). Es el try/catch idiomático de Riverpod.
    state = await AsyncValue.guard(_fetch);
  }
}

final productListProvider =
    AsyncNotifierProvider<ProductListNotifier, List<Product>>(
      ProductListNotifier.new,
    );
