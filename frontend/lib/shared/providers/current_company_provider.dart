import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/dio_client.dart';

/// Fetches the authenticated user's company id once and caches it, so
/// every feature repository reads the same id instead of re-implementing
/// this bootstrap call.
///
/// **This round-trip is now redundant, and the id it returns is dead
/// weight.** Since the backend gained real multi-tenant auth, every route
/// overwrites whatever `company_id` the client sends with the one derived
/// from the JWT — so the value threaded through the repositories is never
/// read by the server. The id is also already available for free:
/// `POST /auth/login` returns it in `user.company_id`, which
/// `auth_repository` currently discards.
///
/// It survives because removing it touches all seven feature repositories,
/// which is a V2 change (see docs/AUDIT-V1.md), not because it is needed.
/// Until then it costs one HTTP call per screen before that screen's real
/// request — felt on a phone at a work site.
final currentCompanyIdProvider = FutureProvider<String>((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get<Map<String, dynamic>>('/branding/profile');
  final company = response.data!['company'] as Map<String, dynamic>;
  return company['id'] as String;
});

/// A [FutureProvider]'s failed (or aborted) result stays cached until it is
/// explicitly invalidated — merely invalidating a *downstream* provider
/// (e.g. `dashboardSummaryProvider`) does not re-attempt this one. Every
/// feature's retry/refresh calls this first so a transient failure here
/// never permanently "poisons" the app until a full reload.
Future<String> refreshCurrentCompanyId(Ref ref) {
  ref.invalidate(currentCompanyIdProvider);
  return ref.read(currentCompanyIdProvider.future);
}
