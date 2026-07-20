import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_exception.freezed.dart';

/// Normalized network/API error, produced by [ErrorInterceptor] from a raw
/// [DioException] so every screen handles exactly one error shape instead of
/// guessing at Dio's internals.
///
/// [ApiException.server] mirrors the backend's own error envelope
/// (`{"error": {"code": ..., "message": ...}}`, see `core/exceptions.py` on
/// the backend) — `code` is the stable machine-readable identifier
/// (`"not_found"`, `"inactive_catalog_item"`, ...) a screen can branch on;
/// `message` is the human-readable text safe to show directly.
@freezed
class ApiException with _$ApiException implements Exception {
  const factory ApiException.network() = ApiNetworkException;
  const factory ApiException.timeout() = ApiTimeoutException;
  const factory ApiException.server({
    required int statusCode,
    required String code,
    required String message,
  }) = ApiServerException;
  const factory ApiException.unknown(String message) = ApiUnknownException;

  const ApiException._();

  /// A single human-readable sentence, suitable for direct display in an
  /// error state widget.
  String get displayMessage => when(
        network: () => 'Impossible de contacter le serveur. Vérifiez votre connexion.',
        timeout: () => 'Le serveur met trop de temps à répondre. Réessayez.',
        server: (statusCode, code, message) => message,
        unknown: (message) => message,
      );
}

/// Normalizes anything thrown by the API layer into an [ApiException].
///
/// Dio only lets an interceptor reject with a [DioException], so
/// [ErrorInterceptor] carries the mapped [ApiException] in that exception's
/// `error` field. Callers therefore receive a `DioException`, and a naive
/// `error is ApiException` check is **always false** — which silently
/// replaced every real message ("email déjà utilisé", "mot de passe trop
/// court", …) with a generic fallback. Unwrapping here keeps Dio's shape out
/// of the screens, which is what the interceptor intended all along.
ApiException asApiException(Object? error) {
  if (error is ApiException) return error;
  if (error is DioException) {
    final inner = error.error;
    if (inner is ApiException) return inner;
    return ApiException.unknown(error.message ?? 'Une erreur inattendue est survenue.');
  }
  return ApiException.unknown(
    error?.toString() ?? 'Une erreur inattendue est survenue.',
  );
}
