import 'package:artizen/features/knowledge/data/knowledge_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('KnowledgeSearchResult.fromJson parses matches (tolerant score)', () {
    final json = <String, dynamic>{
      'total': 1,
      'include_drafts': true,
      'matches': [
        {
          'item': {
            'slug': 'remplacer-cartouche-mitigeur',
            'type': 'card',
            'title': 'Remplacer la cartouche',
            'profession': 'plomberie',
            'tags': ['metier:plomberie', 'intervention:remplacer'],
            'status': 'brouillon',
            'confidence': 'C',
            'relations': ['kit-robinetterie'],
            'sources': <String>[],
            'summary': 's',
            'path': 'p',
          },
          'score': '0.8', // string Decimal accepted by the tolerant converter
          'why': 'correspond à mitigeur',
        }
      ],
    };

    final result = KnowledgeSearchResult.fromJson(json);

    expect(result.includeDrafts, isTrue);
    expect(result.matches.single.score, 0.8);
    expect(result.matches.single.item.type, 'card');
    expect(result.matches.single.item.tags, contains('metier:plomberie'));
  });

  test('KnowledgeDetail.fromJson parses item and relations', () {
    final json = <String, dynamic>{
      'item': {
        'slug': 'x',
        'type': 'card',
        'title': 'X',
        'status': 'brouillon',
      },
      'related': [
        {'slug': 'kit-robinetterie', 'type': 'kit', 'title': 'Kit robinetterie', 'status': 'brouillon'},
      ],
    };

    final detail = KnowledgeDetail.fromJson(json);

    expect(detail.item.slug, 'x');
    expect(detail.related.single.type, 'kit');
    // Defaults applied for absent optional fields.
    expect(detail.item.tags, isEmpty);
    expect(detail.item.confidence, '');
  });
}
