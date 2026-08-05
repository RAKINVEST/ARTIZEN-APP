import '../data/notification_model.dart';

/// The contract the presentation layer depends on.
abstract class NotificationRepository {
  Future<List<AppNotification>> list();
  Future<AppNotification> get(String id);
  Future<AppNotification> send({
    required String channel,
    required String recipient,
    String subject,
    String body,
    String templateKey,
    Map<String, dynamic> context,
  });
  Future<AppNotification> resend(String id);
  Future<List<String>> templates();
}
