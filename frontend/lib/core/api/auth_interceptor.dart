import 'package:dio/dio.dart';

import 'auth_token_storage.dart';

/// Injects `Authorization: Bearer <token>` on every request once a token
/// exists.
///
/// This header is load-bearing: every business route on the backend
/// requires it (`CurrentUserDep`), and the company a request reads and
/// writes is derived from the token — never from anything the client
/// sends. Without it the call is refused, so this interceptor is the only
/// reason any screen returns data.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStorage);

  final AuthTokenStorage _tokenStorage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenStorage.readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
