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
}

final categoriesNotifierProvider = AsyncNotifierProvider<CategoriesNotifier, List<CatalogCategory>>(
  CategoriesNotifier.new,
);

class ItemsNotifier extends AsyncNotifier<List<CatalogItem>> {
  /// The catalog screen deliberately lists deactivated items too — they
  /// render greyed out and labelled "désactivé" (see `ItemTile`), so the
  /// artisan can still see what they took out of circulation. Only the
  /// quote form filters them out, where offering them would be wrong.
  static const bool _activeOnly = false;

  List<CatalogItem> _all = [];
  String _query = '';

  @override
  Future<List<CatalogItem>> build() async {
    final companyId = await ref.watch(currentCompanyIdProvider.future);
    _all = await ref.watch(catalogRepositoryProvider).listItems(
          companyId: companyId,
          activeOnly: _activeOnly,
        );
    return _filtered();
  }

  List<CatalogItem> _filtered() {
    if (_query.isEmpty) return _all;
    final lowerQuery = _query.toLowerCase();
    return _all.where((item) {
      return item.designation.toLowerCase().contains(lowerQuery) ||
          (item.code?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  /// Client-side only: the backend has no free-text search for catalog
  /// items, and a single artisan's catalog is small enough that filtering
  /// an already-fetched list is simpler than adding a server endpoint for it.
  void search(String query) {
    _query = query;
    state = AsyncValue.data(_filtered());
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final companyId = await refreshCurrentCompanyId(ref);
      _all = await ref.read(catalogRepositoryProvider).listItems(
            companyId: companyId,
            activeOnly: _activeOnly,
          );
      return _filtered();
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

  Future<void> reactivateItem(String id) async {
    await ref.read(catalogRepositoryProvider).reactivateItem(id);
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
