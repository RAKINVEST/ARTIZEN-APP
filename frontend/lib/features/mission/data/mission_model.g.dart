// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MissionImpl _$$MissionImplFromJson(Map<String, dynamic> json) =>
    _$MissionImpl(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      customerId: json['customer_id'] as String,
      siteId: json['site_id'] as String?,
      workflowInstanceId: json['workflow_instance_id'] as String?,
      title: json['title'] as String,
      status: json['status'] as String,
      progress: (json['progress'] as num).toInt(),
      isTerminal: json['is_terminal'] as bool,
      attachments: json['attachments'] as List<dynamic>? ?? const <dynamic>[],
      timeline: json['timeline'] as List<dynamic>? ?? const <dynamic>[],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$MissionImplToJson(_$MissionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'customer_id': instance.customerId,
      if (instance.siteId case final value?) 'site_id': value,
      if (instance.workflowInstanceId case final value?)
        'workflow_instance_id': value,
      'title': instance.title,
      'status': instance.status,
      'progress': instance.progress,
      'is_terminal': instance.isTerminal,
      'attachments': instance.attachments,
      'timeline': instance.timeline,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
