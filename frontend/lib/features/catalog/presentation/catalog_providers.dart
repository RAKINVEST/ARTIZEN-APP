import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/pagination/entity_search_notifier.dart';
import '../../../core/pagination/paged_list.dart';
import '../../../core/pagination/paged_list_notifier.dart';
import '../../../shared/providers/current_company_provider.dart';
import '../data/catalog_models.dart';
import '../data/catalog_repository_impl.dart';

class CategoriesNotifier extends AsyncNotifier<List<CatalogCategory>> {
  @override
  Future<List<CatalogCategory>> build() async {
    final companyId = await ref.watch(currentCompanyIdProvider.future);
    return ref.watch(catalogRepositoryProvider).listCategories(companyId: companyId);
  }

  Future<void> refresh() async {
    // Keep the current categories on screen while refreshing (AsyncListView
    // skips the loading state on a refresh that carries a previous value) —
    // no full-page spinner flash on pull-to-refresh.
    state = const AsyncValue<List<CatalogCategory>>.loading().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      final companyId = await refreshCurrentCompanyId(ref);
      return ref.read(catalogRepositoryProvider).listCategories(companyId: companyId);
    });
  }

  Future<void> createCategory(CatalogCategoryInput input) async {
    final companyId = await ref.read(currentCompanyIdProvider.future);
    await ref.read(catalogRepositoryProvider).createCategory(input, companyId: companyId);
    await refresh();
    // A brand-new folder belongs to no trade yet, so the by-trade view must
    // refresh to show it under "Autres".
    ref.invalidate(catalogByTradeProvider);
  }
}

final categoriesNotifierProvider = AsyncNotifierProvider<CategoriesNotifier, List<CatalogCategory>>(
  CategoriesNotifier.new,
);

/// The catalogue list: server search (`?q=`) + offset/limit paging. It
/// deliberately lists deactivated items too (they render greyed out — see
/// `ItemTile`), so the artisan still sees what they took out of circulation;
/// only the quote-form pickers filter to active items.
class ItemsNotifier extends SearchablePagedListNotifier<CatalogItem> {
  static const bool _activeOnly = false;

  @override
  Future<List<CatalogItem>> fetchQueryPage(
    String companyId, {
    required int offset,
    required int limit,
    required String? query,
  }) {
    return ref.read(catalogRepositoryProvider).listItems(
          companyId: companyId,
          activeOnly: _activeOnly,
          query: query,
          offset: offset,
          limit: limit,
        );
  }

  Future<void> createItem(CatalogItemInput input) async {
    final companyId = await ref.read(currentCompanyIdProvider.future);
    await ref.read(catalogRepositoryProvider).createItem(input, companyId: companyId);
    await reload();
  }

  Future<void> updateItem(String id, CatalogItemInput input) async {
    await ref.read(catalogRepositoryProvider).updateItem(id, input);
    await reload();
  }

  Future<void> deactivateItem(String id) async {
    await ref.read(catalogRepositoryProvider).deactivateItem(id);
    await reload();
  }

  Future<void> reactivateItem(String id) async {
    await ref.read(catalogRepositoryProvider).reactivateItem(id);
    await reload();
  }

  Future<void> setFavorite(String id, {required bool favorite}) async {
    await ref.read(catalogRepositoryProvider).setFavorite(id, favorite: favorite);
    await reload();
    // Keep "Ma caisse à outils" in sync with the star just toggled here.
    ref.invalidate(favoriteItemsProvider);
  }
}

final itemsNotifierProvider = AsyncNotifierProvider<ItemsNotifier, PagedList<CatalogItem>>(
  ItemsNotifier.new,
);

final itemByIdProvider = Provider.family<CatalogItem?, String>((ref, id) {
  final items = ref.watch(itemsNotifierProvider).valueOrNull?.items;
  if (items == null) return null;
  for (final item in items) {
    if (item.id == id) return item;
  }
  return null;
});

/// The articles in the artisan's "caisse à outils" — his starred favourites.
/// A plain list (a toolbox is a curated handful, not a paged catalogue) and
/// autoDispose, so it re-fetches fresh each time the screen opens.
class FavoriteItemsNotifier extends AutoDisposeAsyncNotifier<List<CatalogItem>> {
  Future<List<CatalogItem>> _fetch() async {
    final companyId = await ref.read(currentCompanyIdProvider.future);
    return ref.read(catalogRepositoryProvider).listItems(
          companyId: companyId,
          favoriteOnly: true,
          limit: 200,
        );
  }

  @override
  Future<List<CatalogItem>> build() => _fetch();

  Future<void> refresh() async {
    state = const AsyncValue<List<CatalogItem>>.loading().copyWithPrevious(state);
    state = await AsyncValue.guard(_fetch);
  }

  /// Take an article out of the toolbox from the toolbox screen itself.
  Future<void> removeFromToolbox(String id) async {
    await ref.read(catalogRepositoryProvider).setFavorite(id, favorite: false);
    await refresh();
    // The catalogue's own list must reflect the un-starring too.
    ref.invalidate(itemsNotifierProvider);
  }
}

final favoriteItemsProvider =
    AutoDisposeAsyncNotifierProvider<FavoriteItemsNotifier, List<CatalogItem>>(
  FavoriteItemsNotifier.new,
);

/// The catalogue grouped by the artisan's trades (métiers) — the source of the
/// "Catégories" tab. Kept alive with the tab; refreshes when a folder is added
/// (and it re-fetches on its own after a métier import invalidates it).
class CatalogByTradeNotifier extends AsyncNotifier<List<TradeGroup>> {
  @override
  Future<List<TradeGroup>> build() {
    return ref.watch(catalogRepositoryProvider).listCatalogByTrade();
  }

  Future<void> refresh() async {
    state = const AsyncValue<List<TradeGroup>>.loading().copyWithPrevious(state);
    state = await AsyncValue.guard(
      () => ref.read(catalogRepositoryProvider).listCatalogByTrade(),
    );
  }
}

final catalogByTradeProvider =
    AsyncNotifierProvider<CatalogByTradeNotifier, List<TradeGroup>>(CatalogByTradeNotifier.new);

/// The articles of one folder — the drill-down when the artisan opens a folder
/// from the by-trade view. A real folder is small, so a single bounded page;
/// server-scoped by category.
final categoryItemsProvider =
    FutureProvider.autoDispose.family<List<CatalogItem>, String>((ref, categoryId) async {
  final companyId = await ref.watch(currentCompanyIdProvider.future);
  return ref.watch(catalogRepositoryProvider).listItems(
        companyId: companyId,
        categoryId: categoryId,
        limit: 200,
      );
});

/// Server-searched, active-only item picker used by the quote form and the
/// copilote. Its own `autoDispose` source (not the browsing list above): it
/// must never show deactivated items, and searching inside a picker should
/// not disturb the catalogue screen's own filter.
class CatalogItemSearchNotifier extends EntitySearchNotifier<CatalogItem> {
  @override
  Future<List<CatalogItem>> fetch(String companyId, {required String? query, required int limit}) {
    return ref.read(catalogRepositoryProvider).listItems(
          companyId: companyId,
          activeOnly: true,
          query: query,
          offset: 0,
          limit: limit,
        );
  }
}

final catalogItemSearchProvider =
    AutoDisposeAsyncNotifierProvider<CatalogItemSearchNotifier, List<CatalogItem>>(
  CatalogItemSearchNotifier.new,
);
