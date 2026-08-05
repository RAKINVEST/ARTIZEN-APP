// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SiteImpl _$$SiteImplFromJson(Map<String, dynamic> json) => _$SiteImpl(
  id: json['id'] as String,
  companyId: json['company_id'] as String,
  customerId: json['customer_id'] as String,
  name: json['name'] as String,
  address: json['address'] as String?,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$SiteImplToJson(_$SiteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'customer_id': instance.customerId,
      'name': instance.name,
      if (instance.address case final value?) 'address': value,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

_$SiteCreateInputImpl _$$SiteCreateInputImplFromJson(
  Map<String, dynamic> json,
) => _$SiteCreateInputImpl(
  customerId: json['customer_id'] as String,
  name: json['name'] as String,
  address: json['address'] as String?,
);

Map<String, dynamic> _$$SiteCreateInputImplToJson(
  _$SiteCreateInputImpl instance,
) => <String, dynamic>{
  'customer_id': instance.customerId,
  'name': instance.name,
  'address': instance.address,
};

_$SiteUpdateInputImpl _$$SiteUpdateInputImplFromJson(
  Map<String, dynamic> json,
) => _$SiteUpdateInputImpl(
  name: json['name'] as String?,
  address: json['address'] as String?,
);

Map<String, dynamic> _$$SiteUpdateInputImplToJson(
  _$SiteUpdateInputImpl instance,
) => <String, dynamic>{'name': instance.name, 'address': instance.address};
