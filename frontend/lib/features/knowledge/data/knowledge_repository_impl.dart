import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/knowledge_repository.dart';
import 'knowledge_model.dart';

/// Talks to `/knowledge` (`app/knowledge/router.py`). Read-only: it only shapes
/// HTTP calls and parses JSON; searching/ranking happen server-side.
class KnowledgeRepositoryImpl implements KnowledgeRepository {
  KnowledgeRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<KnowledgeSearchResult> search({
    required String q,
    String? metier,
    bool includeDrafts = false,
    int limit = 20,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/knowledge/search',
      queryParameters: {
        if (q.isNotEmpty) 'q': q,
        'metier': ?metier,
        if (includeDrafts) 'include_drafts': true,
        'limit': limit,
      },
    );
    return KnowledgeSearchResult.fromJson(response.data!);
  }

  @override
  Future<KnowledgeDetail> detail(String type, String slug) async {
    final response = await _dio.get<Map<String, dynamic>>('/knowledge/$type/$slug');
    return KnowledgeDetail.fromJson(response.data!);
  }
}

final knowledgeRepositoryProvider = Provider<KnowledgeRepository>((ref) {
  return KnowledgeRepositoryImpl(ref.watch(dioProvider));
});
