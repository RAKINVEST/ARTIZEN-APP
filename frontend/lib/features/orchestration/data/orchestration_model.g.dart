// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orchestration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrchestrationInstanceImpl _$$OrchestrationInstanceImplFromJson(
  Map<String, dynamic> json,
) => _$OrchestrationInstanceImpl(
  id: json['id'] as String,
  companyId: json['company_id'] as String,
  correlationId: json['correlation_id'] as String,
  planKind: json['plan_kind'] as String,
  status: json['status'] as String,
  isTerminal: json['is_terminal'] as bool,
  context:
      json['context'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  plan: json['plan'] as List<dynamic>? ?? const <dynamic>[],
  timeline: json['timeline'] as List<dynamic>? ?? const <dynamic>[],
  results:
      json['results'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$OrchestrationInstanceImplToJson(
  _$OrchestrationInstanceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'company_id': instance.companyId,
  'correlation_id': instance.correlationId,
  'plan_kind': instance.planKind,
  'status': instance.status,
  'is_terminal': instance.isTerminal,
  'context': instance.context,
  'plan': instance.plan,
  'timeline': instance.timeline,
  'results': instance.results,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
