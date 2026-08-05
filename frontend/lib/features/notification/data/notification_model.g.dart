// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppNotificationImpl _$$AppNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$AppNotificationImpl(
  id: json['id'] as String,
  companyId: json['company_id'] as String,
  channel: json['channel'] as String,
  recipient: json['recipient'] as String,
  subject: json['subject'] as String? ?? '',
  body: json['body'] as String? ?? '',
  status: json['status'] as String,
  templateKey: json['template_key'] as String? ?? '',
  relatedType: json['related_type'] as String? ?? '',
  relatedId: json['related_id'] as String? ?? '',
  history: json['history'] as List<dynamic>? ?? const <dynamic>[],
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$AppNotificationImplToJson(
  _$AppNotificationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'company_id': instance.companyId,
  'channel': instance.channel,
  'recipient': instance.recipient,
  'subject': instance.subject,
  'body': instance.body,
  'status': instance.status,
  'template_key': instance.templateKey,
  'related_type': instance.relatedType,
  'related_id': instance.relatedId,
  'history': instance.history,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
