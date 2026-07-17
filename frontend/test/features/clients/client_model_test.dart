import 'package:artizen/features/clients/data/client_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Client', () {
    test('fromJson parses the backend snake_case shape', () {
      final json = {
        'id': 'c1',
        'company_id': 'co1',
        'last_name': 'Dupont',
        'first_name': 'Marie',
        'company_name': null,
        'address': '12 rue des Artisans',
        'phone': '0102030405',
        'email': 'marie@example.com',
        'notes': null,
        'created_at': '2026-01-01T10:00:00Z',
        'updated_at': '2026-01-02T10:00:00Z',
      };

      final client = Client.fromJson(json);

      expect(client.id, 'c1');
      expect(client.companyId, 'co1');
      expect(client.lastName, 'Dupont');
      expect(client.firstName, 'Marie');
      expect(client.companyName, isNull);
      expect(client.phone, '0102030405');
    });

    test('displayName prefers first+last name over company name', () {
      final client = Client(
        id: 'c1',
        companyId: 'co1',
        lastName: 'Dupont',
        firstName: 'Marie',
        companyName: 'Dupont SARL',
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
      );

      expect(client.displayName, 'Marie Dupont');
    });

    test('displayName falls back to company name when no personal name fits', () {
      final client = Client(
        id: 'c1',
        companyId: 'co1',
        lastName: '',
        companyName: 'Dupont SARL',
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
      );

      expect(client.displayName, 'Dupont SARL');
    });
  });

  group('ClientInput', () {
    test('toJson sends null fields explicitly, so a cleared field is cleared', () {
      // This asserted the opposite until it was found to be the cause of a
      // real bug. Omitting nulls only makes sense for a *partial* update,
      // where an absent key means "don't touch" (the backend's
      // exclude_unset). This model is a full form snapshot — the edit form
      // always sends every field — so there is no untouched field to
      // protect, and dropping the null meant an artisan could never clear
      // a wrong email: it silently came back on the next load.
      const input = ClientInput(lastName: 'Martin', phone: '0611223344');

      final json = input.toJson();

      expect(json['last_name'], 'Martin');
      expect(json['phone'], '0611223344');
      expect(json.containsKey('email'), isTrue);
      expect(json['email'], isNull);
    });
  });
}
