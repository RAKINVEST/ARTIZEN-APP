import 'package:artizen/features/decision/data/decision_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DecisionResult.fromJson parses a knowledge-sourced proposal', () {
    // `score` arrives as a string (Decimal-safe) — the tolerant converter
    // accepts it. Proposal elements carry confidence, sources and relations
    // straight from the Knowledge Engine.
    final json = <String, dynamic>{
      'intent': {'verb': 'remplacer', 'target': 'mitigeur', 'raw': 'je remplace un mitigeur'},
      'proposal': {
        'elements': [
          {
            'slug': 'remplacer-cartouche-mitigeur',
            'type': 'card',
            'title': 'Remplacer la cartouche',
            'reason': 'correspond à mitigeur',
            'score': '0.8',
            'confidence': 'B',
            'sources': ['DTU 60.1'],
            'relations': ['kit-robinetterie'],
          }
        ],
        'comment': 'Voici ce que je trouve.',
      },
      'explanation': {
        'items': [
          {'subject': 'Remplacer la cartouche', 'why': 'w', 'basis': 'b', 'confidence': 'B'}
        ],
      },
      'confidence': 0.8,
      'needs_confirmation': false,
      'questions': <String>[],
    };

    final result = DecisionResult.fromJson(json);

    final element = result.proposal.elements.single;
    expect(element.type, 'card');
    expect(element.slug, 'remplacer-cartouche-mitigeur');
    expect(element.score, 0.8); // string "0.8" coerced
    expect(element.confidence, 'B'); // confidence exploited
    expect(element.sources, contains('DTU 60.1')); // sources exploited
    expect(element.relations, contains('kit-robinetterie')); // relations exploited
    expect(result.needsConfirmation, isFalse);
  });

  test('DecisionResult.fromJson keeps questions when confirmation is needed', () {
    final json = <String, dynamic>{
      'intent': {'verb': '', 'target': 'ovni', 'raw': 'ovni'},
      'proposal': {'elements': <dynamic>[], 'comment': 'precision'},
      'explanation': {'items': <dynamic>[]},
      'confidence': 0.0,
      'needs_confirmation': true,
      'questions': ['Quelle action souhaitez-vous ?'],
    };

    final result = DecisionResult.fromJson(json);

    expect(result.needsConfirmation, isTrue);
    expect(result.proposal.elements, isEmpty);
    expect(result.questions, isNotEmpty);
  });
}
