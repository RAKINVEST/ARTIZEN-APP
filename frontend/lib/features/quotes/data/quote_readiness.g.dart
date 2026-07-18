// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_readiness.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReadinessIssueImpl _$$ReadinessIssueImplFromJson(Map<String, dynamic> json) =>
    _$ReadinessIssueImpl(
      code: json['code'] as String,
      label: json['label'] as String,
      target: $enumDecode(
        _$ReadinessTargetEnumMap,
        json['target'],
        unknownValue: ReadinessTarget.unknown,
      ),
      field: json['field'] as String?,
    );

Map<String, dynamic> _$$ReadinessIssueImplToJson(
  _$ReadinessIssueImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'label': instance.label,
  'target': _$ReadinessTargetEnumMap[instance.target]!,
  if (instance.field case final value?) 'field': value,
};

const _$ReadinessTargetEnumMap = {
  ReadinessTarget.companyProfile: 'company_profile',
  ReadinessTarget.client: 'client',
  ReadinessTarget.quote: 'quote',
  ReadinessTarget.unknown: 'unknown',
};

_$QuoteReadinessImpl _$$QuoteReadinessImplFromJson(Map<String, dynamic> json) =>
    _$QuoteReadinessImpl(
      ready: json['ready'] as bool,
      issues:
          (json['issues'] as List<dynamic>?)
              ?.map((e) => ReadinessIssue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ReadinessIssue>[],
    );

Map<String, dynamic> _$$QuoteReadinessImplToJson(
  _$QuoteReadinessImpl instance,
) => <String, dynamic>{'ready': instance.ready, 'issues': instance.issues};
