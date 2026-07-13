import 'package:flutter_test/flutter_test.dart';
import 'package:mini_flutter/features/products/domain/product.dart';

void main() {
  group('Product', () {
    final json = {
      'id': 'p1',
      'codigo': 'A-001',
      'nombre': 'Cemento gris',
      'descripcion': null,
      'tipo': 'bien',
      'price_cents': 12550,
      'unidad': 'saco',
      'activo': true,
      'created_at': '2026-07-12T10:00:00Z',
      'updated_at': '2026-07-12T10:00:00Z',
    };

    test('fromJson mapea el contrato del API de Go', () {
      final p = Product.fromJson(json);
      expect(p.id, 'p1');
      expect(p.tipo, ProductType.bien);
      expect(p.priceCents, 12550);
      expect(p.priceLabel, r'$125.50');
    });
    test('felCode: bien=1, servicio=2 (contrato FEL)', () {
      expect(ProductType.bien.felCode, 1);
      expect(ProductType.servicio.felCode, 2);
    });
    test('toJson no manda campos que son del servidor', () {
      final out = Product.fromJson(json).toJson();
      expect(out.containsKey('id'), isFalse);
      expect(out.containsKey('created_at'), isFalse);
    });
  });
}
