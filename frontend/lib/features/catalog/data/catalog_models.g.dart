// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CatalogCategoryImpl _$$CatalogCategoryImplFromJson(
  Map<String, dynamic> json,
) => _$CatalogCategoryImpl(
  id: json['id'] as String,
  companyId: json['company_id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$CatalogCategoryImplToJson(
  _$CatalogCategoryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'company_id': instance.companyId,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

_$CatalogCategoryInputImpl _$$CatalogCategoryInputImplFromJson(
  Map<String, dynamic> json,
) => _$CatalogCategoryInputImpl(
  name: json['name'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$$CatalogCategoryInputImplToJson(
  _$CatalogCategoryInputImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
};

_$CatalogItemImpl _$$CatalogItemImplFromJson(Map<String, dynamic> json) =>
    _$CatalogItemImpl(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      categoryId: json['category_id'] as String,
      code: json['code'] as String?,
      designation: json['designation'] as String,
      description: json['description'] as String?,
      itemType: $enumDecode(_$ItemTypeEnumMap, json['item_type']),
      unit: json['unit'] as String,
      unitPriceHt: json['unit_price_ht'] as String,
      vatRate: json['vat_rate'] as String,
      estimatedDurationMinutes: (json['estimated_duration_minutes'] as num?)
          ?.toInt(),
      active: json['active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$CatalogItemImplToJson(_$CatalogItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'category_id': instance.categoryId,
      if (instance.code case final value?) 'code': value,
      'designation': instance.designation,
      if (instance.description case final value?) 'description': value,
      'item_type': _$ItemTypeEnumMap[instance.itemType]!,
      'unit': instance.unit,
      'unit_price_ht': instance.unitPriceHt,
      'vat_rate': instance.vatRate,
      if (instance.estimatedDurationMinutes case final value?)
        'estimated_duration_minutes': value,
      'active': instance.active,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$ItemTypeEnumMap = {
  ItemType.service: 'service',
  ItemType.product: 'product',
};

_$CatalogItemInputImpl _$$CatalogItemInputImplFromJson(
  Map<String, dynamic> json,
) => _$CatalogItemInputImpl(
  categoryId: json['category_id'] as String,
  code: json['code'] as String?,
  designation: json['designation'] as String,
  description: json['description'] as String?,
  itemType: $enumDecode(_$ItemTypeEnumMap, json['item_type']),
  unit: json['unit'] as String,
  unitPriceHt: json['unit_price_ht'] as String,
  vatRate: json['vat_rate'] as String,
  estimatedDurationMinutes: (json['estimated_duration_minutes'] as num?)
      ?.toInt(),
);

Map<String, dynamic> _$$CatalogItemInputImplToJson(
  _$CatalogItemInputImpl instance,
) => <String, dynamic>{
  'category_id': instance.categoryId,
  if (instance.code case final value?) 'code': value,
  'designation': instance.designation,
  if (instance.description case final value?) 'description': value,
  'item_type': _$ItemTypeEnumMap[instance.itemType]!,
  'unit': instance.unit,
  'unit_price_ht': instance.unitPriceHt,
  'vat_rate': instance.vatRate,
  if (instance.estimatedDurationMinutes case final value?)
    'estimated_duration_minutes': value,
};
