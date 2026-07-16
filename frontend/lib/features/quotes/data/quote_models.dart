import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_models.freezed.dart';
part 'quote_models.g.dart';

/// Mirrors `QuoteLineRead`. Every amount here (`unitPriceHt`, `vatRate`,
/// `totalHt`, `totalVat`, `totalTtc`) was computed by `QuoteCalculator` on
/// the backend — nothing in this app ever derives or recomputes them.
@freezed
class QuoteLine with _$QuoteLine {
  const factory QuoteLine({
    required String id,
    required String catalogItemId,
    required String designation,
    required String unit,
    required String quantity,
    required String unitPriceHt,
    required String vatRate,
    required String totalHt,
    required String totalVat,
    required String totalTtc,
  }) = _QuoteLine;

  factory QuoteLine.fromJson(Map<String, dynamic> json) => _$QuoteLineFromJson(json);
}

/// Mirrors `QuoteRead`.
@freezed
class Quote with _$Quote {
  const factory Quote({
    required String id,
    required String companyId,
    required String clientId,
    required String totalHt,
    required String totalVat,
    required String totalTtc,
    required List<QuoteLine> lines,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
}

/// Mirrors `QuoteLineCreate`: only a catalog item and a quantity — no price
/// field exists here, structurally matching the backend's "no free price"
/// rule (see `app/quotes/schemas.py`).
@freezed
class QuoteLineInput with _$QuoteLineInput {
  const factory QuoteLineInput({
    required String catalogItemId,
    required String quantity,
  }) = _QuoteLineInput;

  factory QuoteLineInput.fromJson(Map<String, dynamic> json) => _$QuoteLineInputFromJson(json);
}
