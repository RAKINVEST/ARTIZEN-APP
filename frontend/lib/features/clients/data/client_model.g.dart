// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientImpl _$$ClientImplFromJson(Map<String, dynamic> json) => _$ClientImpl(
  id: json['id'] as String,
  companyId: json['company_id'] as String,
  lastName: json['last_name'] as String,
  firstName: json['first_name'] as String?,
  companyName: json['company_name'] as String?,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  notes: json['notes'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$ClientImplToJson(_$ClientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'last_name': instance.lastName,
      if (instance.firstName case final value?) 'first_name': value,
      if (instance.companyName case final value?) 'company_name': value,
      if (instance.address case final value?) 'address': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.email case final value?) 'email': value,
      if (instance.notes case final value?) 'notes': value,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

_$ClientInputImpl _$$ClientInputImplFromJson(Map<String, dynamic> json) =>
    _$ClientInputImpl(
      lastName: json['last_name'] as String,
      firstName: json['first_name'] as String?,
      companyName: json['company_name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$ClientInputImplToJson(_$ClientInputImpl instance) =>
    <String, dynamic>{
      'last_name': instance.lastName,
      'first_name': instance.firstName,
      'company_name': instance.companyName,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'notes': instance.notes,
    };
