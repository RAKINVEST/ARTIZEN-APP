import 'package:dio/dio.dart';

import 'auth_token_storage.dart';

/// Injects `Authorization: Bearer <token>` on every request once a token
/// exists. No backend route checks it yet (the backend has no auth-gated
/// endpoints either, see its own README), but the plumbing is real and
/// active today — wiring up real login later only means making
/// [AuthTokenStorage.saveToken] receive a genuine JWT instead of the
/// simulated one `features/auth` writes now.
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
