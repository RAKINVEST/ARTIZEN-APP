import 'package:freezed_annotation/freezed_annotation.dart';

part 'workflow_model.freezed.dart';
part 'workflow_model.g.dart';

/// Mirrors the backend's workflow schemas (`app/workflow/schemas.py`).
/// `context` and `history` are kept as raw maps (the process carries arbitrary
/// context; history entries are {event, from, to, actor, at}).

@freezed
class WfTransition with _$WfTransition {
  const factory WfTransition({
    required String event,
    required String source,
    required String target,
    @Default(false) bool requiresValidation,
  }) = _WfTransition;

  factory WfTransition.fromJson(Map<String, dynamic> json) =>
      _$WfTransitionFromJson(json);
}

@freezed
class WorkflowDefinition with _$WorkflowDefinition {
  const factory WorkflowDefinition({
    required String slug,
    required String name,
    required String initialState,
    @Default(<String>[]) List<String> states,
    @Default(<String>[]) List<String> terminalStates,
    @Default(<WfTransition>[]) List<WfTransition> transitions,
  }) = _WorkflowDefinition;

  factory WorkflowDefinition.fromJson(Map<String, dynamic> json) =>
      _$WorkflowDefinitionFromJson(json);
}

@freezed
class WorkflowInstance with _$WorkflowInstance {
  const factory WorkflowInstance({
    required String id,
    required String companyId,
    required String definitionSlug,
    required String currentState,
    required String status,
    @Default(<String, dynamic>{}) Map<String, dynamic> context,
    // History entries are {event, from, to, actor, at}; typed as dynamic to
    // avoid a Freezed @Default parsing bug on nested generics (<Map<..>>[]).
    @Default(<dynamic>[]) List<dynamic> history,
    @Default(<String>[]) List<String> availableEvents,
    required bool isTerminal,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WorkflowInstance;

  factory WorkflowInstance.fromJson(Map<String, dynamic> json) =>
      _$WorkflowInstanceFromJson(json);
}
