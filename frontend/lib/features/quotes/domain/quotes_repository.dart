import '../data/quote_models.dart';

/// The contract the presentation layer depends on. Creation takes the
/// client and the chosen (catalog item, quantity) pairs — the repository
/// itself does no math; the backend's `QuoteCalculator` is the only place
/// HT/VAT/TTC are computed.
abstract class QuotesRepository {
  Future<List<Quote>> list({required String companyId});
  Future<Quote> get(String id);
  Future<Quote> create({
    required String companyId,
    required String clientId,
    required List<QuoteLineInput> lines,
  });
}
