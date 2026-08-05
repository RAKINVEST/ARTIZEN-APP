import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/notification_repository.dart';
import 'notification_model.dart';

/// Talks to `/notifications` (`app/notification/router.py`). The engine owns
/// notifications and their dispatch; this only shapes HTTP calls.
class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<AppNotification>> list() async {
    final response = await _dio.get<List<dynamic>>('/notifications');
    return response.data!
        .map((json) => AppNotification.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<AppNotification> get(String id) async {
    final response = await _dio.get<Map<String, dynamic>>('/notifications/$id');
    return AppNotification.fromJson(response.data!);
  }

  @override
  Future<AppNotification> send({
    required String channel,
    required String recipient,
    String subject = '',
    String body = '',
    String templateKey = '',
    Map<String, dynamic> context = const {},
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/notifications',
      data: {
        'channel': channel,
        'recipient': recipient,
        'subject': subject,
        'body': body,
        'template_key': templateKey,
        'context': context,
      },
    );
    return AppNotification.fromJson(response.data!);
  }

  @override
  Future<AppNotification> resend(String id) async {
    final response =
        await _dio.post<Map<String, dynamic>>('/notifications/$id/resend');
    return AppNotification.fromJson(response.data!);
  }

  @override
  Future<List<String>> templates() async {
    final response =
        await _dio.get<List<dynamic>>('/notifications/templates');
    return response.data!.map((e) => e as String).toList();
  }
}

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(ref.watch(dioProvider));
});
