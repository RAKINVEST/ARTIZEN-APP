import 'package:artizen/features/auth/data/auth_repository.dart';

/// In-memory [AuthRepository] for tests. The real implementation calls the
/// backend over HTTP — no widget or provider test should depend on that.
class FakeAuthRepository implements AuthRepository {
  bool loggedIn = false;
  String? lastLoginEmail;
  String? lastRegisterCompanyName;
  bool shouldFailLogin = false;

  @override
  Future<bool> isLoggedIn() async => loggedIn;

  @override
  Future<void> login({required String email, required String password}) async {
    if (shouldFailLogin) throw Exception('invalid credentials');
    lastLoginEmail = email;
    loggedIn = true;
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    String? fullName,
    String? companyName,
  }) async {
    lastRegisterCompanyName = companyName;
    loggedIn = true;
  }

  @override
  Future<void> logout() async {
    loggedIn = false;
  }
}
