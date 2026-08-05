import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/companion_repository.dart';
import 'companion_model.dart';

/// Talks to `/ai` (`app/ai_companion/router.py`). The Companion orchestrates the
/// engines server-side; this only shapes HTTP calls.
class CompanionRepositoryImpl implements CompanionRepository {
  CompanionRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<ChatResponse> chat(
    String message, {
    String? sessionId,
    Map<String, dynamic>? params,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/ai/chat',
      data: {'message': message, 'session_id': ?sessionId, 'params': params ?? {}},
    );
    return ChatResponse.fromJson(response.data!);
  }

  @override
  Future<ChatResponse> continueConversation(
    String sessionId,
    String message, {
    Map<String, dynamic>? params,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/ai/continue',
      data: {'session_id': sessionId, 'message': message, 'params': params ?? {}},
    );
    return ChatResponse.fromJson(response.data!);
  }

  @override
  Future<ChatResponse> confirm(String sessionId) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/ai/confirm',
      data: {'session_id': sessionId},
    );
    return ChatResponse.fromJson(response.data!);
  }

  @override
  Future<ChatResponse> cancel(String sessionId) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/ai/cancel',
      data: {'session_id': sessionId},
    );
    return ChatResponse.fromJson(response.data!);
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    await _dio.delete<void>('/ai/session', queryParameters: {'session_id': sessionId});
  }
}

final companionRepositoryProvider = Provider<CompanionRepository>((ref) {
  return CompanionRepositoryImpl(ref.watch(dioProvider));
});
