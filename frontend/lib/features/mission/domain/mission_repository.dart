import '../data/mission_model.dart';

/// The contract the presentation layer depends on.
abstract class MissionRepository {
  Future<List<Mission>> list();
  Future<Mission> create({required String customerId, String? siteId, required String title});
  Future<Mission> get(String id);

  /// Lifecycle transition (ouvrir/clôturer…). May fail 409 if not allowed.
  Future<Mission> changeStatus(String id, String status);

  Future<Mission> addAttachment(
    String id, {
    required String kind,
    String label,
    String reference,
    String text,
  });
}
