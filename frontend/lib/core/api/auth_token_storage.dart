import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Where the real JWT issued by `POST /auth/login` lives. Generic
/// infrastructure (like `StorageProvider` on the backend) rather than
/// "auth feature" logic, so [core/api/dio_client.dart]'s [AuthInterceptor]
/// can depend on it without depending on `features/auth`.
abstract class AuthTokenStorage {
  Future<String?> readToken();
  Future<void> saveToken(String token);
  Future<void> clearToken();
}

/// "Secure" holds on mobile, **not on web**, and the name should not be
/// read as a promise that it does. On Android/iOS the token goes to the
/// Keystore/Keychain. On web — a target this app really ships to, since
/// `flutter run -d web-server` is the documented way to run it —
/// flutter_secure_storage falls back to localStorage, AES-encrypted with
/// a key kept in localStorage next to it. That is obfuscation, not
/// storage: any injected script reads both and replays the token until it
/// expires (ACCESS_TOKEN_EXPIRE_MINUTES, 24h by default).
///
/// Closing this properly means an HttpOnly + SameSite cookie set by the
/// backend (CORS already runs with allow_credentials=True), which is a V2
/// change — see docs/AUDIT-V1.md. Until then, treat a web session as
/// XSS-exposed and keep the token's lifetime short.
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
