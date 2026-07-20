import '../../catalog/data/catalog_models.dart';
import 'quote_draft_line.dart';

/// Client-side **preview** of the amounts the backend will compute, so the
/// artisan sees a live line total and a running quote total *while drafting*
/// — the behaviour the "Bêta Ready" brief requires (a quantity change must
/// visibly recompute the total).
///
/// The backend `QuoteCalculator` stays the single source of truth: once the
/// quote is created, its persisted HT/VAT/TTC always come from the backend
/// response. This class only mirrors the backend's rules **exactly** so the
/// preview never disagrees with the created quote by a cent:
///   * amounts are computed in integer cents (never `double`) — no
///     floating-point rounding error on money;
///   * each line is rounded to the cent with ROUND_HALF_UP;
///   * the quote totals are the sum of the already-rounded line totals.
///
/// See `backend/app/quotes/calculator.py` for the reference implementation.
class QuotePreviewCalculator {
  const QuotePreviewCalculator._();

  /// Parses a decimal string (backend Numeric(x,2), or a user-typed
  /// quantity that may use a French comma) into integer hundredths, e.g.
  /// `"2.5"` / `"2,5"` -> `250`. Returns `null` when the value is missing
  /// or not a number, and clamps negatives to `null` (a quote never has a
  /// negative quantity or price).
  static int? parseHundredths(String? raw) {
    if (raw == null) return null;
    final normalized = raw.trim().replaceAll(',', '.');
    if (normalized.isEmpty) return null;
    final value = double.tryParse(normalized);
    if (value == null || value < 0) return null;
    return (value * 100).round();
  }

  /// Divides `numerator` by `divisor` with ROUND_HALF_UP (both are
  /// non-negative here — quantities, prices and rates are never negative),
  /// matching `Decimal.quantize(..., ROUND_HALF_UP)` on the backend.
  static int _roundHalfUp(int numerator, int divisor) {
    return (numerator + divisor ~/ 2) ~/ divisor;
  }

  /// Totals for a single line, mirroring `QuoteCalculator.calculate_line`.
  /// Returns `null` when the quantity can't be parsed, so callers can show
  /// a dash instead of a bogus amount.
  static QuotePreviewLine? line({
    required String quantity,
    required String unitPriceHt,
    required String vatRate,
  }) {
    final qtyHundredths = parseHundredths(quantity);
    final priceHundredths = parseHundredths(unitPriceHt);
    final vatHundredths = parseHundredths(vatRate);
    if (qtyHundredths == null || priceHundredths == null || vatHundredths == null) {
      return null;
    }

    // quantity * unit_price is in units of 1/10000 € (two decimals each).
    final rawHt = qtyHundredths * priceHundredths;
    final totalHtCents = _roundHalfUp(rawHt, 100);
    // VAT is computed on the already-rounded HT, exactly like the backend:
    // total_ht(€) * vat_rate(%) / 100, expressed in cents.
    final totalVatCents = _roundHalfUp(totalHtCents * vatHundredths, 10000);
    return QuotePreviewLine(
      totalHtCents: totalHtCents,
      totalVatCents: totalVatCents,
      totalTtcCents: totalHtCents + totalVatCents,
    );
  }

  /// Quote totals for a set of draft lines, mirroring
  /// `QuoteCalculator.calculate_quote` (sum of the per-line rounded totals).
  /// Lines whose quantity can't be parsed contribute nothing.
  static QuotePreviewTotals totals(Iterable<QuoteDraftLine> lines) {
    var htCents = 0;
    var vatCents = 0;
    for (final draft in lines) {
      final computed = line(
        quantity: draft.quantity,
        unitPriceHt: draft.item.unitPriceHt,
        vatRate: draft.item.vatRate,
      );
      if (computed == null) continue;
      htCents += computed.totalHtCents;
      vatCents += computed.totalVatCents;
    }
    return QuotePreviewTotals(
      totalHtCents: htCents,
      totalVatCents: vatCents,
      totalTtcCents: htCents + vatCents,
    );
  }

  /// Convenience: the line total for a catalog item + quantity, ready to
  /// display. Kept separate from [line] so the form doesn't have to reach
  /// into the item for its price and VAT.
  static QuotePreviewLine? lineForItem(CatalogItem item, String quantity) {
    return line(
      quantity: quantity,
      unitPriceHt: item.unitPriceHt,
      vatRate: item.vatRate,
    );
  }

  /// Formats an integer-cents amount as the plain decimal string the rest
  /// of the app expects (e.g. `1234` -> `"12.34"`), so it can be handed to
  /// `CurrencyFormatter.format` just like a backend amount.
  static String centsToAmountString(int cents) {
    final euros = cents ~/ 100;
    final remainder = (cents % 100).toString().padLeft(2, '0');
    return '$euros.$remainder';
  }
}

/// Preview totals for one line, in integer cents.
class QuotePreviewLine {
  const QuotePreviewLine({
    required this.totalHtCents,
    required this.totalVatCents,
    required this.totalTtcCents,
  });

  final int totalHtCents;
  final int totalVatCents;
  final int totalTtcCents;
}

/// Preview totals for the whole quote, in integer cents.
class QuotePreviewTotals {
  const QuotePreviewTotals({
    required this.totalHtCents,
    required this.totalVatCents,
    required this.totalTtcCents,
  });

  final int totalHtCents;
  final int totalVatCents;
  final int totalTtcCents;
}
