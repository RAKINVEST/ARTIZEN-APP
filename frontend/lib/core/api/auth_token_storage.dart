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

/// Stores the JWT in the platform's secure storage, falling back to memory
/// when the platform refuses.
///
/// Why the fallback: on the web, `FlutterSecureStorage` encrypts through
/// `window.crypto.subtle`, which browsers only expose in a **secure context**
/// (HTTPS, or `localhost`). Served over plain HTTP on a LAN address — exactly
/// how the app is opened from a phone during testing — `subtle` is `null` and
/// every call throws "Null check operator used on a null value", taking the
/// whole app down at startup. Degrading to an in-memory token keeps the app
/// usable there; the only cost is having to log in again after a reload.
class SecureAuthTokenStorage implements AuthTokenStorage {
  SecureAuthTokenStorage(this._storage);

  final FlutterSecureStorage _storage;
  static const _tokenKey = 'artizen_auth_token';

  String? _memoryToken;
  bool _secureStorageUnavailable = false;

  @override
  Future<String?> readToken() async {
    if (_secureStorageUnavailable) return _memoryToken;
    try {
      return await _storage.read(key: _tokenKey);
    } catch (_) {
      _secureStorageUnavailable = true;
      return _memoryToken;
    }
  }

  @override
  Future<void> saveToken(String token) async {
    _memoryToken = token;
    if (_secureStorageUnavailable) return;
    try {
      await _storage.write(key: _tokenKey, value: token);
    } catch (_) {
      _secureStorageUnavailable = true;
    }
  }

  @override
  Future<void> clearToken() async {
    _memoryToken = null;
    if (_secureStorageUnavailable) return;
    try {
      await _storage.delete(key: _tokenKey);
    } catch (_) {
      _secureStorageUnavailable = true;
    }
  }
}

final authTokenStorageProvider = Provider<AuthTokenStorage>((ref) {
  return SecureAuthTokenStorage(const FlutterSecureStorage());
});
