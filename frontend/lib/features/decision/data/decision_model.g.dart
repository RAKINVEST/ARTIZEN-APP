// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DecisionIntentImpl _$$DecisionIntentImplFromJson(Map<String, dynamic> json) =>
    _$DecisionIntentImpl(
      verb: json['verb'] as String,
      target: json['target'] as String,
      raw: json['raw'] as String,
    );

Map<String, dynamic> _$$DecisionIntentImplToJson(
  _$DecisionIntentImpl instance,
) => <String, dynamic>{
  'verb': instance.verb,
  'target': instance.target,
  'raw': instance.raw,
};

_$DecisionProposalElementImpl _$$DecisionProposalElementImplFromJson(
  Map<String, dynamic> json,
) => _$DecisionProposalElementImpl(
  slug: json['slug'] as String,
  type: json['type'] as String,
  title: json['title'] as String,
  reason: json['reason'] as String,
  score: _numFromJson(json['score']),
  confidence: json['confidence'] as String? ?? '',
  sources:
      (json['sources'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  relations:
      (json['relations'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$$DecisionProposalElementImplToJson(
  _$DecisionProposalElementImpl instance,
) => <String, dynamic>{
  'slug': instance.slug,
  'type': instance.type,
  'title': instance.title,
  'reason': instance.reason,
  'score': instance.score,
  'confidence': instance.confidence,
  'sources': instance.sources,
  'relations': instance.relations,
};

_$DecisionProposalImpl _$$DecisionProposalImplFromJson(
  Map<String, dynamic> json,
) => _$DecisionProposalImpl(
  elements:
      (json['elements'] as List<dynamic>?)
          ?.map(
            (e) => DecisionProposalElement.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <DecisionProposalElement>[],
  comment: json['comment'] as String? ?? '',
);

Map<String, dynamic> _$$DecisionProposalImplToJson(
  _$DecisionProposalImpl instance,
) => <String, dynamic>{
  'elements': instance.elements,
  'comment': instance.comment,
};

_$DecisionExplanationItemImpl _$$DecisionExplanationItemImplFromJson(
  Map<String, dynamic> json,
) => _$DecisionExplanationItemImpl(
  subject: json['subject'] as String,
  why: json['why'] as String,
  basis: json['basis'] as String,
  confidence: json['confidence'] as String? ?? '',
);

Map<String, dynamic> _$$DecisionExplanationItemImplToJson(
  _$DecisionExplanationItemImpl instance,
) => <String, dynamic>{
  'subject': instance.subject,
  'why': instance.why,
  'basis': instance.basis,
  'confidence': instance.confidence,
};

_$DecisionExplanationImpl _$$DecisionExplanationImplFromJson(
  Map<String, dynamic> json,
) => _$DecisionExplanationImpl(
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => DecisionExplanationItem.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <DecisionExplanationItem>[],
);

Map<String, dynamic> _$$DecisionExplanationImplToJson(
  _$DecisionExplanationImpl instance,
) => <String, dynamic>{'items': instance.items};

_$DecisionResultImpl _$$DecisionResultImplFromJson(
  Map<String, dynamic> json,
) => _$DecisionResultImpl(
  intent: DecisionIntent.fromJson(json['intent'] as Map<String, dynamic>),
  proposal: DecisionProposal.fromJson(json['proposal'] as Map<String, dynamic>),
  explanation: DecisionExplanation.fromJson(
    json['explanation'] as Map<String, dynamic>,
  ),
  confidence: _numFromJson(json['confidence']),
  needsConfirmation: json['needs_confirmation'] as bool,
  questions:
      (json['questions'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$$DecisionResultImplToJson(
  _$DecisionResultImpl instance,
) => <String, dynamic>{
  'intent': instance.intent,
  'proposal': instance.proposal,
  'explanation': instance.explanation,
  'confidence': instance.confidence,
  'needs_confirmation': instance.needsConfirmation,
  'questions': instance.questions,
};
