import 'package:freezed_annotation/freezed_annotation.dart';

part 'orchestration_model.freezed.dart';
part 'orchestration_model.g.dart';

/// Mirrors the backend's `OrchestrationRead` (`app/orchestration/schemas.py`).
/// The Orchestration Engine owns only its state: plan, saga timeline, results
/// and status. `plan`/`timeline` are dynamic lists (entries are maps).
@freezed
class OrchestrationInstance with _$OrchestrationInstance {
  const factory OrchestrationInstance({
    required String id,
    required String companyId,
    required String correlationId,
    required String planKind,
    required String status,
    required bool isTerminal,
    @Default(<String, dynamic>{}) Map<String, dynamic> context,
    @Default(<dynamic>[]) List<dynamic> plan,
    @Default(<dynamic>[]) List<dynamic> timeline,
    @Default(<String, dynamic>{}) Map<String, dynamic> results,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OrchestrationInstance;

  factory OrchestrationInstance.fromJson(Map<String, dynamic> json) =>
      _$OrchestrationInstanceFromJson(json);
}
