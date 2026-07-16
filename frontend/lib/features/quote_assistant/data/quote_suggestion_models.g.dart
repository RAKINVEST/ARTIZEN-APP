// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_suggestion_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuoteSuggestionItemImpl _$$QuoteSuggestionItemImplFromJson(
  Map<String, dynamic> json,
) => _$QuoteSuggestionItemImpl(
  catalogItemId: json['catalog_item_id'] as String,
  designation: json['designation'] as String,
  quantity: json['quantity'] as String,
  reason: json['reason'] as String,
);

Map<String, dynamic> _$$QuoteSuggestionItemImplToJson(
  _$QuoteSuggestionItemImpl instance,
) => <String, dynamic>{
  'catalog_item_id': instance.catalogItemId,
  'designation': instance.designation,
  'quantity': instance.quantity,
  'reason': instance.reason,
};

_$QuoteSuggestionImpl _$$QuoteSuggestionImplFromJson(
  Map<String, dynamic> json,
) => _$QuoteSuggestionImpl(
  items: (json['items'] as List<dynamic>)
      .map((e) => QuoteSuggestionItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  confidence: (json['confidence'] as num).toDouble(),
  comment: json['comment'] as String,
);

Map<String, dynamic> _$$QuoteSuggestionImplToJson(
  _$QuoteSuggestionImpl instance,
) => <String, dynamic>{
  'items': instance.items,
  'confidence': instance.confidence,
  'comment': instance.comment,
};
