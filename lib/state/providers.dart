import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_flutter/data/auth_api.dart';
import 'package:mini_flutter/data/auth_repository.dart';
import 'package:mini_flutter/data/product_api.dart';
import 'package:mini_flutter/data/secure_store.dart';

//
const kBaseUrl = 'http://localhost:9090';

//
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
          options.headers['Authorization'] = 'Bearer $t'; // Bearer ✅
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // TODO: POST /auth/refresh con un Dio "pelado" (sin este interceptor)
          //   para no re-disparar este onError en loop → guardar el par nuevo →
          //   reintentar la request original.
        }
        handler.next(error);
      },
    ),
  );
  // TODO(cert-pinning): al pasar a HTTPS real, pinnear SPKI acá.
  return dio;
});

final secureStoreProvider = Provider<SecureStore>((ref) => SecureStore());
final authClientProvider = Provider<AuthApi>(
  (ref) => AuthApi(ref.watch(dioProvider)),
);
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    api: ref.watch(authClientProvider),
    store: ref.watch(secureStoreProvider),
  ),
);
final productApiProvider = Provider<ProductApi>(
  (ref) => ProductApi(ref.watch(dioProvider)),
);
