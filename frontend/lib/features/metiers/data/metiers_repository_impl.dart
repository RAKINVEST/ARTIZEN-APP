import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/metiers_repository.dart';
import 'metiers_models.dart';

class MetiersRepositoryImpl implements MetiersRepository {
  MetiersRepositoryImpl(this._dio);

  final Dio _dio;

  Future<List<CatalogSource>> _list(String path) async {
    final response = await _dio.get<List<dynamic>>(path);
    return response.data!
        .map((json) => CatalogSource.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<CatalogImportResult> _import(String path) async {
    final response = await _dio.post<Map<String, dynamic>>(path);
    return CatalogImportResult.fromJson(response.data!);
  }

  @override
  Future<List<CatalogSource>> listActivities() => _list('/catalog/activities');

  @override
  Future<List<CatalogSource>> listQualifications() => _list('/catalog/qualifications');

  @override
  Future<CatalogImportResult> importActivity(String slug) =>
      _import('/catalog/activities/$slug');

  @override
  Future<CatalogImportResult> importQualification(String slug) =>
      _import('/catalog/qualifications/$slug');

  @override
  Future<void> removeActivity(String slug) async {
    await _dio.delete<void>('/catalog/activities/$slug');
  }

  @override
  Future<void> removeQualification(String slug) async {
    await _dio.delete<void>('/catalog/qualifications/$slug');
  }
}

final metiersRepositoryProvider = Provider<MetiersRepository>((ref) {
  return MetiersRepositoryImpl(ref.watch(dioProvider));
});
