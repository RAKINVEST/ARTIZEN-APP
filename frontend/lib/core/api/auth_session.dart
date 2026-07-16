import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Bumped whenever `core/api` itself detects that the current session died
/// (a 401 from any authenticated request — see [ErrorInterceptor]).
/// `core/api` must not depend on `features/auth`, so this is how it signals
/// "something auth-related happened" without knowing what `AuthNotifier` or
/// the router do about it.
final authSessionEpochProvider = StateProvider<int>((ref) => 0);
