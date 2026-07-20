import 'package:artizen/core/api/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

final _options = RequestOptions(path: '/auth/register');

void main() {
  group('asApiException', () {
    test('passes an ApiException through unchanged', () {
      const original = ApiException.timeout();
      expect(asApiException(original), same(original));
    });

    test('unwraps the ApiException the interceptor hides inside a DioException', () {
      // This is exactly what ErrorInterceptor.onError rejects with. Before the
      // fix, callers tested `error is ApiException` — always false here — and
      // showed a generic message instead of the real one.
      const inner = ApiException.server(
        statusCode: 409,
        code: 'email_already_used',
        message: 'Cet email est déjà utilisé.',
      );
      final rejected = DioException(
        requestOptions: _options,
        type: DioExceptionType.badResponse,
        error: inner,
        message: inner.displayMessage,
      );

      expect(asApiException(rejected), inner);
      expect(asApiException(rejected).displayMessage, 'Cet email est déjà utilisé.');
    });

    test('a network failure keeps its own wording, not a catch-all', () {
      const inner = ApiException.network();
      final rejected = DioException(
        requestOptions: _options,
        type: DioExceptionType.connectionError,
        error: inner,
      );

      expect(
        asApiException(rejected).displayMessage,
        'Impossible de contacter le serveur. Vérifiez votre connexion.',
      );
    });

    test('falls back to the Dio message when nothing was mapped', () {
      final raw = DioException(
        requestOptions: _options,
        type: DioExceptionType.unknown,
        message: 'Boom',
      );
      expect(asApiException(raw).displayMessage, 'Boom');
    });

    test('degrades readably for a non-Dio error', () {
      expect(asApiException(StateError('oups')).displayMessage, contains('oups'));
      expect(asApiException(null).displayMessage, 'Une erreur inattendue est survenue.');
    });
  });
}
