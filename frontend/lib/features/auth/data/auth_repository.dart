import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/auth_token_storage.dart';
import '../../../core/api/dio_client.dart';

/// Real JWT auth against the backend's `users/` module (Étape 10):
/// `POST /auth/register` and `POST /auth/login` both return a `TokenRead`
/// (`access_token`, `token_type`, `user`) — only `access_token` is persisted
/// here, since [AuthInterceptor] only ever needs the raw token string.
class AuthRepository {
  AuthRepository(this._dio, this._tokenStorage);

  final Dio _dio;
  final AuthTokenStorage _tokenStorage;

  Future<bool> isLoggedIn() async {
    final token = await _tokenStorage.readToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> register({
    required String email,
    required String password,
    String? fullName,
    String? companyName,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        if (fullName != null && fullName.trim().isNotEmpty) 'full_name': fullName.trim(),
        if (companyName != null && companyName.trim().isNotEmpty) 'company_name': companyName.trim(),
      },
    );
    await _tokenStorage.saveToken(response.data!['access_token'] as String);
  }

  Future<void> login({required String email, required String password}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    await _tokenStorage.saveToken(response.data!['access_token'] as String);
  }

  Future<void> logout() => _tokenStorage.clearToken();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(dioProvider), ref.watch(authTokenStorageProvider));
});
