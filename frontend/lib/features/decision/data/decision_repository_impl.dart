import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/decision_repository.dart';
import 'decision_model.dart';

/// Talks to `/decision` (`app/decision/router.py`). No business logic here:
/// interpretation, ranking and explanation all happen server-side; this only
/// shapes HTTP calls and parses their JSON. Nothing is persisted.
class DecisionRepositoryImpl implements DecisionRepository {
  DecisionRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<DecisionResult> propose(String intent) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/decision/propose',
      data: {'intent': intent},
    );
    return DecisionResult.fromJson(response.data!);
  }

  @override
  Future<DecisionIntent> interpret(String intent) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/decision/interpret',
      data: {'intent': intent},
    );
    return DecisionIntent.fromJson(response.data!);
  }
}

final decisionRepositoryProvider = Provider<DecisionRepository>((ref) {
  return DecisionRepositoryImpl(ref.watch(dioProvider));
});
