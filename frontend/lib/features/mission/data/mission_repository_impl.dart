import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/mission_repository.dart';
import 'mission_model.dart';

/// Talks to `/missions` (`app/mission/router.py`). The engine owns the mission;
/// this only shapes HTTP calls and parses their JSON.
class MissionRepositoryImpl implements MissionRepository {
  MissionRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Mission>> list() async {
    final response = await _dio.get<List<dynamic>>('/missions');
    return response.data!
        .map((json) => Mission.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Mission> create({
    required String customerId,
    String? siteId,
    required String title,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/missions',
      data: {'customer_id': customerId, 'site_id': ?siteId, 'title': title},
    );
    return Mission.fromJson(response.data!);
  }

  @override
  Future<Mission> get(String id) async {
    final response = await _dio.get<Map<String, dynamic>>('/missions/$id');
    return Mission.fromJson(response.data!);
  }

  @override
  Future<Mission> changeStatus(String id, String status) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/missions/$id/status',
      data: {'status': status},
    );
    return Mission.fromJson(response.data!);
  }

  @override
  Future<Mission> addAttachment(
    String id, {
    required String kind,
    String label = '',
    String reference = '',
    String text = '',
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/missions/$id/attachments',
      data: {'kind': kind, 'label': label, 'reference': reference, 'text': text},
    );
    return Mission.fromJson(response.data!);
  }
}

final missionRepositoryProvider = Provider<MissionRepository>((ref) {
  return MissionRepositoryImpl(ref.watch(dioProvider));
});
