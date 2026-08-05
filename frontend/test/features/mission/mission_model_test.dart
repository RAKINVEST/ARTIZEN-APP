import 'package:artizen/features/mission/data/mission_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Mission.fromJson parses progress, timeline and attachments', () {
    final json = <String, dynamic>{
      'id': '11111111-1111-1111-1111-111111111111',
      'company_id': '22222222-2222-2222-2222-222222222222',
      'customer_id': '33333333-3333-3333-3333-333333333333',
      'site_id': null,
      'workflow_instance_id': null,
      'title': 'Remplacement chauffe-eau',
      'status': 'en_cours',
      'progress': 60,
      'is_terminal': false,
      'attachments': [
        {'kind': 'note', 'label': '', 'reference': '', 'text': 'RAS', 'at': '2026-08-02T10:00:00Z'}
      ],
      'timeline': [
        {'event': 'created', 'actor': 'a', 'detail': 'x', 'at': '2026-08-02T09:00:00Z'},
        {'event': 'status:en_cours', 'actor': 'a', 'detail': 'ouverte->en_cours', 'at': '2026-08-02T10:00:00Z'},
      ],
      'created_at': '2026-08-02T09:00:00',
      'updated_at': '2026-08-02T10:00:00',
    };

    final mission = Mission.fromJson(json);

    expect(mission.title, 'Remplacement chauffe-eau');
    expect(mission.status, 'en_cours');
    expect(mission.progress, 60);
    expect(mission.isTerminal, isFalse);
    expect(mission.siteId, isNull);
    expect(mission.attachments.length, 1);
    expect(mission.attachments.first['kind'], 'note');
    expect(mission.timeline.length, 2);
    expect(mission.timeline.last['event'], 'status:en_cours');
  });
}
