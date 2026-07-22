import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/quotes_repository.dart';
import 'quote_calculation.dart';
import 'quote_models.dart';
import 'quote_readiness.dart';

/// Talks to `/quotes` (`app/quotes/router.py` on the backend).
class QuotesRepositoryImpl implements QuotesRepository {
  QuotesRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Quote>> list({
    required String companyId,
    List<QuoteStatus>? statuses,
    String? clientId,
    int? offset,
    int? limit,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      '/quotes',
      queryParameters: {
        'company_id': companyId,
        // The wire values, not the French labels — same enum as the backend.
        // A list becomes repeated `?status=` params (Dio's default), which the
        // backend reads as "status IN (...)": one call for draft + sent.
        if (statuses != null && statuses.isNotEmpty)
          'status': [for (final status in statuses) status.name],
        'client_id': ?clientId,
        'offset': ?offset,
        'limit': ?limit,
      },
    );
    return response.data!
        .map((json) => Quote.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Quote> get(String id) async {
    final response = await _dio.get<Map<String, dynamic>>('/quotes/$id');
    return Quote.fromJson(response.data!);
  }

  @override
  Future<Quote> changeStatus(String id, QuoteStatus status) async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/quotes/$id/status',
      // The wire value, not the French label: the backend's enum is
      // 'draft'/'sent'/'accepted'/'refused'.
      data: {'status': status.name},
    );
    return Quote.fromJson(response.data!);
  }

  @override
  Future<Quote> sendByEmail(String id) async {
    final response = await _dio.post<Map<String, dynamic>>('/quotes/$id/send');
    return Quote.fromJson(response.data!);
  }

  @override
  Future<Uint8List> downloadPdf(String id) async {
    // responseType: bytes — the default would try to decode the PDF as
    // JSON and hand back a mangled string.
    final response = await _dio.get<List<int>>(
      '/quotes/$id/pdf',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data!);
  }

  @override
  Future<Uint8List> downloadSamplePdf() async {
    final response = await _dio.get<List<int>>(
      '/quotes/sample-pdf',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data!);
  }

  @override
  Future<void> delete(String id) async {
    await _dio.delete<void>('/quotes/$id');
  }

  @override
  Future<Quote> duplicate(String id) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/quotes/$id/duplicate',
    );
    return Quote.fromJson(response.data!);
  }

  @override
  Future<QuoteReadiness> readiness(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/quotes/$id/readiness',
    );
    return QuoteReadiness.fromJson(response.data!);
  }

  @override
  Future<Quote> create({
    required String companyId,
    required String clientId,
    required List<QuoteLineInput> lines,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/quotes',
      data: {
        'company_id': companyId,
        'client_id': clientId,
        'lines': lines.map((line) => line.toJson()).toList(),
      },
    );
    return Quote.fromJson(response.data!);
  }

  @override
  Future<QuoteCalculation> calculate({
    required List<QuoteLineInput> lines,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/quotes/calculate',
      data: {'lines': lines.map((line) => line.toJson()).toList()},
    );
    return QuoteCalculation.fromJson(response.data!);
  }
}

final quotesRepositoryProvider = Provider<QuotesRepository>((ref) {
  return QuotesRepositoryImpl(ref.watch(dioProvider));
});
