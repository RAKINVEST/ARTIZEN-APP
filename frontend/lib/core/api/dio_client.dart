import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_config.dart';
import 'auth_interceptor.dart';
import 'auth_session.dart';
import 'auth_token_storage.dart';
import 'error_interceptor.dart';

/// The single [Dio] instance every repository uses. Interceptor order
/// matters: auth header first (so it's present when the logger prints the
/// request), logging second (dev only), error mapping last (so it sees the
/// final response/error shape).
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      sendTimeout: ApiConfig.sendTimeout,
      headers: const {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(AuthInterceptor(ref.watch(authTokenStorageProvider)));

  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: true,
      ),
    );
  }

  dio.interceptors.add(
    ErrorInterceptor(
      onUnauthorized: () {
        ref.read(authTokenStorageProvider).clearToken();
        ref.read(authSessionEpochProvider.notifier).state++;
      },
    ),
  );

  return dio;
});
