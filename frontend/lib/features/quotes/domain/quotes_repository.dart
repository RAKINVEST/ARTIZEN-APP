import 'dart:typed_data';

import '../data/quote_calculation.dart';
import '../data/quote_models.dart';
import '../data/quote_readiness.dart';

/// The contract the presentation layer depends on. Creation takes the
/// client and the chosen (catalog item, quantity) pairs — the repository
/// itself does no math; the backend's `QuoteCalculator` is the only place
/// HT/VAT/TTC are computed.
abstract class QuotesRepository {
  /// [statuses]/[clientId] map to the server-side filters (`?status=` — repeat
  /// it to match any of several, e.g. draft **or** sent for "en attente" —
  /// and `?client_id=`); [offset]/[limit] page the result. All optional so a
  /// plain count call still works unchanged. An empty/null [statuses] is "all".
  Future<List<Quote>> list({
    required String companyId,
    List<QuoteStatus>? statuses,
    String? clientId,
    int? offset,
    int? limit,
  });
  Future<Quote> get(String id);
  Future<Quote> create({
    required String companyId,
    required String clientId,
    required List<QuoteLineInput> lines,
  });

  /// Prices the given (catalog item, quantity) pairs **without persisting
  /// anything** — no quote, no number burned. Feeds the guided assistant's
  /// live total while the artisan edits. The backend is the sole authority on
  /// the amounts; company scoping comes from the JWT, not the payload.
  Future<QuoteCalculation> calculate({required List<QuoteLineInput> lines});

  /// Moves the quote along its commercial life. The backend refuses an
  /// illegal move with a 409 — this app mirrors the rules in
  /// [QuoteStatus.nextStates] only to avoid *offering* a button that would
  /// be refused, never to decide in its place.
  Future<Quote> changeStatus(String id, QuoteStatus status);

  /// Sends the quote to its client by email (the PDF attached) and marks it
  /// sent — the "Envoyer par e-mail" action. Only a validated ("en attente")
  /// quote can be sent, and only to a client that carries an email address
  /// (the backend answers 422 otherwise). Returns the now-sent quote.
  Future<Quote> sendByEmail(String id);

  /// The document the artisan sends. Returns the raw PDF bytes rather than
  /// a URL: the endpoint needs the `Authorization` header, so a plain link
  /// would 403. Fetching through Dio is what makes the interceptor apply.
  Future<Uint8List> downloadPdf(String id);

  /// A demo quote rendered with the company's current branding — the
  /// "aperçu du rendu" shown after importing a template, so the artisan sees
  /// their logo, colours and identity applied without creating a real quote.
  Future<Uint8List> downloadSamplePdf();

  /// Deletes a quote. The backend only allows it while the quote is a
  /// draft (409 otherwise) — deleting and recreating is how a mistyped
  /// quote gets corrected, since a quote has no update path.
  Future<void> delete(String id);

  /// Creates a new draft copying an existing quote's lines. The edit path
  /// a quote does not otherwise have: to revise a sent or refused quote,
  /// the artisan duplicates it and edits the copy. Returns the new draft.
  Future<Quote> duplicate(String id);

  /// Pre-flight check before emitting a quote (download / print / send):
  /// asks the backend whether every legal/commercial requirement is met and,
  /// if not, what is missing and where to fix it. The backend is the sole
  /// authority — this app only reads the verdict and guides the artisan.
  Future<QuoteReadiness> readiness(String id);
}
