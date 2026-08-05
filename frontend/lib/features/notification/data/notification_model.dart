import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

/// Mirrors the backend's `NotificationRead` (`app/notification/schemas.py`).
/// The Notification Engine owns notifications; this is the read projection with
/// its channel, rendered content, status and append-only history.
@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String companyId,
    required String channel,
    required String recipient,
    @Default('') String subject,
    @Default('') String body,
    required String status,
    @Default('') String templateKey,
    @Default('') String relatedType,
    @Default('') String relatedId,
    @Default(<dynamic>[]) List<dynamic> history,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
