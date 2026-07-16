import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_suggestion_models.freezed.dart';
part 'quote_suggestion_models.g.dart';

/// Mirrors `QuoteSuggestionItemRead` (`app/quote_assistant/schemas.py`).
/// `quantity` stays a decimal string, never a computed amount: this
/// feature never carries a price, only which catalog item (and how
/// much of it) the AI matched against the free-text description.
@freezed
class QuoteSuggestionItem with _$QuoteSuggestionItem {
  const factory QuoteSuggestionItem({
    required String catalogItemId,
    required String designation,
    required String quantity,
    required String reason,
  }) = _QuoteSuggestionItem;

  factory QuoteSuggestionItem.fromJson(Map<String, dynamic> json) =>
      _$QuoteSuggestionItemFromJson(json);
}

/// Mirrors `QuoteSuggestionRead`. `confidence` (0..1) and `comment` come
/// straight from the backend's `SuggestionScorer`/AI response — nothing
/// here is computed client-side.
@freezed
class QuoteSuggestion with _$QuoteSuggestion {
  const factory QuoteSuggestion({
    required List<QuoteSuggestionItem> items,
    required double confidence,
    required String comment,
  }) = _QuoteSuggestion;

  factory QuoteSuggestion.fromJson(Map<String, dynamic> json) => _$QuoteSuggestionFromJson(json);
}
