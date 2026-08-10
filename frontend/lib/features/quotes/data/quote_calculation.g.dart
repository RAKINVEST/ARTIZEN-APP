// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_calculation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuoteCalculationLineImpl _$$QuoteCalculationLineImplFromJson(
  Map<String, dynamic> json,
) => _$QuoteCalculationLineImpl(
  catalogItemId: json['catalog_item_id'] as String?,
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
  if (instance.catalogItemId case final value?) 'catalog_item_id': value,
  'designation': instance.designation,
  'unit': instance.unit,
  'quantity': instance.quantity,
  'unit_price_ht': instance.unitPriceHt,
  'vat_rate': instance.vatRate,
  'total_ht': instance.totalHt,
  'total_vat': instance.totalVat,
  'total_ttc': instance.totalTtc,
};

_$VatBreakdownEntryImpl _$$VatBreakdownEntryImplFromJson(
  Map<String, dynamic> json,
) => _$VatBreakdownEntryImpl(
  rate: json['rate'] as String,
  baseHt: json['base_ht'] as String,
  vatAmount: json['vat_amount'] as String,
);

Map<String, dynamic> _$$VatBreakdownEntryImplToJson(
  _$VatBreakdownEntryImpl instance,
) => <String, dynamic>{
  'rate': instance.rate,
  'base_ht': instance.baseHt,
  'vat_amount': instance.vatAmount,
};

_$QuoteCalculationImpl _$$QuoteCalculationImplFromJson(
  Map<String, dynamic> json,
) => _$QuoteCalculationImpl(
  totalHt: json['total_ht'] as String,
  totalVat: json['total_vat'] as String,
  totalTtc: json['total_ttc'] as String,
  discountType: json['discount_type'] as String?,
  discountValue: json['discount_value'] as String? ?? '0.00',
  discountAmount: json['discount_amount'] as String? ?? '0.00',
  netTotalHt: json['net_total_ht'] as String? ?? '0.00',
  netTotalVat: json['net_total_vat'] as String? ?? '0.00',
  netTotalTtc: json['net_total_ttc'] as String? ?? '0.00',
  depositType: json['deposit_type'] as String?,
  depositValue: json['deposit_value'] as String? ?? '0.00',
  depositAmount: json['deposit_amount'] as String? ?? '0.00',
  balanceDue: json['balance_due'] as String? ?? '0.00',
  lines:
      (json['lines'] as List<dynamic>?)
          ?.map((e) => QuoteCalculationLine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <QuoteCalculationLine>[],
  vatBreakdown:
      (json['vat_breakdown'] as List<dynamic>?)
          ?.map((e) => VatBreakdownEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <VatBreakdownEntry>[],
);

Map<String, dynamic> _$$QuoteCalculationImplToJson(
  _$QuoteCalculationImpl instance,
) => <String, dynamic>{
  'total_ht': instance.totalHt,
  'total_vat': instance.totalVat,
  'total_ttc': instance.totalTtc,
  if (instance.discountType case final value?) 'discount_type': value,
  'discount_value': instance.discountValue,
  'discount_amount': instance.discountAmount,
  'net_total_ht': instance.netTotalHt,
  'net_total_vat': instance.netTotalVat,
  'net_total_ttc': instance.netTotalTtc,
  if (instance.depositType case final value?) 'deposit_type': value,
  'deposit_value': instance.depositValue,
  'deposit_amount': instance.depositAmount,
  'balance_due': instance.balanceDue,
  'lines': instance.lines,
  'vat_breakdown': instance.vatBreakdown,
};
