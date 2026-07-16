import 'package:dio/dio.dart';

import 'api_exception.dart';

/// Converts every [DioException] into an [ApiException] before it reaches
/// repositories or the UI. This is the single place that understands Dio's
/// error shape — everything downstream only ever sees [ApiException].
class ErrorInterceptor extends Interceptor {
  ErrorInterceptor({this.onUnauthorized});

  /// Called on a 401 from any request *except* `/auth/login` and
  /// `/auth/register` themselves — a 401 there just means "wrong
  /// credentials", not "this session died", so it must not trigger a
  /// forced logout of whatever session (if any) was already active.
  final void Function()? onUnauthorized;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final apiException = _map(err);
    if (apiException is ApiServerException &&
        apiException.statusCode == 401 &&
        !_isAuthEndpoint(err.requestOptions.path)) {
      onUnauthorized?.call();
    }
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: apiException,
        message: apiException.displayMessage,
      ),
    );
  }

  bool _isAuthEndpoint(String path) =>
      path.contains('/auth/login') || path.contains('/auth/register');

  ApiException _map(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException.timeout();
      case DioExceptionType.connectionError:
        return const ApiException.network();
      case DioExceptionType.badResponse:
        return _mapBadResponse(err);
      // `cancel`, `badCertificate`, `unknown`, and any case added to Dio's
      // enum in a future version all fall back here rather than needing
      // this switch updated on every Dio upgrade.
      default:
        return ApiException.unknown(err.message ?? 'Erreur inconnue.');
    }
  }

  ApiException _mapBadResponse(DioException err) {
    final statusCode = err.response?.statusCode ?? 0;
    final data = err.response?.data;
    if (data is Map && data['error'] is Map) {
      final error = Map<String, dynamic>.from(data['error'] as Map);
      return ApiException.server(
        statusCode: statusCode,
        code: error['code'] as String? ?? 'unknown',
        message: error['message'] as String? ?? 'Une erreur est survenue.',
      );
    }
    return ApiException.server(
      statusCode: statusCode,
      code: 'unknown',
      message: 'Une erreur est survenue (code $statusCode).',
    );
  }
}
