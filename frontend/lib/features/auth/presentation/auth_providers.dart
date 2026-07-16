import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/auth_session.dart';
import '../data/auth_repository.dart';

/// Drives GoRouter's redirect logic (via a `refreshListenable` that observes
/// this provider — see `core/navigation/app_router.dart`).
/// [AuthNotifier.login]/[register]/[logout] update the state directly
/// (instead of just calling the repository) so the redirect sees the change
/// immediately, without waiting for `build()` to re-run.
class AuthNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    // A 401 from any authenticated request bumps this — re-check the
    // stored token (already cleared by then) so a dead session is
    // reflected here too, not just when the app happens to restart.
    ref.watch(authSessionEpochProvider);
    return ref.watch(authRepositoryProvider).isLoggedIn();
  }

  Future<void> register({
    required String email,
    required String password,
    String? fullName,
    String? companyName,
  }) async {
    await ref.read(authRepositoryProvider).register(
          email: email,
          password: password,
          fullName: fullName,
          companyName: companyName,
        );
    state = const AsyncValue.data(true);
  }

  Future<void> login({required String email, required String password}) async {
    await ref.read(authRepositoryProvider).login(email: email, password: password);
    state = const AsyncValue.data(true);
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncValue.data(false);
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, bool>(AuthNotifier.new);
