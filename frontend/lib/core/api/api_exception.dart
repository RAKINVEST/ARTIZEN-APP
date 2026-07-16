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
