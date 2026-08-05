import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/sites_repository.dart';
import 'site_model.dart';

/// Talks to `/sites` (`app/sites/router.py`). No business logic here:
/// tenant scoping, the "customer must belong to this company" check and the
/// archive transition all happen server-side; this only shapes HTTP calls
/// and parses their JSON.
class SitesRepositoryImpl implements SitesRepository {
  SitesRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Site>> list({
    String? customerId,
    bool includeArchived = false,
    int? offset,
    int? limit,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      '/sites',
      queryParameters: {
        'customer_id': ?customerId,
        if (includeArchived) 'include_archived': true,
        'offset': ?offset,
        'limit': ?limit,
      },
    );
    return response.data!
        .map((json) => Site.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Site> get(String id) async {
    final response = await _dio.get<Map<String, dynamic>>('/sites/$id');
    return Site.fromJson(response.data!);
  }

  @override
  Future<Site> create(SiteCreateInput input, {required String companyId}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/sites',
      data: {'company_id': companyId, ...input.toJson()},
    );
    return Site.fromJson(response.data!);
  }

  @override
  Future<Site> update(String id, SiteUpdateInput input) async {
    final response =
        await _dio.put<Map<String, dynamic>>('/sites/$id', data: input.toJson());
    return Site.fromJson(response.data!);
  }

  @override
  Future<Site> archive(String id) async {
    final response = await _dio.post<Map<String, dynamic>>('/sites/$id/archive');
    return Site.fromJson(response.data!);
  }
}

final sitesRepositoryProvider = Provider<SitesRepository>((ref) {
  return SitesRepositoryImpl(ref.watch(dioProvider));
});
