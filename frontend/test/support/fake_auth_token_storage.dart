import 'package:artizen/core/api/auth_token_storage.dart';

/// In-memory [AuthTokenStorage] for tests. The real implementation wraps
/// `flutter_secure_storage`, which needs platform channels not available
/// under `flutter test` — this is exactly the kind of substitution the
/// [AuthTokenStorage] interface exists to make trivial.
class FakeAuthTokenStorage implements AuthTokenStorage {
  String? _token;

  @override
  Future<String?> readToken() async => _token;

  @override
  Future<void> saveToken(String token) async => _token = token;

  @override
  Future<void> clearToken() async => _token = null;
}
