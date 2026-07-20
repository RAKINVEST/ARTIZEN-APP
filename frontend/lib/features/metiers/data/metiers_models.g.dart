// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metiers_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CatalogPackSummaryImpl _$$CatalogPackSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$CatalogPackSummaryImpl(
  name: json['name'] as String,
  itemCount: (json['item_count'] as num).toInt(),
);

Map<String, dynamic> _$$CatalogPackSummaryImplToJson(
  _$CatalogPackSummaryImpl instance,
) => <String, dynamic>{'name': instance.name, 'item_count': instance.itemCount};

_$CatalogSourceImpl _$$CatalogSourceImplFromJson(Map<String, dynamic> json) =>
    _$CatalogSourceImpl(
      slug: json['slug'] as String,
      label: json['label'] as String,
      description: json['description'] as String?,
      packs:
          (json['packs'] as List<dynamic>?)
              ?.map(
                (e) => CatalogPackSummary.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <CatalogPackSummary>[],
      itemCount: (json['item_count'] as num).toInt(),
      productCount: (json['product_count'] as num).toInt(),
      prestationCount: (json['prestation_count'] as num).toInt(),
      status: $enumDecode(_$CatalogSourceStatusEnumMap, json['status']),
      version: (json['version'] as num).toInt(),
      importedVersion: (json['imported_version'] as num?)?.toInt(),
      importedAt: json['imported_at'] == null
          ? null
          : DateTime.parse(json['imported_at'] as String),
      updateItemCount: (json['update_item_count'] as num?)?.toInt(),
      updateNotes: (json['update_notes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CatalogSourceImplToJson(
  _$CatalogSourceImpl instance,
) => <String, dynamic>{
  'slug': instance.slug,
  'label': instance.label,
  if (instance.description case final value?) 'description': value,
  'packs': instance.packs,
  'item_count': instance.itemCount,
  'product_count': instance.productCount,
  'prestation_count': instance.prestationCount,
  'status': _$CatalogSourceStatusEnumMap[instance.status]!,
  'version': instance.version,
  if (instance.importedVersion case final value?) 'imported_version': value,
  if (instance.importedAt?.toIso8601String() case final value?)
    'imported_at': value,
  if (instance.updateItemCount case final value?) 'update_item_count': value,
  if (instance.updateNotes case final value?) 'update_notes': value,
};

const _$CatalogSourceStatusEnumMap = {
  CatalogSourceStatus.available: 'available',
  CatalogSourceStatus.imported: 'imported',
  CatalogSourceStatus.updateAvailable: 'update_available',
};

_$CatalogImportResultImpl _$$CatalogImportResultImplFromJson(
  Map<String, dynamic> json,
) => _$CatalogImportResultImpl(
  slug: json['slug'] as String,
  label: json['label'] as String,
  categoriesCreated: (json['categories_created'] as num).toInt(),
  itemsCreated: (json['items_created'] as num).toInt(),
  itemsSkipped: (json['items_skipped'] as num).toInt(),
);

Map<String, dynamic> _$$CatalogImportResultImplToJson(
  _$CatalogImportResultImpl instance,
) => <String, dynamic>{
  'slug': instance.slug,
  'label': instance.label,
  'categories_created': instance.categoriesCreated,
  'items_created': instance.itemsCreated,
  'items_skipped': instance.itemsSkipped,
};
