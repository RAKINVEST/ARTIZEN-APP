import 'package:artizen/features/workflow/data/workflow_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('WorkflowInstance.fromJson parses state, history and available events', () {
    final json = <String, dynamic>{
      'id': '11111111-1111-1111-1111-111111111111',
      'company_id': '22222222-2222-2222-2222-222222222222',
      'definition_slug': 'intervention',
      'current_state': 'planifiee',
      'status': 'running',
      'context': {'intent': 'remplacer un chauffe-eau'},
      'history': [
        {'event': 'start', 'from': '', 'to': 'proposee', 'actor': 'a', 'at': '2026-08-02T10:00:00Z'},
        {'event': 'planifier', 'from': 'proposee', 'to': 'planifiee', 'actor': 'a', 'at': '2026-08-02T10:01:00Z'},
      ],
      'available_events': ['demarrer', 'annuler'],
      'is_terminal': false,
      'created_at': '2026-08-02T10:00:00',
      'updated_at': '2026-08-02T10:01:00',
    };

    final wf = WorkflowInstance.fromJson(json);

    expect(wf.definitionSlug, 'intervention');
    expect(wf.currentState, 'planifiee');
    expect(wf.status, 'running');
    expect(wf.isTerminal, isFalse);
    expect(wf.availableEvents, contains('demarrer'));
    expect(wf.history.length, 2);
    expect(wf.history.last['to'], 'planifiee');
    expect(wf.context['intent'], 'remplacer un chauffe-eau');
  });

  test('WfTransition.fromJson parses the validation flag', () {
    final t = WfTransition.fromJson({
      'event': 'planifier',
      'source': 'proposee',
      'target': 'planifiee',
      'requires_validation': true,
    });
    expect(t.requiresValidation, isTrue);
  });
}
