import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final companyId = await refreshCurrentCompanyId(ref);
      return ref.read(catalogRepositoryProvider).listCategories(companyId: companyId);
    });
  }

  Future<void> createCategory(CatalogCategoryInput input) async {
    final companyId = await ref.read(currentCompanyIdProvider.future);
    await ref.read(catalogRepositoryProvider).createCategory(input, companyId: companyId);
    await refresh();
  }

  /// Installs a whole trade pack ("Quel est votre métier ?") and reloads both
  /// categories and items, since the pack creates the tree *and* its articles.
  Future<TradeInstallResult> installTrade(String slug) async {
    final result = await ref.read(catalogRepositoryProvider).installTrade(slug);
    await refresh();
    await ref.read(itemsNotifierProvider.notifier).refresh();
    return result;
  }
}

/// The installable trade packs offered at first launch.
final tradesProvider = FutureProvider<List<Trade>>((ref) {
  return ref.watch(catalogRepositoryProvider).listTrades();
});

final categoriesNotifierProvider = AsyncNotifierProvider<CategoriesNotifier, List<CatalogCategory>>(
  CategoriesNotifier.new,
);

class ItemsNotifier extends AsyncNotifier<List<CatalogItem>> {
  List<CatalogItem> _all = [];
  bool _activeOnly = false;

  @override
  Future<List<CatalogItem>> build() async {
    final companyId = await ref.watch(currentCompanyIdProvider.future);
    _all = await ref.watch(catalogRepositoryProvider).listItems(
          companyId: companyId,
          activeOnly: _activeOnly,
        );
    return _all;
  }

  // Free-text search + grouping now live in `CatalogScreen` (it needs the
  // category names to search by category and to group the results), so this
  // notifier just exposes the full fetched list.

  Future<void> setActiveOnly(bool activeOnly) async {
    _activeOnly = activeOnly;
    await refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final companyId = await refreshCurrentCompanyId(ref);
      _all = await ref.read(catalogRepositoryProvider).listItems(
            companyId: companyId,
            activeOnly: _activeOnly,
          );
      return _all;
    });
  }

  Future<void> createItem(CatalogItemInput input) async {
    final companyId = await ref.read(currentCompanyIdProvider.future);
    await ref.read(catalogRepositoryProvider).createItem(input, companyId: companyId);
    await refresh();
  }

  Future<void> updateItem(String id, CatalogItemInput input) async {
    await ref.read(catalogRepositoryProvider).updateItem(id, input);
    await refresh();
  }

  Future<void> deactivateItem(String id) async {
    await ref.read(catalogRepositoryProvider).deactivateItem(id);
    await refresh();
  }
}

final itemsNotifierProvider = AsyncNotifierProvider<ItemsNotifier, List<CatalogItem>>(
  ItemsNotifier.new,
);

final itemByIdProvider = Provider.family<CatalogItem?, String>((ref, id) {
  final items = ref.watch(itemsNotifierProvider).valueOrNull;
  if (items == null) return null;
  for (final item in items) {
    if (item.id == id) return item;
  }
  return null;
});
