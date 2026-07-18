import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/clients_repository.dart';
import 'client_model.dart';

/// Talks to `POST/GET/PUT/DELETE /clients` (`app/clients/router.py` on the
/// backend). No business logic here — validation, search matching and
/// persistence all happen server-side; this only shapes HTTP calls and
/// parses their JSON.
class ClientsRepositoryImpl implements ClientsRepository {
  ClientsRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Client>> list({
    required String companyId,
    String? query,
    int? offset,
    int? limit,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      '/clients',
      queryParameters: {
        'company_id': companyId,
        if (query != null && query.isNotEmpty) 'q': query,
        'offset': ?offset,
        'limit': ?limit,
      },
    );
    return response.data!
        .map((json) => Client.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Client> get(String id) async {
    final response = await _dio.get<Map<String, dynamic>>('/clients/$id');
    return Client.fromJson(response.data!);
  }

  @override
  Future<Client> create(ClientInput input, {required String companyId}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/clients',
      data: {'company_id': companyId, ...input.toJson()},
    );
    return Client.fromJson(response.data!);
  }

  @override
  Future<Client> update(String id, ClientInput input) async {
    final response = await _dio.put<Map<String, dynamic>>('/clients/$id', data: input.toJson());
    return Client.fromJson(response.data!);
  }

  @override
  Future<void> delete(String id) async {
    await _dio.delete<void>('/clients/$id');
  }
}

final clientsRepositoryProvider = Provider<ClientsRepository>((ref) {
  return ClientsRepositoryImpl(ref.watch(dioProvider));
});
