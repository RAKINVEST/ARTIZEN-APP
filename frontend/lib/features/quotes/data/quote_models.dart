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
    // Null for a free line (décision 5), or once the catalog item behind a
    // line has been deleted (backend SET NULL). The snapshot below still holds.
    String? catalogItemId,
    required String designation,
    required String unit,
    required String quantity,
    required String unitPriceHt,
    required String vatRate,
    required String totalHt,
    required String totalVat,
    required String totalTtc,
  }) = _QuoteLine;

  factory QuoteLine.fromJson(Map<String, dynamic> json) =>
      _$QuoteLineFromJson(json);
}

/// Mirrors the backend's `QuoteStatus`. The commercial life of a quote.
///
/// Only [draft] is mutable, and only [draft] can be deleted — the backend
/// answers 409 otherwise. That is not a UI convention to be re-decided
/// here: past `draft` the customer holds a PDF, and the document they hold
/// must never disagree with the one in the app.
@JsonEnum(fieldRename: FieldRename.snake)
enum QuoteStatus {
  draft,
  pending,
  sent,
  accepted,
  refused;

  /// What the artisan reads. The wire values stay English to match the
  /// backend; only the label is translated.
  String get label => switch (this) {
    QuoteStatus.draft => 'Brouillon',
    QuoteStatus.pending => 'En attente',
    QuoteStatus.sent => 'Envoyé',
    QuoteStatus.accepted => 'Accepté',
    QuoteStatus.refused => 'Refusé',
  };

  /// Mirrors the backend's `QUOTE_TRANSITIONS`. Duplicated on purpose:
  /// the app must not offer a button the server will refuse. The backend
  /// stays the authority — this only decides what to *show*. The artisan first
  /// validates a draft (→ pending), then sends it (→ sent); no shortcut, and
  /// nothing ever travels backwards.
  List<QuoteStatus> get nextStates => switch (this) {
    QuoteStatus.draft => const [QuoteStatus.pending],
    QuoteStatus.pending => const [QuoteStatus.sent],
    QuoteStatus.sent => const [QuoteStatus.accepted, QuoteStatus.refused],
    QuoteStatus.accepted || QuoteStatus.refused => const [],
  };

  /// Only a draft is editable/deletable — validating it (→ pending) freezes it.
  bool get isEditable => this == QuoteStatus.draft;
}

/// Mirrors `QuoteRead`.
@freezed
class Quote with _$Quote {
  const factory Quote({
    required String id,
    required String companyId,
    required String clientId,

    /// "DEV-2026-0001" — what the artisan and their customer actually use.
    /// `id` is a UUID nobody reads out loud.
    required String quoteNumber,
    required QuoteStatus status,
    required String totalHt,
    required String totalVat,
    required String totalTtc,
    required List<QuoteLine> lines,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
}

/// Mirrors `QuoteLineCreate` (décision 5). Two shapes:
/// - **catalog line** — [catalogItemId] set, [unitPriceHt] an *optional*
///   override of the catalog price; the other fields stay null;
/// - **free line** — [catalogItemId] null, with [designation], [unit],
///   [unitPriceHt] and [vatRate] all supplied.
///
/// Null fields are omitted from the JSON (`include_if_null: false`), so a plain
/// catalog line stays `{catalog_item_id, quantity}` on the wire — identical to
/// before this feature — and the backend re-reads the current catalog price.
@freezed
class QuoteLineInput with _$QuoteLineInput {
  const factory QuoteLineInput({
    String? catalogItemId,
    required String quantity,
    String? designation,
    String? unit,
    String? unitPriceHt,
    String? vatRate,
  }) = _QuoteLineInput;

  factory QuoteLineInput.fromJson(Map<String, dynamic> json) =>
      _$QuoteLineInputFromJson(json);
}
