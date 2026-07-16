import '../data/quote_suggestion_models.dart';

/// The contract the presentation layer depends on for the AI matching
/// endpoint. A single method: this feature's only job is to turn a
/// free-text description into a *proposal* — creating the quote itself
/// goes through `quotesRepositoryProvider`, unchanged from Étape 6.
abstract class QuoteAssistantRepository {
  Future<QuoteSuggestion> suggest({required String companyId, required String description});
}
