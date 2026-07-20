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
///
/// Categories form a tree: [parentId] is null for a top-level folder (a
/// métier such as "Plombier") and points at the parent otherwise (📂 Tubes
/// under 📁 Plombier). [sortOrder] preserves the authored display order
/// within a parent rather than sorting alphabetically.
@freezed
class CatalogCategory with _$CatalogCategory {
  const factory CatalogCategory({
    required String id,
    required String companyId,
    required String name,
    String? description,
    String? parentId,
    @Default(0) int sortOrder,
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
    String? parentId,
    int? sortOrder,
  }) = _CatalogCategoryInput;

  factory CatalogCategoryInput.fromJson(Map<String, dynamic> json) =>
      _$CatalogCategoryInputFromJson(json);
}

/// Mirrors `TradeSummary`: an installable "pack métier" offered at first
/// launch ("Quel est votre métier ?").
@freezed
class Trade with _$Trade {
  const factory Trade({
    required String slug,
    required String name,
    required String description,
    required int categoryCount,
    required int itemCount,
  }) = _Trade;

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);
}

/// Mirrors `TradeInstallResult`.
@freezed
class TradeInstallResult with _$TradeInstallResult {
  const factory TradeInstallResult({
    required String slug,
    required int categoriesCreated,
    required int itemsCreated,
  }) = _TradeInstallResult;

  factory TradeInstallResult.fromJson(Map<String, dynamic> json) =>
      _$TradeInstallResultFromJson(json);
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
class CatalogItemInput with _$CatalogItemInput {
  const factory CatalogItemInput({
    required String categoryId,
    String? code,
    required String designation,
    String? description,
    required ItemType itemType,
    required String unit,
    required String unitPriceHt,
    required String vatRate,
    int? estimatedDurationMinutes,
  }) = _CatalogItemInput;

  factory CatalogItemInput.fromJson(Map<String, dynamic> json) => _$CatalogItemInputFromJson(json);
}
