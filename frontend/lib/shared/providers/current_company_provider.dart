import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/dio_client.dart';

/// The backend has no multi-tenant auth yet (see its own README): every
/// business module scopes by an explicit `company_id`, and `branding/`
/// auto-creates a single implicit company on first use
/// (`GET /branding/profile`). This provider fetches that company's id once
/// and caches it, so every feature repository can read the same id instead
/// of each re-implementing this bootstrap call — avoiding the duplication
/// the brief explicitly forbids.
///
/// Once real authentication exists, this is the one place to change: derive
/// `company_id` from the logged-in user instead of "the first company".
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
