import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Where the JWT will live once real authentication exists. Generic
/// infrastructure (like `StorageProvider` on the backend) rather than
/// "auth feature" logic, so [core/api/dio_client.dart]'s [AuthInterceptor]
/// can depend on it without depending on `features/auth`.
abstract class AuthTokenStorage {
  Future<String?> readToken();
  Future<void> saveToken(String token);
  Future<void> clearToken();
}

class SecureAuthTokenStorage implements AuthTokenStorage {
  SecureAuthTokenStorage(this._storage);

  final FlutterSecureStorage _storage;
  static const _tokenKey = 'artizen_auth_token';

  @override
  Future<String?> readToken() => _storage.read(key: _tokenKey);

  @override
  Future<void> saveToken(String token) => _storage.write(key: _tokenKey, value: token);

  @override
  Future<void> clearToken() => _storage.delete(key: _tokenKey);
}

final authTokenStorageProvider = Provider<AuthTokenStorage>((ref) {
  return SecureAuthTokenStorage(const FlutterSecureStorage());
});
