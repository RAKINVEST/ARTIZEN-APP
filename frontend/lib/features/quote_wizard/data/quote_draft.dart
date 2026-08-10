import 'package:freezed_annotation/freezed_annotation.dart';

import '../../quotes/data/quote_calculation.dart';
import '../../quotes/data/quote_models.dart';

part 'quote_draft.freezed.dart';

int _freeLineSeq = 0;

/// A locally-unique id for a free line. No `uuid` dependency — a monotonic
/// counter plus the clock is unique within a session, which is all a draft
/// line's identity needs (it never leaves the client under this name).
String newFreeLineId() =>
    'free-${DateTime.now().microsecondsSinceEpoch}-${_freeLineSeq++}';

/// One line of a draft, captured as a **snapshot** when it is added
/// (docs/DECISIONS.md, décision 5): its designation, unit, price and VAT travel
/// with the line. No amount is computed here — the server calculation holds the
/// authoritative totals.
///
/// A line is either a **catalog line** ([catalogItemId] set — a trace of
/// origin) or a **free line** ([catalogItemId] null: péage, location…). Its
/// price can be overridden by the artisan ([priceOverridden]).
@freezed
class DraftLine with _$DraftLine {
  const factory DraftLine({
    /// Stable identity of the line within the draft. For a catalog line it is
    /// the catalog item's id (so ticking the same article twice bumps its
    /// quantity rather than duplicating it); for a free line it is a generated
    /// key ([newFreeLineId]), so two free lines never collapse into one.
    required String id,

    /// Null for a free line — décision 5.
    String? catalogItemId,
    required String designation,
    required String unit,
    required num quantity,
    required String unitPriceHt,
    required String vatRate,

    /// True once the artisan set a price different from the catalog's. Only
    /// then does the override travel to the backend for a catalog line — an
    /// untouched catalog line sends no price, so the server re-reads the
    /// current catalog price exactly as before this feature.
    @Default(false) bool priceOverridden,
  }) = _DraftLine;
}

extension DraftLineInput on DraftLine {
  /// Maps this line to the API's `QuoteLineCreate`. A free line carries its
  /// whole snapshot; a catalog line carries only its id and quantity — plus its
  /// price *only* when overridden — so an untouched catalog line stays
  /// byte-identical to before this feature.
  QuoteLineInput toInput() {
    if (catalogItemId == null) {
      return QuoteLineInput(
        quantity: quantity.toString(),
        designation: designation,
        unit: unit,
        unitPriceHt: unitPriceHt,
        vatRate: vatRate,
      );
    }
    return QuoteLineInput(
      catalogItemId: catalogItemId,
      quantity: quantity.toString(),
      unitPriceHt: priceOverridden ? unitPriceHt : null,
    );
  }
}

/// The quote in preparation — the business object the whole wizard edits
/// (docs/DECISIONS.md, décision 4). **Not UI state**: it holds the chosen
/// client, the lines, and the last server calculation, and it is exactly what
/// a future auto-save / resume / offline mode will persist.
///
/// It computes no amount (décision 3): [calculation] is the backend's word,
/// refreshed by [QuoteDraftNotifier.recalculate]. The wizard screens never
/// touch these lists directly — they ask the notifier to add an article,
/// change a quantity, recalculate, reset.
@freezed
class QuoteDraft with _$QuoteDraft {
  const factory QuoteDraft({
    String? clientId,
    String? clientLabel,
    @Default(<DraftLine>[]) List<DraftLine> lines,
    QuoteCalculation? calculation,
  }) = _QuoteDraft;

  const QuoteDraft._();

  // The chosen folder is deliberately NOT here: a folder only guides
  // navigation ("where do I work?"), the quote itself is its lines. Keeping it
  // out of the draft makes it structurally impossible to persist it with the
  // quote — it lives in `selectedFolderProvider` instead.

  bool get hasClient => clientId != null;
  bool get hasLines => lines.isNotEmpty;
  bool get isEmpty => clientId == null && lines.isEmpty;

  /// The last server calculation is present — the "Vérifier" step has real
  /// amounts to show. (Freshness vs the current lines firms up when the
  /// Personnaliser step wires live recalculation.)
  bool get hasValidCalculation => calculation != null;

  /// A client and at least one line: enough to price and create a quote.
  bool get canCreate => hasClient && hasLines;
}
