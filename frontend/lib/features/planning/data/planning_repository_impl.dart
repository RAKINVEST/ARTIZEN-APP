import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/planning_repository.dart';
import 'planning_model.dart';

/// Talks to `/planning` (`app/planning/router.py`). The engine owns the
/// schedule and enforces conflicts; this only shapes HTTP calls.
class PlanningRepositoryImpl implements PlanningRepository {
  PlanningRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<PlanningEntry>> list() async {
    final response = await _dio.get<List<dynamic>>('/planning');
    return response.data!
        .map((json) => PlanningEntry.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PlanningEntry> get(String id) async {
    final response = await _dio.get<Map<String, dynamic>>('/planning/$id');
    return PlanningEntry.fromJson(response.data!);
  }

  @override
  Future<PlanningEntry> create({
    required DateTime startAt,
    required int durationMinutes,
    String? missionId,
    String artisan = '',
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/planning',
      data: {
        'start_at': startAt.toIso8601String(),
        'duration_minutes': durationMinutes,
        'mission_id': ?missionId,
        'artisan': artisan,
      },
    );
    return PlanningEntry.fromJson(response.data!);
  }

  @override
  Future<PlanningEntry> move(String id, DateTime startAt, {int? durationMinutes}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/planning/$id/move',
      data: {'start_at': startAt.toIso8601String(), 'duration_minutes': ?durationMinutes},
    );
    return PlanningEntry.fromJson(response.data!);
  }

  @override
  Future<PlanningEntry> cancel(String id) async {
    final response = await _dio.post<Map<String, dynamic>>('/planning/$id/cancel');
    return PlanningEntry.fromJson(response.data!);
  }

  @override
  Future<PlanningEntry> assignAuto(String id, List<String> candidates) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/planning/$id/assign',
      data: {'auto': true, 'candidates': candidates},
    );
    return PlanningEntry.fromJson(response.data!);
  }

  @override
  Future<Availability> availability(
    DateTime startAt,
    int durationMinutes, {
    String artisan = '',
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/planning/availability',
      queryParameters: {
        'start_at': startAt.toIso8601String(),
        'duration_minutes': durationMinutes,
        'artisan': artisan,
      },
    );
    return Availability.fromJson(response.data!);
  }
}

final planningRepositoryProvider = Provider<PlanningRepository>((ref) {
  return PlanningRepositoryImpl(ref.watch(dioProvider));
});
