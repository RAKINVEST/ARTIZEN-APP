import '../data/site_model.dart';

/// The contract the presentation layer depends on. One Dio-backed
/// implementation exists ([SitesRepositoryImpl]); keeping the interface lets
/// providers/tests swap a fake in without touching a screen — same reasoning
/// as the backend's `BaseRepository` and the clients feature.
abstract class SitesRepository {
  /// `GET /sites`, scoped to the caller's company server-side (JWT). Optional
  /// [customerId] filters to one client; archived sites are excluded unless
  /// [includeArchived] is true.
  Future<List<Site>> list({
    String? customerId,
    bool includeArchived,
    int? offset,
    int? limit,
  });
  Future<Site> get(String id);
  Future<Site> create(SiteCreateInput input, {required String companyId});
  Future<Site> update(String id, SiteUpdateInput input);

  /// Archives a site (Active -> Archived). There is deliberately no delete:
  /// a site is business data and is never hard-deleted (Loi 5).
  Future<Site> archive(String id);
}
