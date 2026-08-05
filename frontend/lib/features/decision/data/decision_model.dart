import 'package:freezed_annotation/freezed_annotation.dart';

part 'decision_model.freezed.dart';
part 'decision_model.g.dart';

/// Mirrors the backend's `DecisionResponse` (`app/decision/schemas.py`).
/// Since the Knowledge integration, a proposal is a set of **knowledge
/// elements** (cards, kits, diagnostics…) sourced from the Knowledge Engine —
/// with their confidence, sources and relations. Read-side: no price.
double _numFromJson(Object? value) =>
    value is num ? value.toDouble() : double.parse(value.toString());

@freezed
class DecisionIntent with _$DecisionIntent {
  const factory DecisionIntent({
    required String verb,
    required String target,
    required String raw,
  }) = _DecisionIntent;

  factory DecisionIntent.fromJson(Map<String, dynamic> json) =>
      _$DecisionIntentFromJson(json);
}

@freezed
class DecisionProposalElement with _$DecisionProposalElement {
  const factory DecisionProposalElement({
    required String slug,
    required String type,
    required String title,
    required String reason,
    @JsonKey(fromJson: _numFromJson) required double score,
    @Default('') String confidence,
    @Default(<String>[]) List<String> sources,
    @Default(<String>[]) List<String> relations,
  }) = _DecisionProposalElement;

  factory DecisionProposalElement.fromJson(Map<String, dynamic> json) =>
      _$DecisionProposalElementFromJson(json);
}

@freezed
class DecisionProposal with _$DecisionProposal {
  const factory DecisionProposal({
    @Default(<DecisionProposalElement>[]) List<DecisionProposalElement> elements,
    @Default('') String comment,
  }) = _DecisionProposal;

  factory DecisionProposal.fromJson(Map<String, dynamic> json) =>
      _$DecisionProposalFromJson(json);
}

@freezed
class DecisionExplanationItem with _$DecisionExplanationItem {
  const factory DecisionExplanationItem({
    required String subject,
    required String why,
    required String basis,
    @Default('') String confidence,
  }) = _DecisionExplanationItem;

  factory DecisionExplanationItem.fromJson(Map<String, dynamic> json) =>
      _$DecisionExplanationItemFromJson(json);
}

@freezed
class DecisionExplanation with _$DecisionExplanation {
  const factory DecisionExplanation({
    @Default(<DecisionExplanationItem>[]) List<DecisionExplanationItem> items,
  }) = _DecisionExplanation;

  factory DecisionExplanation.fromJson(Map<String, dynamic> json) =>
      _$DecisionExplanationFromJson(json);
}

@freezed
class DecisionResult with _$DecisionResult {
  const factory DecisionResult({
    required DecisionIntent intent,
    required DecisionProposal proposal,
    required DecisionExplanation explanation,
    @JsonKey(fromJson: _numFromJson) required double confidence,
    required bool needsConfirmation,
    @Default(<String>[]) List<String> questions,
  }) = _DecisionResult;

  factory DecisionResult.fromJson(Map<String, dynamic> json) =>
      _$DecisionResultFromJson(json);
}
