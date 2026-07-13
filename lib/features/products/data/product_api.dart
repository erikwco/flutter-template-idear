import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_flutter/core/network/dio_provider.dart';
import 'package:mini_flutter/features/products/domain/product.dart';

class ProductApi {
  final Dio _dio;
  ProductApi(this._dio);

  Future<List<Product>> list() async {
    final res = await _dio.get('/products');
    final data = res.data as List<dynamic>;
    return data
        .map((j) => Product.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  Future<Product> get(String id) async {
    final res = await _dio.get('/products/$id');
    return Product.fromJson(res.data as Map<String, dynamic>);
  }
}

final productApiProvider = Provider<ProductApi>(
  (ref) => ProductApi(ref.watch(dioProvider)),
);
