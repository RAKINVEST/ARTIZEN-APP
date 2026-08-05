import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';

import '../../../core/api/dio_client.dart';
import '../domain/quote_extraction_repository.dart';
import 'extracted_quote.dart';

/// Talks to `/document-analysis` (upload/process, reused from V1) and the V2
/// `/quote-extraction` endpoints (`app/quote_extraction/router.py`). No business
/// logic here: extraction happens server-side, and the imported PDF is the only
/// source of truth.
class QuoteExtractionRepositoryImpl implements QuoteExtractionRepository {
  QuoteExtractionRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<String> uploadQuotePdf({
    required String companyId,
    required String filename,
    required List<int> bytes,
  }) async {
    final formData = FormData.fromMap({
      'document_type': 'quote',
      'file': MultipartFile.fromBytes(
        bytes,
        filename: filename,
        contentType: MediaType('application', 'pdf'),
      ),
    });
    final response = await _dio.post<Map<String, dynamic>>(
      '/document-analysis/upload',
      data: formData,
    );
    return response.data!['id'] as String;
  }

  @override
  Future<void> processAnalysis(String analysisId) async {
    await _dio.post<Map<String, dynamic>>(
      '/document-analysis/$analysisId/process',
    );
  }

  @override
  Future<ExtractedQuote> extract(String analysisId) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/quote-extraction/$analysisId/extract',
    );
    return ExtractedQuote.fromJson(response.data!);
  }

  @override
  Future<Uint8List> renderReproduction(String analysisId) async {
    final response = await _dio.post<List<int>>(
      '/quote-extraction/$analysisId/preview-pdf',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data!);
  }
}

final quoteExtractionRepositoryProvider = Provider<QuoteExtractionRepository>((
  ref,
) {
  return QuoteExtractionRepositoryImpl(ref.watch(dioProvider));
});
