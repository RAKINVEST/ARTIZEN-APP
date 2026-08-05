import 'package:artizen/features/planning/data/planning_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('PlanningEntry.fromJson parses slot, assignment and history', () {
    final json = <String, dynamic>{
      'id': '11111111-1111-1111-1111-111111111111',
      'company_id': '22222222-2222-2222-2222-222222222222',
      'mission_id': null,
      'start_at': '2026-06-15T09:00:00+00:00',
      'end_at': '2026-06-15T11:00:00+00:00',
      'duration_minutes': 120,
      'artisan': 'alice',
      'team': '',
      'vehicle': '',
      'status': 'planifiee',
      'is_terminal': false,
      'history': [
        {'event': 'PlanningCreated', 'actor': 'a', 'detail': '', 'at': '2026-06-15T08:00:00Z'}
      ],
      'created_at': '2026-06-15T08:00:00',
      'updated_at': '2026-06-15T08:00:00',
    };

    final entry = PlanningEntry.fromJson(json);

    expect(entry.artisan, 'alice');
    expect(entry.durationMinutes, 120);
    expect(entry.status, 'planifiee');
    expect(entry.isTerminal, isFalse);
    expect(entry.missionId, isNull);
    expect(entry.endAt.hour, 11);
    expect(entry.history.length, 1);
  });

  test('Availability.fromJson parses conflicts', () {
    final json = <String, dynamic>{
      'available': false,
      'conflicts': [
        {'type': 'artisan_indisponible', 'detail': 'déjà planifié', 'entry_id': 'e1'}
      ],
    };
    final availability = Availability.fromJson(json);
    expect(availability.available, isFalse);
    expect(availability.conflicts.single.type, 'artisan_indisponible');
  });
}
