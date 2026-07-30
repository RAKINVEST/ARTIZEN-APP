import 'package:artizen/features/auth/data/auth_repository.dart';

/// In-memory [AuthRepository] for tests. The real implementation calls the
/// backend over HTTP — no widget or provider test should depend on that.
class FakeAuthRepository implements AuthRepository {
  bool loggedIn = false;
  String? lastLoginEmail;
  String? lastRegisterCompanyName;
  bool shouldFailLogin = false;

  /// Records the last password-reset interactions so tests can assert them.
  String? lastForgotPasswordEmail;
  String? lastResetToken;
  String? lastResetPassword;

  /// When set, [resetPassword] throws it — lets a test simulate a 400 (expired
  /// or invalid token) without a real HTTP layer.
  Object? resetPasswordError;

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
  Future<void> requestPasswordReset(String email) async {
    lastForgotPasswordEmail = email;
  }

  @override
  Future<void> resetPassword({required String token, required String password}) async {
    if (resetPasswordError != null) throw resetPasswordError!;
    lastResetToken = token;
    lastResetPassword = password;
  }

  bool deleteAccountCalled = false;

  @override
  Future<void> deleteAccount() async {
    deleteAccountCalled = true;
    loggedIn = false;
  }

  @override
  Future<void> logout() async {
    loggedIn = false;
  }
}
