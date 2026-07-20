import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_calculation.freezed.dart';
part 'quote_calculation.g.dart';

/// A priced draft returned by `POST /quotes/calculate` — **nothing is
/// persisted**. The backend's `QuoteCalculator` is the only place HT/VAT/TTC
/// are computed; the assistant displays these figures and never adds anything
/// up itself (docs/DECISIONS.md, décision 3). Amounts stay `String` (Decimal),
/// never `double`.
@freezed
class QuoteCalculationLine with _$QuoteCalculationLine {
  const factory QuoteCalculationLine({
    required String catalogItemId,
    required String designation,
    required String unit,
    required String quantity,
    required String unitPriceHt,
    required String vatRate,
    required String totalHt,
    required String totalVat,
    required String totalTtc,
  }) = _QuoteCalculationLine;

  factory QuoteCalculationLine.fromJson(Map<String, dynamic> json) =>
      _$QuoteCalculationLineFromJson(json);
}

@freezed
class QuoteCalculation with _$QuoteCalculation {
  const factory QuoteCalculation({
    required String totalHt,
    required String totalVat,
    required String totalTtc,
    @Default(<QuoteCalculationLine>[]) List<QuoteCalculationLine> lines,
  }) = _QuoteCalculation;

  factory QuoteCalculation.fromJson(Map<String, dynamic> json) =>
      _$QuoteCalculationFromJson(json);
}
