import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/workflow_repository.dart';
import 'workflow_model.dart';

/// Talks to `/workflow` (`app/workflow/router.py`). The engine owns the
/// process; this only shapes HTTP calls and parses their JSON.
class WorkflowRepositoryImpl implements WorkflowRepository {
  WorkflowRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<WorkflowDefinition>> definitions() async {
    final response = await _dio.get<List<dynamic>>('/workflow/definitions');
    return response.data!
        .map((json) => WorkflowDefinition.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<WorkflowInstance>> listInstances() async {
    final response = await _dio.get<List<dynamic>>('/workflow/instances');
    return response.data!
        .map((json) => WorkflowInstance.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<WorkflowInstance> start(String definitionSlug, Map<String, dynamic> context) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/workflow/instances',
      data: {'definition_slug': definitionSlug, 'context': context},
    );
    return WorkflowInstance.fromJson(response.data!);
  }

  @override
  Future<WorkflowInstance> instance(String id) async {
    final response = await _dio.get<Map<String, dynamic>>('/workflow/instances/$id');
    return WorkflowInstance.fromJson(response.data!);
  }

  @override
  Future<WorkflowInstance> transition(String id, String event) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/workflow/instances/$id/transition',
      data: {'event': event},
    );
    return WorkflowInstance.fromJson(response.data!);
  }
}

final workflowRepositoryProvider = Provider<WorkflowRepository>((ref) {
  return WorkflowRepositoryImpl(ref.watch(dioProvider));
});
