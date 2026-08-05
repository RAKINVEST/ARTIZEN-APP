import 'package:freezed_annotation/freezed_annotation.dart';

part 'companion_model.freezed.dart';
part 'companion_model.g.dart';

/// Mirrors the backend's `ChatResponse` (`app/ai_companion/schemas.py`). Every
/// reply is explainable: it carries why/engine/confidence, its sources, and
/// whether a human validation is required. The Companion proposes; the artisan
/// decides.
@freezed
class ChatResponse with _$ChatResponse {
  const factory ChatResponse({
    required String sessionId,
    required String intent,
    required String message,
    required Explanation explanation,
    @Default(<SourceRef>[]) List<SourceRef> sources,
    ProposedAction? proposedAction,
    @Default(false) bool needsConfirmation,
    @Default(<String>[]) List<String> questions,
    @Default(false) bool executed,
    Map<String, dynamic>? result,
  }) = _ChatResponse;

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);
}

@freezed
class Explanation with _$Explanation {
  const factory Explanation({
    @Default('') String why,
    @Default('companion') String engine,
    @Default(<String>[]) List<String> knowledgeUsed,
    @Default(0) double confidence,
    @Default(false) bool needsConfirmation,
  }) = _Explanation;

  factory Explanation.fromJson(Map<String, dynamic> json) =>
      _$ExplanationFromJson(json);
}

@freezed
class ProposedAction with _$ProposedAction {
  const factory ProposedAction({
    required String tool,
    required String engine,
    @Default('') String description,
    Map<String, dynamic>? params,
    @Default(<String>[]) List<String> missing,
  }) = _ProposedAction;

  factory ProposedAction.fromJson(Map<String, dynamic> json) =>
      _$ProposedActionFromJson(json);
}

@freezed
class SourceRef with _$SourceRef {
  const factory SourceRef({
    required String kind,
    @Default('') String ref,
    @Default('') String title,
  }) = _SourceRef;

  factory SourceRef.fromJson(Map<String, dynamic> json) =>
      _$SourceRefFromJson(json);
}
