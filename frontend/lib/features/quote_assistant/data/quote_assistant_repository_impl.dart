import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart';
import '../domain/quote_assistant_repository.dart';
import 'quote_suggestion_models.dart';

/// Talks to `POST /quote-assistant/suggest` (`app/quote_assistant/router.py`
/// on the backend). No business logic here — matching, validation and
/// scoring all live server-side (`QuoteAssistantService`).
class QuoteAssistantRepositoryImpl implements QuoteAssistantRepository {
  QuoteAssistantRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<QuoteSuggestion> suggest({
    required String companyId,
    required String description,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/quote-assistant/suggest',
      data: {'company_id': companyId, 'description': description},
    );
    return QuoteSuggestion.fromJson(response.data!);
  }
}

final quoteAssistantRepositoryProvider = Provider<QuoteAssistantRepository>((ref) {
  return QuoteAssistantRepositoryImpl(ref.watch(dioProvider));
});
