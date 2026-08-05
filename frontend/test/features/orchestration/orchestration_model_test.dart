import 'package:artizen/features/orchestration/data/orchestration_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('OrchestrationInstance.fromJson parses plan, timeline and results', () {
    final json = <String, dynamic>{
      'id': '11111111-1111-1111-1111-111111111111',
      'company_id': '22222222-2222-2222-2222-222222222222',
      'correlation_id': 'abc123',
      'plan_kind': 'intervention',
      'status': 'reussi',
      'is_terminal': true,
      'context': {'customer_id': 'c', 'title': 'x'},
      'plan': [
        {'id': 'create_mission', 'engine': 'mission', 'action': 'create_mission'},
        {'id': 'start_workflow', 'engine': 'workflow', 'action': 'start_workflow'},
      ],
      'timeline': [
        {'type': 'step_started', 'step': 'create_mission'},
        {'type': 'step_completed', 'step': 'create_mission', 'attempt': 1},
        {'type': 'orchestration_completed', 'step': ''},
      ],
      'results': {
        'create_mission': {'mission_id': 'm1'},
        'start_workflow': {'workflow_id': 'w1'},
      },
      'created_at': '2026-08-02T10:00:00',
      'updated_at': '2026-08-02T10:00:01',
    };

    final o = OrchestrationInstance.fromJson(json);

    expect(o.planKind, 'intervention');
    expect(o.status, 'reussi');
    expect(o.isTerminal, isTrue);
    expect(o.correlationId, 'abc123');
    expect(o.plan.length, 2);
    expect(o.plan.first['action'], 'create_mission');
    expect(o.timeline.last['type'], 'orchestration_completed');
    expect(o.results['create_mission']['mission_id'], 'm1');
  });
}
