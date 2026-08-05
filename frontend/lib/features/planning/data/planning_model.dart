import 'package:freezed_annotation/freezed_annotation.dart';

part 'planning_model.freezed.dart';
part 'planning_model.g.dart';

/// Mirrors the backend's `PlanningRead` (`app/planning/schemas.py`). The
/// Planning Engine owns the schedule; this is the read projection with the
/// computed end time and terminal flag, its assignment and append-only history.
@freezed
class PlanningEntry with _$PlanningEntry {
  const factory PlanningEntry({
    required String id,
    required String companyId,
    String? missionId,
    required DateTime startAt,
    required DateTime endAt,
    required int durationMinutes,
    @Default('') String artisan,
    @Default('') String team,
    @Default('') String vehicle,
    required String status,
    required bool isTerminal,
    @Default(<dynamic>[]) List<dynamic> history,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PlanningEntry;

  factory PlanningEntry.fromJson(Map<String, dynamic> json) =>
      _$PlanningEntryFromJson(json);
}

/// Result of an availability/conflict check.
@freezed
class PlanningConflict with _$PlanningConflict {
  const factory PlanningConflict({
    required String type,
    required String detail,
    @Default('') String entryId,
  }) = _PlanningConflict;

  factory PlanningConflict.fromJson(Map<String, dynamic> json) =>
      _$PlanningConflictFromJson(json);
}

@freezed
class Availability with _$Availability {
  const factory Availability({
    required bool available,
    @Default(<PlanningConflict>[]) List<PlanningConflict> conflicts,
  }) = _Availability;

  factory Availability.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);
}
