import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/catalog_repository.dart';
import 'catalog_models.dart';

/// Talks to `/catalog/categories` and `/catalog/items`
/// (`app/catalog/router.py` on the backend). No business logic here —
/// pricing, VAT, and the active/inactive rule all live server-side.
class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<CatalogCategory>> listCategories({required String companyId}) async {
    final response = await _dio.get<List<dynamic>>(
      '/catalog/categories',
      queryParameters: {'company_id': companyId},
    );
    return response.data!
        .map((json) => CatalogCategory.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<CatalogCategory> createCategory(
    CatalogCategoryInput input, {
    required String companyId,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/catalog/categories',
      data: {'company_id': companyId, ...input.toJson()},
    );
    return CatalogCategory.fromJson(response.data!);
  }

  @override
  Future<List<CatalogItem>> listItems({
    required String companyId,
    bool activeOnly = false,
    String? query,
    int? offset,
    int? limit,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      '/catalog/items',
      queryParameters: {
        'company_id': companyId,
        'active_only': activeOnly,
        if (query != null && query.isNotEmpty) 'q': query,
        'offset': ?offset,
        'limit': ?limit,
      },
    );
    return response.data!
        .map((json) => CatalogItem.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<CatalogItem> createItem(CatalogItemInput input, {required String companyId}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/catalog/items',
      data: {'company_id': companyId, ...input.toJson()},
    );
    return CatalogItem.fromJson(response.data!);
  }

  @override
  Future<CatalogItem> updateItem(String id, CatalogItemInput input) async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/catalog/items/$id',
      data: input.toJson(),
    );
    return CatalogItem.fromJson(response.data!);
  }

  @override
  Future<CatalogItem> deactivateItem(String id) async {
    final response = await _dio.delete<Map<String, dynamic>>('/catalog/items/$id');
    return CatalogItem.fromJson(response.data!);
  }

  @override
  Future<CatalogItem> reactivateItem(String id) async {
    // A bare {"active": true} body, not a CatalogItemInput: the backend's
    // CatalogItemUpdate is a partial model (every field optional) and
    // applies exclude_unset, so this touches `active` and nothing else.
    // Sending a full item here would risk overwriting fields the caller
    // never meant to change.
    final response = await _dio.put<Map<String, dynamic>>(
      '/catalog/items/$id',
      data: {'active': true},
    );
    return CatalogItem.fromJson(response.data!);
  }
}

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  return CatalogRepositoryImpl(ref.watch(dioProvider));
});
