import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/current_company_provider.dart';
import '../data/site_model.dart';
import '../data/sites_repository_impl.dart';

/// Server-state for the sites list. Sites have no free-text search (unlike
/// clients); the list is filtered by an optional [customerId] and an
/// [includeArchived] toggle. Every CRUD op funnels through here so screens
/// share one consistent view (CLAUDE.md: server state in an AsyncNotifier).
class SitesNotifier extends AsyncNotifier<List<Site>> {
  String? _customerId;
  bool _includeArchived = false;

  @override
  Future<List<Site>> build() => _fetch();

  Future<List<Site>> _fetch() {
    return ref.read(sitesRepositoryProvider).list(
          customerId: _customerId,
          includeArchived: _includeArchived,
        );
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }

  /// Filters the list to one client (null = all clients of the company).
  Future<void> filterByCustomer(String? customerId) async {
    _customerId = customerId;
    await reload();
  }

  Future<void> setIncludeArchived(bool value) async {
    _includeArchived = value;
    await reload();
  }

  /// Returns the created site so callers can act on it. The backend assigns
  /// the id and stamps company_id from the JWT.
  Future<Site> createSite(SiteCreateInput input) async {
    final companyId = await ref.read(currentCompanyIdProvider.future);
    final created =
        await ref.read(sitesRepositoryProvider).create(input, companyId: companyId);
    await reload();
    return created;
  }

  Future<void> updateSite(String id, SiteUpdateInput input) async {
    await ref.read(sitesRepositoryProvider).update(id, input);
    await reload();
  }

  Future<void> archiveSite(String id) async {
    await ref.read(sitesRepositoryProvider).archive(id);
    await reload();
  }
}

final sitesNotifierProvider =
    AsyncNotifierProvider<SitesNotifier, List<Site>>(SitesNotifier.new);

/// A single site, fetched fresh — used to pre-fill the edit form.
final siteByIdProvider = FutureProvider.family<Site, String>((ref, id) {
  return ref.watch(sitesRepositoryProvider).get(id);
});
