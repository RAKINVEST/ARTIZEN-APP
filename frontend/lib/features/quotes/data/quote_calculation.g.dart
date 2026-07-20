// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_calculation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuoteCalculationLineImpl _$$QuoteCalculationLineImplFromJson(
  Map<String, dynamic> json,
) => _$QuoteCalculationLineImpl(
  catalogItemId: json['catalog_item_id'] as String,
  designation: json['designation'] as String,
  unit: json['unit'] as String,
  quantity: json['quantity'] as String,
  unitPriceHt: json['unit_price_ht'] as String,
  vatRate: json['vat_rate'] as String,
  totalHt: json['total_ht'] as String,
  totalVat: json['total_vat'] as String,
  totalTtc: json['total_ttc'] as String,
);

Map<String, dynamic> _$$QuoteCalculationLineImplToJson(
  _$QuoteCalculationLineImpl instance,
) => <String, dynamic>{
  'catalog_item_id': instance.catalogItemId,
  'designation': instance.designation,
  'unit': instance.unit,
  'quantity': instance.quantity,
  'unit_price_ht': instance.unitPriceHt,
  'vat_rate': instance.vatRate,
  'total_ht': instance.totalHt,
  'total_vat': instance.totalVat,
  'total_ttc': instance.totalTtc,
};

_$QuoteCalculationImpl _$$QuoteCalculationImplFromJson(
  Map<String, dynamic> json,
) => _$QuoteCalculationImpl(
  totalHt: json['total_ht'] as String,
  totalVat: json['total_vat'] as String,
  totalTtc: json['total_ttc'] as String,
  lines:
      (json['lines'] as List<dynamic>?)
          ?.map((e) => QuoteCalculationLine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <QuoteCalculationLine>[],
);

Map<String, dynamic> _$$QuoteCalculationImplToJson(
  _$QuoteCalculationImpl instance,
) => <String, dynamic>{
  'total_ht': instance.totalHt,
  'total_vat': instance.totalVat,
  'total_ttc': instance.totalTtc,
  'lines': instance.lines,
};
