import 'package:dio/dio.dart';
import 'package:mini_flutter/data/secure_store.dart';

class ApiClient {
  final Dio dio;
  final SecureStore store;

  ApiClient(this.store)
    : dio = Dio(
        BaseOptions(
          baseUrl: 'http://localhost:9090',
          connectTimeout: const Duration(seconds: 10),
        ),
      ) {
    // intercepta las llamadas HTTP para inyectar el Beaarer token
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final t = await store.readAccess();
          if (t != null) {
            options.headers['Authorization'] = 'Bearer $t';
          }
          handler.next(options);
        },
        // Importante para manejar el refresh del token
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // POST al llamado del refresh
            // Guardar nuevo token
            // Reintentar
          }
          handler.next(error);
        },
      ),
    );
  }
}
