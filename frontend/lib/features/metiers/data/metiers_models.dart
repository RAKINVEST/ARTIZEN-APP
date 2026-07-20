import 'package:freezed_annotation/freezed_annotation.dart';

part 'metiers_models.freezed.dart';
part 'metiers_models.g.dart';

/// Where a trade's catalog stands for this company — modelled like an app
/// store: not installed, installed, or an update is available.
enum CatalogSourceStatus {
  @JsonValue('available')
  available,
  @JsonValue('imported')
  imported,
  @JsonValue('update_available')
  updateAvailable,
}

/// A folder an activity/qualification brings, with how many articles it holds.
@freezed
class CatalogPackSummary with _$CatalogPackSummary {
  const factory CatalogPackSummary({
    required String name,
    required int itemCount,
  }) = _CatalogPackSummary;

  factory CatalogPackSummary.fromJson(Map<String, dynamic> json) =>
      _$CatalogPackSummaryFromJson(json);
}

/// An activity ("Plomberie") or a qualification ("PG") — the backend returns
/// the same shape for both, so one model serves both sections of the screen.
@freezed
class CatalogSource with _$CatalogSource {
  const factory CatalogSource({
    required String slug,
    required String label,
    String? description,
    @Default(<CatalogPackSummary>[]) List<CatalogPackSummary> packs,
    required int itemCount,
    required int productCount,
    required int prestationCount,
    required CatalogSourceStatus status,
    required int version,
    int? importedVersion,
    DateTime? importedAt,
    // Only when status == updateAvailable: how many articles the update adds…
    int? updateItemCount,
    // …and its "Nouveautés" (why to update): "Ajout des PAC R290", etc.
    List<String>? updateNotes,
  }) = _CatalogSource;

  factory CatalogSource.fromJson(Map<String, dynamic> json) =>
      _$CatalogSourceFromJson(json);

  const CatalogSource._();

  int get packCount => packs.length;
}

/// Outcome of an import/update — additive: what was created, what was left
/// untouched because the artisan already had it.
@freezed
class CatalogImportResult with _$CatalogImportResult {
  const factory CatalogImportResult({
    required String slug,
    required String label,
    required int categoriesCreated,
    required int itemsCreated,
    required int itemsSkipped,
  }) = _CatalogImportResult;

  factory CatalogImportResult.fromJson(Map<String, dynamic> json) =>
      _$CatalogImportResultFromJson(json);
}
