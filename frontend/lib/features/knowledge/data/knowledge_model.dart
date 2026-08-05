import 'package:freezed_annotation/freezed_annotation.dart';

part 'knowledge_model.freezed.dart';
part 'knowledge_model.g.dart';

/// Mirrors the backend's knowledge read-models (`app/knowledge/schemas.py`).
/// The Knowledge Engine is read-side: these are display-only projections of the
/// corpus. `score` uses a tolerant converter (number or string).
double _numFromJson(Object? value) =>
    value is num ? value.toDouble() : double.parse(value.toString());

@freezed
class KnowledgeItem with _$KnowledgeItem {
  const factory KnowledgeItem({
    required String slug,
    required String type,
    required String title,
    @Default('') String profession,
    @Default(<String>[]) List<String> tags,
    @Default('brouillon') String status,
    @Default('') String confidence,
    @Default(<String>[]) List<String> relations,
    @Default(<String>[]) List<String> sources,
    @Default('') String summary,
    @Default('') String path,
  }) = _KnowledgeItem;

  factory KnowledgeItem.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeItemFromJson(json);
}

@freezed
class KnowledgeMatch with _$KnowledgeMatch {
  const factory KnowledgeMatch({
    required KnowledgeItem item,
    @JsonKey(fromJson: _numFromJson) required double score,
    required String why,
  }) = _KnowledgeMatch;

  factory KnowledgeMatch.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeMatchFromJson(json);
}

@freezed
class KnowledgeSearchResult with _$KnowledgeSearchResult {
  const factory KnowledgeSearchResult({
    @Default(0) int total,
    required bool includeDrafts,
    @Default(<KnowledgeMatch>[]) List<KnowledgeMatch> matches,
  }) = _KnowledgeSearchResult;

  factory KnowledgeSearchResult.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeSearchResultFromJson(json);
}

@freezed
class KnowledgeDetail with _$KnowledgeDetail {
  const factory KnowledgeDetail({
    required KnowledgeItem item,
    @Default(<KnowledgeItem>[]) List<KnowledgeItem> related,
  }) = _KnowledgeDetail;

  factory KnowledgeDetail.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeDetailFromJson(json);
}
