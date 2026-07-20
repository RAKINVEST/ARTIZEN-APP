import '../data/metiers_models.dart';

/// Reads the activities and qualifications on offer, and imports/updates or
/// removes them for the current company. The company is always the JWT's —
/// none of these methods take a company id.
abstract class MetiersRepository {
  Future<List<CatalogSource>> listActivities();
  Future<List<CatalogSource>> listQualifications();

  /// Import *or* update — the same additive server operation. Returns what it
  /// created and what it skipped (already owned).
  Future<CatalogImportResult> importActivity(String slug);
  Future<CatalogImportResult> importQualification(String slug);

  /// Deactivate a source. The catalog itself is left intact server-side.
  Future<void> removeActivity(String slug);
  Future<void> removeQualification(String slug);
}
