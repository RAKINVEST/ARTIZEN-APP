import '../data/planning_model.dart';

/// The contract the presentation layer depends on.
abstract class PlanningRepository {
  Future<List<PlanningEntry>> list();
  Future<PlanningEntry> get(String id);
  Future<PlanningEntry> create({
    required DateTime startAt,
    required int durationMinutes,
    String? missionId,
    String artisan,
  });
  Future<PlanningEntry> move(String id, DateTime startAt, {int? durationMinutes});
  Future<PlanningEntry> cancel(String id);
  Future<PlanningEntry> assignAuto(String id, List<String> candidates);
  Future<Availability> availability(DateTime startAt, int durationMinutes, {String artisan});
}
