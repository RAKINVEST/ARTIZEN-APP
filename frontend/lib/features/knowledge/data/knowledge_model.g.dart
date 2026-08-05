// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KnowledgeItemImpl _$$KnowledgeItemImplFromJson(
  Map<String, dynamic> json,
) => _$KnowledgeItemImpl(
  slug: json['slug'] as String,
  type: json['type'] as String,
  title: json['title'] as String,
  profession: json['profession'] as String? ?? '',
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  status: json['status'] as String? ?? 'brouillon',
  confidence: json['confidence'] as String? ?? '',
  relations:
      (json['relations'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  sources:
      (json['sources'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  summary: json['summary'] as String? ?? '',
  path: json['path'] as String? ?? '',
);

Map<String, dynamic> _$$KnowledgeItemImplToJson(_$KnowledgeItemImpl instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'type': instance.type,
      'title': instance.title,
      'profession': instance.profession,
      'tags': instance.tags,
      'status': instance.status,
      'confidence': instance.confidence,
      'relations': instance.relations,
      'sources': instance.sources,
      'summary': instance.summary,
      'path': instance.path,
    };

_$KnowledgeMatchImpl _$$KnowledgeMatchImplFromJson(Map<String, dynamic> json) =>
    _$KnowledgeMatchImpl(
      item: KnowledgeItem.fromJson(json['item'] as Map<String, dynamic>),
      score: _numFromJson(json['score']),
      why: json['why'] as String,
    );

Map<String, dynamic> _$$KnowledgeMatchImplToJson(
  _$KnowledgeMatchImpl instance,
) => <String, dynamic>{
  'item': instance.item,
  'score': instance.score,
  'why': instance.why,
};

_$KnowledgeSearchResultImpl _$$KnowledgeSearchResultImplFromJson(
  Map<String, dynamic> json,
) => _$KnowledgeSearchResultImpl(
  total: (json['total'] as num?)?.toInt() ?? 0,
  includeDrafts: json['include_drafts'] as bool,
  matches:
      (json['matches'] as List<dynamic>?)
          ?.map((e) => KnowledgeMatch.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <KnowledgeMatch>[],
);

Map<String, dynamic> _$$KnowledgeSearchResultImplToJson(
  _$KnowledgeSearchResultImpl instance,
) => <String, dynamic>{
  'total': instance.total,
  'include_drafts': instance.includeDrafts,
  'matches': instance.matches,
};

_$KnowledgeDetailImpl _$$KnowledgeDetailImplFromJson(
  Map<String, dynamic> json,
) => _$KnowledgeDetailImpl(
  item: KnowledgeItem.fromJson(json['item'] as Map<String, dynamic>),
  related:
      (json['related'] as List<dynamic>?)
          ?.map((e) => KnowledgeItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <KnowledgeItem>[],
);

Map<String, dynamic> _$$KnowledgeDetailImplToJson(
  _$KnowledgeDetailImpl instance,
) => <String, dynamic>{'item': instance.item, 'related': instance.related};
