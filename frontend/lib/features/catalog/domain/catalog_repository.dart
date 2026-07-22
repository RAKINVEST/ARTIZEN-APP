import '../data/catalog_models.dart';

/// The contract the presentation layer depends on for both catalog
/// entities (categories and items) — one interface, mirroring
/// `CatalogService` on the backend, which also groups both for the same
/// reason: they're one cohesive resource, not two unrelated concerns.
///
/// `GET /catalog/items` now supports free-text search server-side (`?q=`)
/// over designation and code, plus offset/limit paging. The old client-side
/// filter only ever saw the first page — a row past it was invisible; the
/// server query makes the whole catalogue reachable.
abstract class CatalogRepository {
  Future<List<CatalogCategory>> listCategories({required String companyId});

  /// The company's folders with article count + sample designations, for the
  /// assistant's "Dossier" picker. Company scoping comes from the JWT.
  Future<List<CategoryOverview>> listCategoryOverviews();

  /// The catalogue grouped by the artisan's trades (métiers), each with the
  /// folders it brings, so it reads as a handful of trades instead of one flat
  /// list of a hundred-plus folders. See `GET /catalog/by-trade`.
  Future<List<TradeGroup>> listCatalogByTrade();
  Future<CatalogCategory> createCategory(
    CatalogCategoryInput input, {
    required String companyId,
  });

  /// [query] filters on designation/code; [offset]/[limit] page the result.
  /// All optional so a plain count call still works unchanged.
  Future<List<CatalogItem>> listItems({
    required String companyId,
    bool activeOnly = false,
    bool favoriteOnly = false,
    String? categoryId,
    String? query,
    int? offset,
    int? limit,
  });
  Future<CatalogItem> createItem(CatalogItemInput input, {required String companyId});
  Future<CatalogItem> updateItem(String id, CatalogItemInput input);
  Future<CatalogItem> deactivateItem(String id);

  /// The way back from [deactivateItem]. Its own method rather than a
  /// flag on [updateItem]: reactivating is a single-field change, and
  /// [CatalogItemInput] demands a whole item (designation, price, VAT...),
  /// which the caller doesn't have and shouldn't have to reconstruct just
  /// to flip a boolean — the same reason [deactivateItem] takes only an id.
  Future<CatalogItem> reactivateItem(String id);

  /// Put the article in "Ma caisse à outils" or take it out. A single-field
  /// change like [reactivateItem], so it takes only the id and the new value —
  /// not a whole [CatalogItemInput].
  Future<CatalogItem> setFavorite(String id, {required bool favorite});
}
