import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/providers/current_company_provider.dart';
import 'paged_list.dart';

/// Shared machinery for every server-paginated list screen (clients,
/// catalogue, devis): first page on build, "load more" that appends without
/// re-rendering the whole list, and a refresh/reload that keeps the current
/// rows on screen instead of flashing a full-page spinner.
///
/// The keep-the-rows behaviour comes from `copyWithPrevious`: a reload sets
/// an `AsyncLoading` that still carries the previous value, so a
/// `PagedListView` (which passes `skipLoadingOnReload/Refresh`) shows the
/// old rows under a discrete indicator until the new page arrives.
///
/// Subclasses implement [fetchPage] against their repository, and may widen
/// [watchDependencies] to make a filter change re-run `build`.
abstract class PagedListNotifier<T> extends AsyncNotifier<PagedList<T>> {
  /// Well under the backend caps (100 default, 200 for catalogue) and small
  /// enough to feel instant on a phone at a work site.
  @protected
  int get pageSize => 30;

  /// Bumped on every reload so a slower in-flight fetch (an earlier search,
  /// or a "load more" from before a filter changed) can detect it has been
  /// superseded and drop its result instead of overwriting fresher rows.
  int _requestId = 0;

  /// Fetches one page from the concrete repository. [offset] is the number
  /// of rows already held, so paging is always "give me the next slice".
  @protected
  Future<List<T>> fetchPage(String companyId, {required int offset, required int limit});

  /// What `build` depends on. Defaults to the company id; a subclass with
  /// server-side filters (e.g. devis by statut) overrides this to also
  /// `ref.watch` its filter provider, so changing the filter re-runs `build`
  /// and re-fetches from the first page.
  @protected
  Future<String> watchDependencies() => ref.watch(currentCompanyIdProvider.future);

  @override
  Future<PagedList<T>> build() async {
    final companyId = await watchDependencies();
    final page = await fetchPage(companyId, offset: 0, limit: pageSize);
    return PagedList<T>(items: page, hasMore: page.length >= pageSize);
  }

  /// Pull-to-refresh and the "Réessayer" button. Re-bootstraps the company
  /// id first (see [refreshCurrentCompanyId]) so a transient upstream
  /// failure never permanently poisons the list.
  Future<void> refresh() => reload(bootstrap: true);

  /// Re-fetches the first page while keeping the current rows visible.
  /// [bootstrap] re-resolves the company id (refresh/retry); a plain search
  /// or a post-mutation reload leaves it cached, exactly like the pre-V2
  /// `ClientsNotifier.search` did, to avoid racing `build`.
  @protected
  Future<void> reload({bool bootstrap = false}) async {
    final requestId = ++_requestId;
    // AsyncLoading that still carries the previous value: the list stays on
    // screen (under a discrete indicator) until the new page lands.
    state = AsyncValue<PagedList<T>>.loading().copyWithPrevious(state);
    final next = await AsyncValue.guard(() async {
      final companyId =
          bootstrap ? await refreshCurrentCompanyId(ref) : await ref.read(currentCompanyIdProvider.future);
      final page = await fetchPage(companyId, offset: 0, limit: pageSize);
      return PagedList<T>(items: page, hasMore: page.length >= pageSize);
    });
    // A newer reload started while we awaited — let it win.
    if (requestId != _requestId) return;
    state = next;
  }

  /// Appends the next page. A no-op while a reload is in flight, when there
  /// is nothing more, or when a previous "load more" is still running.
  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (state.isLoading || current == null || !current.hasMore || current.isLoadingMore) {
      return;
    }
    final requestId = _requestId;
    state = AsyncValue.data(current.copyWith(isLoadingMore: true));
    try {
      final companyId = await ref.read(currentCompanyIdProvider.future);
      final page = await fetchPage(companyId, offset: current.items.length, limit: pageSize);
      if (requestId != _requestId) return; // a reload replaced the list under us
      state = AsyncValue.data(
        PagedList<T>(items: [...current.items, ...page], hasMore: page.length >= pageSize),
      );
    } catch (_) {
      // A failed "load more" must never blow away the pages already loaded —
      // just stop the footer spinner and keep what is on screen.
      if (requestId != _requestId) return;
      final latest = state.valueOrNull ?? current;
      state = AsyncValue.data(latest.copyWith(isLoadingMore: false));
    }
  }
}

/// A [PagedListNotifier] whose only filter is a free-text query. Clients and
/// catalogue share this; the query is applied server-side (`?q=`), so a row
/// past the first page is still findable — unlike the old client-side filter
/// that only ever saw the first 100 rows.
abstract class SearchablePagedListNotifier<T> extends PagedListNotifier<T> {
  String _query = '';

  /// The active query — seeds the search field so the text and the filtered
  /// list stay in sync after the screen is rebuilt.
  String get searchQuery => _query;

  @override
  Future<List<T>> fetchPage(String companyId, {required int offset, required int limit}) {
    return fetchQueryPage(
      companyId,
      offset: offset,
      limit: limit,
      query: _query.isEmpty ? null : _query,
    );
  }

  @protected
  Future<List<T>> fetchQueryPage(
    String companyId, {
    required int offset,
    required int limit,
    required String? query,
  });

  /// Debounced upstream by the search field, so this runs once per burst.
  Future<void> search(String rawQuery) {
    final trimmed = rawQuery.trim();
    if (trimmed == _query) return Future<void>.value();
    _query = trimmed;
    return reload();
  }
}
