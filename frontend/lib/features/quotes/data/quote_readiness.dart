import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_readiness.freezed.dart';
part 'quote_readiness.g.dart';

/// Where an unmet requirement must be fixed. Mirrors the backend's `target`
/// values on `GET /quotes/{id}/readiness`. [unknown] is the graceful
/// fall-back for any future target this build doesn't yet know how to route.
@JsonEnum(fieldRename: FieldRename.snake)
enum ReadinessTarget {
  /// "Mon entreprise" — a company-level field is missing.
  companyProfile,

  /// The client attached to the quote is missing a field.
  client,

  /// The quote itself needs fixing (recreated, since a quote is immutable).
  quote,

  /// A target this client version can't route — shown but not navigable.
  unknown,
}

/// One blocking requirement returned by the readiness check. [code] is the
/// stable machine identifier, [label] the human sentence to show, [target]
/// the screen to open, and [field] (when present) the exact field to focus.
@freezed
class ReadinessIssue with _$ReadinessIssue {
  const factory ReadinessIssue({
    required String code,
    required String label,
    @JsonKey(unknownEnumValue: ReadinessTarget.unknown) required ReadinessTarget target,
    String? field,
  }) = _ReadinessIssue;

  factory ReadinessIssue.fromJson(Map<String, dynamic> json) => _$ReadinessIssueFromJson(json);
}

/// The verdict of `GET /quotes/{id}/readiness`: whether the quote can be
/// emitted, and the list of what's missing when it can't. The backend stays
/// the authority — this app only reads it and routes the artisan to the fix.
@freezed
class QuoteReadiness with _$QuoteReadiness {
  const factory QuoteReadiness({
    required bool ready,
    @Default(<ReadinessIssue>[]) List<ReadinessIssue> issues,
  }) = _QuoteReadiness;

  factory QuoteReadiness.fromJson(Map<String, dynamic> json) => _$QuoteReadinessFromJson(json);
}
