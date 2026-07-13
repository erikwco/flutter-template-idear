import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_flutter/core/storage/secure_store.dart';

const kBaseUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://localhost:9090',
);
final dioProvider = Provider<Dio>((ref) {
  final store = ref.watch(secureStoreProvider);
  final dio = Dio(
    BaseOptions(baseUrl: kBaseUrl, connectTimeout: const Duration(seconds: 10)),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final t = await store.readAccess();
        if (t != null) {
          options.headers['Authorization'] = 'Bearer $t';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          //   POST /auth/refresh con un Dio "pelado" (sin este interceptor)
          //   para no re-disparar este onError en loop → guardar el par nuevo →
          //   reintentar la request original.
        }
        handler.next(error);
      },
    ),
  );
  // (cert-pinning): al pasar a HTTPS real, pinnear SPKI acá.
  return dio;
});
