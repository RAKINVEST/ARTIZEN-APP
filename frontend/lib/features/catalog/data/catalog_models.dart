import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_models.freezed.dart';
part 'catalog_models.g.dart';

/// Mirrors the backend's `ItemType` enum (`app/catalog/models.py`) exactly.
enum ItemType {
  @JsonValue('service')
  service,
  @JsonValue('product')
  product,
}

/// Mirrors `CatalogCategoryRead`.
@freezed
class CatalogCategory with _$CatalogCategory {
  const factory CatalogCategory({
    required String id,
    required String companyId,
    required String name,
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CatalogCategory;

  factory CatalogCategory.fromJson(Map<String, dynamic> json) => _$CatalogCategoryFromJson(json);
}

@freezed
class CatalogCategoryInput with _$CatalogCategoryInput {
  const factory CatalogCategoryInput({
    required String name,
    String? description,
  }) = _CatalogCategoryInput;

  factory CatalogCategoryInput.fromJson(Map<String, dynamic> json) =>
      _$CatalogCategoryInputFromJson(json);
}

/// Mirrors `CatalogItemRead`. `unitPriceHt`/`vatRate` stay `String`: the
/// backend sends its `Decimal` fields as decimal strings (e.g. `"45.00"`),
/// and Flutter only ever displays them — never recalculates them (see
/// `core/utils/currency.dart`).
@freezed
class CatalogItem with _$CatalogItem {
  const factory CatalogItem({
    required String id,
    required String companyId,
    required String categoryId,
    String? code,
    required String designation,
    String? description,
    required ItemType itemType,
    required String unit,
    required String unitPriceHt,
    required String vatRate,
    int? estimatedDurationMinutes,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CatalogItem;

  factory CatalogItem.fromJson(Map<String, dynamic> json) => _$CatalogItemFromJson(json);
}

@freezed
/// Nullable fields opt out of build.yaml's `include_if_null: false` for
/// the same reason as [ClientInput] (see `client_model.dart` for the full
/// story): this is a full form snapshot, not a partial update, so a field
/// the artisan clears has to be *sent* as null to actually be cleared.
///
/// `active` is the exception, and deliberately keeps the global behaviour.
class CatalogItemInput with _$CatalogItemInput {
  const factory CatalogItemInput({
    required String categoryId,
    @JsonKey(includeIfNull: true) String? code,
    required String designation,
    @JsonKey(includeIfNull: true) String? description,
    required ItemType itemType,
    required String unit,
    required String unitPriceHt,
    required String vatRate,
    @JsonKey(includeIfNull: true) int? estimatedDurationMinutes,
    // The backend has always accepted `active` on update; the client just
    // never sent it. Deactivating was therefore a one-way door: DELETE sets
    // active=False, and nothing could ever set it back — an item taken out
    // of circulation by a mis-tap was gone for good, even though it stayed
    // visible in the catalog, greyed out.
    //
    // Keeps the omit-when-null behaviour, unlike its neighbours above.
    // CatalogItem.active is NOT NULL, and the backend applies
    // exclude_unset — so sending "active": null from a form that simply
    // doesn't touch it would mean setattr(item, "active", None), an
    // IntegrityError surfacing as a 500 on every ordinary item edit.
    // Absent means "leave it alone"; only the reactivate path sends a
    // real boolean.
    bool? active,
  }) = _CatalogItemInput;

  factory CatalogItemInput.fromJson(Map<String, dynamic> json) => _$CatalogItemInputFromJson(json);
}

/// A folder for the guided assistant's "Dossier" step: its name, article count
/// and a few example designations (`GET /catalog/categories/overview`) — enough
/// to recognise the right folder without opening it.
@freezed
class CategoryOverview with _$CategoryOverview {
  const factory CategoryOverview({
    required String id,
    required String name,
    required int itemCount,
    @Default(<String>[]) List<String> sampleDesignations,
  }) = _CategoryOverview;

  factory CategoryOverview.fromJson(Map<String, dynamic> json) =>
      _$CategoryOverviewFromJson(json);
}
