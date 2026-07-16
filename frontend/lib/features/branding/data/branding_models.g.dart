// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branding_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyImpl _$$CompanyImplFromJson(Map<String, dynamic> json) =>
    _$CompanyImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      legalName: json['legal_name'] as String?,
      siret: json['siret'] as String?,
      vatNumber: json['vat_number'] as String?,
      addressLine: json['address_line'] as String?,
      postalCode: json['postal_code'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$$CompanyImplToJson(_$CompanyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.name case final value?) 'name': value,
      if (instance.legalName case final value?) 'legal_name': value,
      if (instance.siret case final value?) 'siret': value,
      if (instance.vatNumber case final value?) 'vat_number': value,
      if (instance.addressLine case final value?) 'address_line': value,
      if (instance.postalCode case final value?) 'postal_code': value,
      if (instance.city case final value?) 'city': value,
      if (instance.country case final value?) 'country': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.email case final value?) 'email': value,
      if (instance.website case final value?) 'website': value,
    };

_$BrandProfileImpl _$$BrandProfileImplFromJson(Map<String, dynamic> json) =>
    _$BrandProfileImpl(
      id: json['id'] as String,
      logoPath: json['logo_path'] as String?,
      primaryColor: json['primary_color'] as String?,
      secondaryColor: json['secondary_color'] as String?,
      fontFamily: json['font_family'] as String?,
      tagline: json['tagline'] as String?,
      signaturePath: json['signature_path'] as String?,
      stampPath: json['stamp_path'] as String?,
    );

Map<String, dynamic> _$$BrandProfileImplToJson(_$BrandProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.logoPath case final value?) 'logo_path': value,
      if (instance.primaryColor case final value?) 'primary_color': value,
      if (instance.secondaryColor case final value?) 'secondary_color': value,
      if (instance.fontFamily case final value?) 'font_family': value,
      if (instance.tagline case final value?) 'tagline': value,
      if (instance.signaturePath case final value?) 'signature_path': value,
      if (instance.stampPath case final value?) 'stamp_path': value,
    };

_$DocumentTemplateImpl _$$DocumentTemplateImplFromJson(
  Map<String, dynamic> json,
) => _$DocumentTemplateImpl(
  id: json['id'] as String,
  type: $enumDecode(_$TemplateTypeEnumMap, json['type']),
  name: json['name'] as String,
  version: (json['version'] as num).toInt(),
  isActive: json['is_active'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  sourceFilePath: json['source_file_path'] as String,
);

Map<String, dynamic> _$$DocumentTemplateImplToJson(
  _$DocumentTemplateImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$TemplateTypeEnumMap[instance.type]!,
  'name': instance.name,
  'version': instance.version,
  'is_active': instance.isActive,
  'created_at': instance.createdAt.toIso8601String(),
  'source_file_path': instance.sourceFilePath,
};

const _$TemplateTypeEnumMap = {
  TemplateType.quote: 'quote',
  TemplateType.invoice: 'invoice',
};

_$BrandingProfileImpl _$$BrandingProfileImplFromJson(
  Map<String, dynamic> json,
) => _$BrandingProfileImpl(
  company: Company.fromJson(json['company'] as Map<String, dynamic>),
  brand: BrandProfile.fromJson(json['brand'] as Map<String, dynamic>),
  templates: (json['templates'] as List<dynamic>)
      .map((e) => DocumentTemplate.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$BrandingProfileImplToJson(
  _$BrandingProfileImpl instance,
) => <String, dynamic>{
  'company': instance.company,
  'brand': instance.brand,
  'templates': instance.templates,
};

_$CompanyUpdateInputImpl _$$CompanyUpdateInputImplFromJson(
  Map<String, dynamic> json,
) => _$CompanyUpdateInputImpl(
  name: json['name'] as String?,
  legalName: json['legal_name'] as String?,
  siret: json['siret'] as String?,
  vatNumber: json['vat_number'] as String?,
  addressLine: json['address_line'] as String?,
  postalCode: json['postal_code'] as String?,
  city: json['city'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  website: json['website'] as String?,
);

Map<String, dynamic> _$$CompanyUpdateInputImplToJson(
  _$CompanyUpdateInputImpl instance,
) => <String, dynamic>{
  if (instance.name case final value?) 'name': value,
  if (instance.legalName case final value?) 'legal_name': value,
  if (instance.siret case final value?) 'siret': value,
  if (instance.vatNumber case final value?) 'vat_number': value,
  if (instance.addressLine case final value?) 'address_line': value,
  if (instance.postalCode case final value?) 'postal_code': value,
  if (instance.city case final value?) 'city': value,
  if (instance.phone case final value?) 'phone': value,
  if (instance.email case final value?) 'email': value,
  if (instance.website case final value?) 'website': value,
};

_$BrandProfileUpdateInputImpl _$$BrandProfileUpdateInputImplFromJson(
  Map<String, dynamic> json,
) => _$BrandProfileUpdateInputImpl(
  primaryColor: json['primary_color'] as String?,
  secondaryColor: json['secondary_color'] as String?,
  fontFamily: json['font_family'] as String?,
  tagline: json['tagline'] as String?,
);

Map<String, dynamic> _$$BrandProfileUpdateInputImplToJson(
  _$BrandProfileUpdateInputImpl instance,
) => <String, dynamic>{
  if (instance.primaryColor case final value?) 'primary_color': value,
  if (instance.secondaryColor case final value?) 'secondary_color': value,
  if (instance.fontFamily case final value?) 'font_family': value,
  if (instance.tagline case final value?) 'tagline': value,
};
