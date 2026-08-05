// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlanningEntryImpl _$$PlanningEntryImplFromJson(Map<String, dynamic> json) =>
    _$PlanningEntryImpl(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      missionId: json['mission_id'] as String?,
      startAt: DateTime.parse(json['start_at'] as String),
      endAt: DateTime.parse(json['end_at'] as String),
      durationMinutes: (json['duration_minutes'] as num).toInt(),
      artisan: json['artisan'] as String? ?? '',
      team: json['team'] as String? ?? '',
      vehicle: json['vehicle'] as String? ?? '',
      status: json['status'] as String,
      isTerminal: json['is_terminal'] as bool,
      history: json['history'] as List<dynamic>? ?? const <dynamic>[],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$PlanningEntryImplToJson(_$PlanningEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      if (instance.missionId case final value?) 'mission_id': value,
      'start_at': instance.startAt.toIso8601String(),
      'end_at': instance.endAt.toIso8601String(),
      'duration_minutes': instance.durationMinutes,
      'artisan': instance.artisan,
      'team': instance.team,
      'vehicle': instance.vehicle,
      'status': instance.status,
      'is_terminal': instance.isTerminal,
      'history': instance.history,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

_$PlanningConflictImpl _$$PlanningConflictImplFromJson(
  Map<String, dynamic> json,
) => _$PlanningConflictImpl(
  type: json['type'] as String,
  detail: json['detail'] as String,
  entryId: json['entry_id'] as String? ?? '',
);

Map<String, dynamic> _$$PlanningConflictImplToJson(
  _$PlanningConflictImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'detail': instance.detail,
  'entry_id': instance.entryId,
};

_$AvailabilityImpl _$$AvailabilityImplFromJson(Map<String, dynamic> json) =>
    _$AvailabilityImpl(
      available: json['available'] as bool,
      conflicts:
          (json['conflicts'] as List<dynamic>?)
              ?.map((e) => PlanningConflict.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PlanningConflict>[],
    );

Map<String, dynamic> _$$AvailabilityImplToJson(_$AvailabilityImpl instance) =>
    <String, dynamic>{
      'available': instance.available,
      'conflicts': instance.conflicts,
    };
