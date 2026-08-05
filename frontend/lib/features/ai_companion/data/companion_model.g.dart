// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatResponseImpl _$$ChatResponseImplFromJson(Map<String, dynamic> json) =>
    _$ChatResponseImpl(
      sessionId: json['session_id'] as String,
      intent: json['intent'] as String,
      message: json['message'] as String,
      explanation: Explanation.fromJson(
        json['explanation'] as Map<String, dynamic>,
      ),
      sources:
          (json['sources'] as List<dynamic>?)
              ?.map((e) => SourceRef.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SourceRef>[],
      proposedAction: json['proposed_action'] == null
          ? null
          : ProposedAction.fromJson(
              json['proposed_action'] as Map<String, dynamic>,
            ),
      needsConfirmation: json['needs_confirmation'] as bool? ?? false,
      questions:
          (json['questions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      executed: json['executed'] as bool? ?? false,
      result: json['result'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ChatResponseImplToJson(_$ChatResponseImpl instance) =>
    <String, dynamic>{
      'session_id': instance.sessionId,
      'intent': instance.intent,
      'message': instance.message,
      'explanation': instance.explanation,
      'sources': instance.sources,
      if (instance.proposedAction case final value?) 'proposed_action': value,
      'needs_confirmation': instance.needsConfirmation,
      'questions': instance.questions,
      'executed': instance.executed,
      if (instance.result case final value?) 'result': value,
    };

_$ExplanationImpl _$$ExplanationImplFromJson(Map<String, dynamic> json) =>
    _$ExplanationImpl(
      why: json['why'] as String? ?? '',
      engine: json['engine'] as String? ?? 'companion',
      knowledgeUsed:
          (json['knowledge_used'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0,
      needsConfirmation: json['needs_confirmation'] as bool? ?? false,
    );

Map<String, dynamic> _$$ExplanationImplToJson(_$ExplanationImpl instance) =>
    <String, dynamic>{
      'why': instance.why,
      'engine': instance.engine,
      'knowledge_used': instance.knowledgeUsed,
      'confidence': instance.confidence,
      'needs_confirmation': instance.needsConfirmation,
    };

_$ProposedActionImpl _$$ProposedActionImplFromJson(Map<String, dynamic> json) =>
    _$ProposedActionImpl(
      tool: json['tool'] as String,
      engine: json['engine'] as String,
      description: json['description'] as String? ?? '',
      params: json['params'] as Map<String, dynamic>?,
      missing:
          (json['missing'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$ProposedActionImplToJson(
  _$ProposedActionImpl instance,
) => <String, dynamic>{
  'tool': instance.tool,
  'engine': instance.engine,
  'description': instance.description,
  if (instance.params case final value?) 'params': value,
  'missing': instance.missing,
};

_$SourceRefImpl _$$SourceRefImplFromJson(Map<String, dynamic> json) =>
    _$SourceRefImpl(
      kind: json['kind'] as String,
      ref: json['ref'] as String? ?? '',
      title: json['title'] as String? ?? '',
    );

Map<String, dynamic> _$$SourceRefImplToJson(_$SourceRefImpl instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'ref': instance.ref,
      'title': instance.title,
    };
