import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/current_company_provider.dart';
import '../data/client_model.dart';
import '../data/clients_repository_impl.dart';

/// Holds the current client list plus the active search term. All CRUD
/// operations funnel through here so every screen sees a consistent list
/// without each re-fetching independently.
class ClientsNotifier extends AsyncNotifier<List<Client>> {
  String _query = '';

  @override
  Future<List<Client>> build() async {
    final companyId = await ref.watch(currentCompanyIdProvider.future);
    return ref.watch(clientsRepositoryProvider).list(
          companyId: companyId,
          query: _query.isEmpty ? null : _query,
        );
  }

  /// Deliberately does NOT go through `refresh()`/`refreshCurrentCompanyId`:
  /// invalidating `currentCompanyIdProvider` triggers Riverpod to re-run
  /// this notifier's own `build()` (which watches it) concurrently with
  /// this method's own state update, racing over which write wins — a
  /// plain search never needs to re-bootstrap the company id anyway, only
  /// recovering from a genuinely failed/cached-broken upstream does (see
  /// `refresh()`, used by pull-to-refresh and the "Réessayer" button).
  Future<void> search(String query) async {
    _query = query;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final companyId = await ref.read(currentCompanyIdProvider.future);
      return ref.read(clientsRepositoryProvider).list(
            companyId: companyId,
            query: _query.isEmpty ? null : _query,
          );
    });
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final companyId = await refreshCurrentCompanyId(ref);
      return ref.read(clientsRepositoryProvider).list(
            companyId: companyId,
            query: _query.isEmpty ? null : _query,
          );
    });
  }

  Future<void> createClient(ClientInput input) async {
    final companyId = await ref.read(currentCompanyIdProvider.future);
    await ref.read(clientsRepositoryProvider).create(input, companyId: companyId);
    await refresh();
  }

  Future<void> updateClient(String id, ClientInput input) async {
    await ref.read(clientsRepositoryProvider).update(id, input);
    await refresh();
  }

  Future<void> deleteClient(String id) async {
    await ref.read(clientsRepositoryProvider).delete(id);
    await refresh();
  }
}

final clientsNotifierProvider = AsyncNotifierProvider<ClientsNotifier, List<Client>>(
  ClientsNotifier.new,
);

/// A single client, fetched fresh — used to pre-fill the edit form.
final clientByIdProvider = FutureProvider.family<Client, String>((ref, id) {
  return ref.watch(clientsRepositoryProvider).get(id);
});
