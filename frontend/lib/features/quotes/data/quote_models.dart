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

/// Mirrors `QuoteLineCreate`: only a catalog item and a quantity — no price
/// field exists here, structurally matching the backend's "no free price"
/// rule (see `app/quotes/schemas.py`).
@freezed
class QuoteLineInput with _$QuoteLineInput {
  const factory QuoteLineInput({
    required String catalogItemId,
    required String quantity,
  }) = _QuoteLineInput;

  factory QuoteLineInput.fromJson(Map<String, dynamic> json) =>
      _$QuoteLineInputFromJson(json);
}
