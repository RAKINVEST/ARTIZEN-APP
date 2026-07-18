import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/providers/current_company_provider.dart';

/// A lightweight, single-page server search used by the quote-form and
/// copilote pickers — where the artisan is choosing one row, not browsing
/// the whole list. `autoDispose` so each time a picker opens it starts from
/// a clean, unfiltered page instead of the last search left behind.
///
/// Not paginated on purpose: a picker fetches a generous [limit] and relies
/// on the query to narrow further, which keeps it far simpler than the full
/// [PagedListNotifier] the browsing screens need. A subclass only supplies
/// [fetch] against its repository.
abstract class EntitySearchNotifier<T> extends AutoDisposeAsyncNotifier<List<T>> {
  /// Comfortably under the backend caps; the query reaches anything beyond.
  @protected
  int get limit => 50;

  String _query = '';
  int _requestId = 0;

  @protected
  Future<List<T>> fetch(String companyId, {required String? query, required int limit});

  @override
  Future<List<T>> build() async {
    final companyId = await ref.watch(currentCompanyIdProvider.future);
    return fetch(companyId, query: null, limit: limit);
  }

  /// Debounced upstream by the search field. Keeps the previous rows visible
  /// while the new query resolves (no blank flash mid-typing).
  Future<void> search(String rawQuery) async {
    final trimmed = rawQuery.trim();
    if (trimmed == _query) return;
    _query = trimmed;
    final requestId = ++_requestId;
    state = AsyncValue<List<T>>.loading().copyWithPrevious(state);
    final next = await AsyncValue.guard(() async {
      final companyId = await ref.read(currentCompanyIdProvider.future);
      return fetch(companyId, query: trimmed.isEmpty ? null : trimmed, limit: limit);
    });
    if (requestId != _requestId) return;
    state = next;
  }
}
