import 'package:freezed_annotation/freezed_annotation.dart';

import '../../quotes/data/quote_calculation.dart';

part 'quote_draft.freezed.dart';

/// One line of a draft, captured as a **snapshot** when the article is picked
/// (docs/DECISIONS.md, décision 5): its designation, unit and unit price
/// travel with the line, and [catalogItemId] is its origin. No amount is
/// computed here — the server calculation holds the authoritative totals.
///
/// Free lines and custom prices (also décision 5) need the backend extension
/// that makes `catalog_item_id` nullable and adds a price field; until then a
/// draft line always references a catalog item.
@freezed
class DraftLine with _$DraftLine {
  const factory DraftLine({
    required String catalogItemId,
    required String designation,
    required String unit,
    required num quantity,
    required String unitPriceHt,
    required String vatRate,
  }) = _DraftLine;
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
