import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/pagination/entity_search_notifier.dart';
import '../../../core/pagination/paged_list.dart';
import '../../../core/pagination/paged_list_notifier.dart';
import '../../../shared/providers/current_company_provider.dart';
import '../data/client_model.dart';
import '../data/clients_repository_impl.dart';

/// The clients list: server search (`?q=`) + offset/limit paging, with every
/// CRUD operation funnelling through here so screens share one consistent,
/// paged view. Search and "load more" keep the current rows on screen (see
/// [SearchablePagedListNotifier]) — no flicker on each keystroke.
class ClientsNotifier extends SearchablePagedListNotifier<Client> {
  @override
  Future<List<Client>> fetchQueryPage(
    String companyId, {
    required int offset,
    required int limit,
    required String? query,
  }) {
    return ref.read(clientsRepositoryProvider).list(
          companyId: companyId,
          query: query,
          offset: offset,
          limit: limit,
        );
  }

  /// Returns the created client so callers can act on it (e.g. the quote
  /// wizard auto-selects a just-created client). The backend assigns the id;
  /// Flutter only carries the row back.
  Future<Client> createClient(ClientInput input) async {
    final companyId = await ref.read(currentCompanyIdProvider.future);
    final created = await ref.read(clientsRepositoryProvider).create(input, companyId: companyId);
    await reload();
    return created;
  }

  Future<void> updateClient(String id, ClientInput input) async {
    await ref.read(clientsRepositoryProvider).update(id, input);
    await reload();
  }

  Future<void> deleteClient(String id) async {
    await ref.read(clientsRepositoryProvider).delete(id);
    await reload();
  }
}

final clientsNotifierProvider = AsyncNotifierProvider<ClientsNotifier, PagedList<Client>>(
  ClientsNotifier.new,
);

/// A single client, fetched fresh — used to pre-fill the edit form.
final clientByIdProvider = FutureProvider.family<Client, String>((ref, id) {
  return ref.watch(clientsRepositoryProvider).get(id);
});

/// Server-searched client picker used by the quote form — its own
/// `autoDispose` source so searching inside the picker never disturbs the
/// main clients list's own filter.
class ClientSearchNotifier extends EntitySearchNotifier<Client> {
  @override
  Future<List<Client>> fetch(String companyId, {required String? query, required int limit}) {
    return ref.read(clientsRepositoryProvider).list(
          companyId: companyId,
          query: query,
          offset: 0,
          limit: limit,
        );
  }
}

final clientSearchProvider =
    AutoDisposeAsyncNotifierProvider<ClientSearchNotifier, List<Client>>(
  ClientSearchNotifier.new,
);
