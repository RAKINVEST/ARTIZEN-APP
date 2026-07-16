import '../data/catalog_models.dart';

/// The contract the presentation layer depends on for both catalog
/// entities (categories and items) — one interface, mirroring
/// `CatalogService` on the backend, which also groups both for the same
/// reason: they're one cohesive resource, not two unrelated concerns.
///
/// No search parameter for items: unlike `/clients`, the backend's
/// `GET /catalog/items` has no free-text query support. Filtering by
/// designation/code happens client-side in `CatalogItemsNotifier` — a
/// display-only filter over an already-small list, not business logic.
abstract class CatalogRepository {
  Future<List<CatalogCategory>> listCategories({required String companyId});
  Future<CatalogCategory> createCategory(
    CatalogCategoryInput input, {
    required String companyId,
  });

  Future<List<CatalogItem>> listItems({required String companyId, bool activeOnly = false});
  Future<CatalogItem> createItem(CatalogItemInput input, {required String companyId});
  Future<CatalogItem> updateItem(String id, CatalogItemInput input);
  Future<CatalogItem> deactivateItem(String id);
}
