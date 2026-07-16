import 'dart:typed_data';

import 'package:artizen/core/api/error_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// Always fails the request with a fixed status/error shape — lets the
/// error flow through Dio's real interceptor pipeline (unlike calling
/// [ErrorInterceptor.onError] directly with a bare [ErrorInterceptorHandler],
/// which isn't wired to a real request and throws internally).
class _ThrowingAdapter implements HttpClientAdapter {
  _ThrowingAdapter(this.statusCode, this.code, this.message);

  final int statusCode;
  final String code;
  final String message;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    throw DioException(
      requestOptions: options,
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions: options,
        statusCode: statusCode,
        data: {
          'error': {'code': code, 'message': message},
        },
      ),
    );
  }
}

Dio _dioThrowing(int statusCode, String code, String message) {
  return Dio()..httpClientAdapter = _ThrowingAdapter(statusCode, code, message);
}

void main() {
  test('calls onUnauthorized for a 401 from a protected endpoint (dead session)', () async {
    var called = false;
    final dio = _dioThrowing(401, 'unauthorized', 'Invalid or expired token.')
      ..interceptors.add(ErrorInterceptor(onUnauthorized: () => called = true));

    await expectLater(dio.get<void>('/clients'), throwsA(isA<DioException>()));

    expect(called, isTrue);
  });

  test('does not call onUnauthorized for a 401 from /auth/login (wrong credentials)', () async {
    var called = false;
    final dio = _dioThrowing(401, 'unauthorized', 'Invalid email or password.')
      ..interceptors.add(ErrorInterceptor(onUnauthorized: () => called = true));

    await expectLater(dio.post<void>('/auth/login'), throwsA(isA<DioException>()));

    expect(called, isFalse);
  });

  test('does not call onUnauthorized for a 401 from /auth/register', () async {
    var called = false;
    final dio = _dioThrowing(401, 'unauthorized', 'Something went wrong.')
      ..interceptors.add(ErrorInterceptor(onUnauthorized: () => called = true));

    await expectLater(dio.post<void>('/auth/register'), throwsA(isA<DioException>()));

    expect(called, isFalse);
  });

  test('does not call onUnauthorized for a non-401 error', () async {
    var called = false;
    final dio = _dioThrowing(404, 'not_found', 'Resource not found.')
      ..interceptors.add(ErrorInterceptor(onUnauthorized: () => called = true));

    await expectLater(dio.get<void>('/clients/xyz'), throwsA(isA<DioException>()));

    expect(called, isFalse);
  });
}
