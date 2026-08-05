import 'package:artizen/features/ai_companion/data/companion_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatResponse.fromJson', () {
    test('parses an explainable read answer', () {
      final json = {
        'session_id': 'sess-1',
        'intent': 'search_knowledge',
        'message': 'Voici ce que je trouve : Purge.',
        'explanation': {
          'why': 'Réponse construite à partir du moteur knowledge.',
          'engine': 'knowledge',
          'knowledge_used': ['purge-radiateur'],
          'confidence': 0.8,
          'needs_confirmation': false,
        },
        'sources': [
          {'kind': 'knowledge', 'ref': 'purge-radiateur', 'title': 'Purger un radiateur'},
        ],
        'needs_confirmation': false,
        'questions': <String>[],
        'executed': false,
      };

      final response = ChatResponse.fromJson(json);

      expect(response.intent, 'search_knowledge');
      expect(response.needsConfirmation, false);
      expect(response.explanation.engine, 'knowledge');
      expect(response.explanation.confidence, 0.8);
      expect(response.explanation.knowledgeUsed, ['purge-radiateur']);
      expect(response.sources.single.title, 'Purger un radiateur');
      expect(response.proposedAction, isNull);
    });

    test('parses a proposed action awaiting confirmation', () {
      final json = {
        'session_id': 'sess-2',
        'intent': 'plan_intervention',
        'message': 'Je peux planifier une intervention. Confirmez…',
        'explanation': {'engine': 'orchestration', 'needs_confirmation': true},
        'proposed_action': {
          'tool': 'plan_intervention',
          'engine': 'orchestration',
          'description': 'planifier automatiquement une intervention',
          'params': {'customer_id': 'c1'},
          'missing': <String>[],
        },
        'needs_confirmation': true,
      };

      final response = ChatResponse.fromJson(json);

      expect(response.needsConfirmation, true);
      expect(response.proposedAction, isNotNull);
      expect(response.proposedAction!.tool, 'plan_intervention');
      expect(response.proposedAction!.missing, isEmpty);
    });

    test('parses an executed result payload', () {
      final json = {
        'session_id': 'sess-3',
        'intent': 'plan_intervention',
        'message': "C'est fait.",
        'explanation': {'engine': 'orchestration'},
        'executed': true,
        'result': {'status': 'reussi'},
      };

      final response = ChatResponse.fromJson(json);

      expect(response.executed, true);
      expect(response.result!['status'], 'reussi');
    });
  });
}
