import 'package:artizen/features/notification/data/notification_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppNotification.fromJson', () {
    test('parses a sent notification with its history', () {
      final json = {
        'id': '11111111-1111-1111-1111-111111111111',
        'company_id': '22222222-2222-2222-2222-222222222222',
        'channel': 'email',
        'recipient': 'client@example.com',
        'subject': 'Intervention planifiée',
        'body': 'Votre intervention « Chaudière » est planifiée le 12/03.',
        'status': 'sent',
        'template_key': 'mission_scheduled',
        'related_type': 'mission',
        'related_id': '33333333-3333-3333-3333-333333333333',
        'history': [
          {'event': 'NotificationCreated', 'actor': 'me', 'detail': 'email', 'at': '2026-08-02T10:00:00+00:00'},
          {'event': 'NotificationSent', 'actor': 'me', 'detail': 'client@example.com', 'at': '2026-08-02T10:00:01+00:00'},
        ],
        'created_at': '2026-08-02T10:00:00Z',
        'updated_at': '2026-08-02T10:00:01Z',
      };

      final notif = AppNotification.fromJson(json);

      expect(notif.channel, 'email');
      expect(notif.status, 'sent');
      expect(notif.templateKey, 'mission_scheduled');
      expect(notif.relatedType, 'mission');
      expect(notif.history.length, 2);
      expect((notif.history.last as Map)['event'], 'NotificationSent');
    });

    test('defaults optional string fields to empty', () {
      final json = {
        'id': '11111111-1111-1111-1111-111111111111',
        'company_id': '22222222-2222-2222-2222-222222222222',
        'channel': 'sms',
        'recipient': '+33600000000',
        'status': 'failed',
        'created_at': '2026-08-02T10:00:00Z',
        'updated_at': '2026-08-02T10:00:00Z',
      };

      final notif = AppNotification.fromJson(json);

      expect(notif.subject, '');
      expect(notif.body, '');
      expect(notif.templateKey, '');
      expect(notif.history, isEmpty);
      expect(notif.status, 'failed');
    });
  });
}
