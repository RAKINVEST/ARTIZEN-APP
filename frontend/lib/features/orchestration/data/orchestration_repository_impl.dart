import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/orchestration_repository.dart';
import 'orchestration_model.dart';

/// Talks to `/orchestrations` (`app/orchestration/router.py`).
class OrchestrationRepositoryImpl implements OrchestrationRepository {
  OrchestrationRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<OrchestrationInstance>> list() async {
    final response = await _dio.get<List<dynamic>>('/orchestrations');
    return response.data!
        .map((json) => OrchestrationInstance.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<OrchestrationInstance> start(String planKind, Map<String, dynamic> context) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/orchestrations',
      data: {'plan_kind': planKind, 'context': context},
    );
    return OrchestrationInstance.fromJson(response.data!);
  }

  @override
  Future<OrchestrationInstance> get(String id) async {
    final response = await _dio.get<Map<String, dynamic>>('/orchestrations/$id');
    return OrchestrationInstance.fromJson(response.data!);
  }

  @override
  Future<OrchestrationInstance> retry(String id) async {
    final response = await _dio.post<Map<String, dynamic>>('/orchestrations/$id/retry');
    return OrchestrationInstance.fromJson(response.data!);
  }
}

final orchestrationRepositoryProvider = Provider<OrchestrationRepository>((ref) {
  return OrchestrationRepositoryImpl(ref.watch(dioProvider));
});
