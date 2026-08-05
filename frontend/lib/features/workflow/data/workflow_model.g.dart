// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WfTransitionImpl _$$WfTransitionImplFromJson(Map<String, dynamic> json) =>
    _$WfTransitionImpl(
      event: json['event'] as String,
      source: json['source'] as String,
      target: json['target'] as String,
      requiresValidation: json['requires_validation'] as bool? ?? false,
    );

Map<String, dynamic> _$$WfTransitionImplToJson(_$WfTransitionImpl instance) =>
    <String, dynamic>{
      'event': instance.event,
      'source': instance.source,
      'target': instance.target,
      'requires_validation': instance.requiresValidation,
    };

_$WorkflowDefinitionImpl _$$WorkflowDefinitionImplFromJson(
  Map<String, dynamic> json,
) => _$WorkflowDefinitionImpl(
  slug: json['slug'] as String,
  name: json['name'] as String,
  initialState: json['initial_state'] as String,
  states:
      (json['states'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  terminalStates:
      (json['terminal_states'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  transitions:
      (json['transitions'] as List<dynamic>?)
          ?.map((e) => WfTransition.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <WfTransition>[],
);

Map<String, dynamic> _$$WorkflowDefinitionImplToJson(
  _$WorkflowDefinitionImpl instance,
) => <String, dynamic>{
  'slug': instance.slug,
  'name': instance.name,
  'initial_state': instance.initialState,
  'states': instance.states,
  'terminal_states': instance.terminalStates,
  'transitions': instance.transitions,
};

_$WorkflowInstanceImpl _$$WorkflowInstanceImplFromJson(
  Map<String, dynamic> json,
) => _$WorkflowInstanceImpl(
  id: json['id'] as String,
  companyId: json['company_id'] as String,
  definitionSlug: json['definition_slug'] as String,
  currentState: json['current_state'] as String,
  status: json['status'] as String,
  context:
      json['context'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  history: json['history'] as List<dynamic>? ?? const <dynamic>[],
  availableEvents:
      (json['available_events'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  isTerminal: json['is_terminal'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$WorkflowInstanceImplToJson(
  _$WorkflowInstanceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'company_id': instance.companyId,
  'definition_slug': instance.definitionSlug,
  'current_state': instance.currentState,
  'status': instance.status,
  'context': instance.context,
  'history': instance.history,
  'available_events': instance.availableEvents,
  'is_terminal': instance.isTerminal,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
