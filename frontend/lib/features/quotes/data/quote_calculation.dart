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
    // Null for a free line — the priced preview echoes back what was sent.
    String? catalogItemId,
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

/// One per-rate VAT row (the *ventilation* a French quote shows), mirroring
/// the backend's `VatBucketRead`. Amounts stay `String` (Decimal) — the
/// backend computes them, this only displays.
@freezed
class VatBreakdownEntry with _$VatBreakdownEntry {
  const factory VatBreakdownEntry({
    required String rate,
    required String baseHt,
    required String vatAmount,
  }) = _VatBreakdownEntry;

  factory VatBreakdownEntry.fromJson(Map<String, dynamic> json) =>
      _$VatBreakdownEntryFromJson(json);
}

@freezed
class QuoteCalculation with _$QuoteCalculation {
  const factory QuoteCalculation({
    /// The GROSS subtotal (sum of the lines, before any discount).
    required String totalHt,
    required String totalVat,
    required String totalTtc,
    // Discount + deposit (V1.1 #3) — every figure computed by the backend. With
    // no discount, net == gross; with no deposit, balanceDue == net TTC.
    String? discountType,
    @Default('0.00') String discountValue,
    @Default('0.00') String discountAmount,
    @Default('0.00') String netTotalHt,
    @Default('0.00') String netTotalVat,
    @Default('0.00') String netTotalTtc,
    String? depositType,
    @Default('0.00') String depositValue,
    @Default('0.00') String depositAmount,
    @Default('0.00') String balanceDue,
    @Default(<QuoteCalculationLine>[]) List<QuoteCalculationLine> lines,
    // Per-rate VAT ventilation (net) — the backend's figures, shown at the
    // Récap. Empty when there are no lines.
    @Default(<VatBreakdownEntry>[]) List<VatBreakdownEntry> vatBreakdown,
  }) = _QuoteCalculation;

  factory QuoteCalculation.fromJson(Map<String, dynamic> json) =>
      _$QuoteCalculationFromJson(json);
}
