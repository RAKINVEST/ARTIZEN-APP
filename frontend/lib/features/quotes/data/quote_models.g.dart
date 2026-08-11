// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuoteLineImpl _$$QuoteLineImplFromJson(Map<String, dynamic> json) =>
    _$QuoteLineImpl(
      id: json['id'] as String,
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

Map<String, dynamic> _$$QuoteLineImplToJson(_$QuoteLineImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
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

_$QuoteImpl _$$QuoteImplFromJson(Map<String, dynamic> json) => _$QuoteImpl(
  id: json['id'] as String,
  companyId: json['company_id'] as String,
  clientId: json['client_id'] as String,
  object: json['object'] as String?,
  quoteNumber: json['quote_number'] as String,
  status: $enumDecode(_$QuoteStatusEnumMap, json['status']),
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
  lines: (json['lines'] as List<dynamic>)
      .map((e) => QuoteLine.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$QuoteImplToJson(_$QuoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'client_id': instance.clientId,
      if (instance.object case final value?) 'object': value,
      'quote_number': instance.quoteNumber,
      'status': _$QuoteStatusEnumMap[instance.status]!,
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
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$QuoteStatusEnumMap = {
  QuoteStatus.draft: 'draft',
  QuoteStatus.pending: 'pending',
  QuoteStatus.sent: 'sent',
  QuoteStatus.accepted: 'accepted',
  QuoteStatus.refused: 'refused',
};

_$QuoteLineInputImpl _$$QuoteLineInputImplFromJson(Map<String, dynamic> json) =>
    _$QuoteLineInputImpl(
      catalogItemId: json['catalog_item_id'] as String?,
      quantity: json['quantity'] as String,
      designation: json['designation'] as String?,
      unit: json['unit'] as String?,
      unitPriceHt: json['unit_price_ht'] as String?,
      vatRate: json['vat_rate'] as String?,
    );

Map<String, dynamic> _$$QuoteLineInputImplToJson(
  _$QuoteLineInputImpl instance,
) => <String, dynamic>{
  if (instance.catalogItemId case final value?) 'catalog_item_id': value,
  'quantity': instance.quantity,
  if (instance.designation case final value?) 'designation': value,
  if (instance.unit case final value?) 'unit': value,
  if (instance.unitPriceHt case final value?) 'unit_price_ht': value,
  if (instance.vatRate case final value?) 'vat_rate': value,
};
