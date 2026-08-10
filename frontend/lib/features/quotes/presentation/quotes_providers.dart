import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/pagination/paged_list.dart';
import '../../../core/pagination/paged_list_notifier.dart';
import '../../../shared/providers/current_company_provider.dart';
import '../data/quote_models.dart';
import '../data/quote_readiness.dart';
import '../data/quotes_repository_impl.dart';

/// The view selected on the devis list — the same buckets as the dashboard's
/// cards, mirroring the quote life cycle. A thin semantic layer over
/// [QuoteStatus]: it also names the screen ([title]) and its chips
/// ([chipLabel]). Note "Devis" ([all]) is **not** literally every status — it
/// is the devis proper (sent and beyond); brouillons and en-attente live in
/// their own views and never inflate that total.
enum QuotesFilter {
  all,
  brouillon,
  pending,
  accepted,
  refused;

  /// The AppBar title for this view.
  String get title => switch (this) {
    QuotesFilter.all => 'Devis',
    QuotesFilter.brouillon => 'Devis en brouillon',
    QuotesFilter.pending => 'Devis en attente',
    QuotesFilter.accepted => 'Devis validés',
    QuotesFilter.refused => 'Devis refusés',
  };

  /// The (shorter) chip label.
  String get chipLabel => switch (this) {
    QuotesFilter.all => 'Tous',
    QuotesFilter.brouillon => 'Brouillon',
    QuotesFilter.pending => 'En attente',
    QuotesFilter.accepted => 'Validés',
    QuotesFilter.refused => 'Refusés',
  };

  /// The statuses this view fetches server-side, via a repeated `?status=`
  /// (backend `IN`). "Devis" = sent + accepted + refused (a brouillon or an
  /// en-attente is not yet a devis); the rest map to a single status.
  List<QuoteStatus> get statuses => switch (this) {
    QuotesFilter.all => const [
      QuoteStatus.sent,
      QuoteStatus.accepted,
      QuoteStatus.refused,
    ],
    QuotesFilter.brouillon => const [QuoteStatus.draft],
    QuotesFilter.pending => const [QuoteStatus.pending],
    QuotesFilter.accepted => const [QuoteStatus.accepted],
    QuotesFilter.refused => const [QuoteStatus.refused],
  };
}

/// The active view on the devis list. Watched by [QuotesNotifier] so picking a
/// chip — or landing from a dashboard card — re-runs the fetch, and by the
/// screen so the AppBar title follows the view. A plain provider (not notifier
/// state) so both can watch it reactively.
final quotesFilterProvider = StateProvider<QuotesFilter>(
  (ref) => QuotesFilter.all,
);

/// The client filter selected on the devis list (`null` = all clients).
final quotesClientFilterProvider = StateProvider<String?>((ref) => null);

/// The devis list: server-side status/client filters + offset/limit paging.
/// Changing a filter re-runs `build` (via [watchDependencies]); with
/// `skipLoadingOnReload` in `PagedListView`, the current rows stay on screen
/// under a discrete indicator instead of flashing a full-page spinner.
class QuotesNotifier extends PagedListNotifier<Quote> {
  QuotesFilter _filter = QuotesFilter.all;
  String? _clientId;

  @override
  Future<String> watchDependencies() {
    // Read filters synchronously (before the first await) so build tracks
    // both providers and re-runs whenever either changes.
    _filter = ref.watch(quotesFilterProvider);
    _clientId = ref.watch(quotesClientFilterProvider);
    return ref.watch(currentCompanyIdProvider.future);
  }

  @override
  Future<List<Quote>> fetchPage(
    String companyId, {
    required int offset,
    required int limit,
  }) {
    return ref
        .read(quotesRepositoryProvider)
        .list(
          companyId: companyId,
          statuses: _filter.statuses,
          clientId: _clientId,
          offset: offset,
          limit: limit,
        );
  }

  /// Returns the created quote (with its backend-computed totals) so the
  /// caller can navigate straight to its detail screen.
  Future<Quote> createQuote({
    required String clientId,
    required List<QuoteLineInput> lines,
    String? discountType,
    String? discountValue,
    String? depositType,
    String? depositValue,
  }) async {
    final companyId = await ref.read(currentCompanyIdProvider.future);
    final quote = await ref
        .read(quotesRepositoryProvider)
        .create(
          companyId: companyId,
          clientId: clientId,
          lines: lines,
          discountType: discountType,
          discountValue: discountValue,
          depositType: depositType,
          depositValue: depositValue,
        );
    await reload();
    return quote;
  }

  /// Moves the quote along its commercial life.
  ///
  /// Invalidates the single-quote provider too: the detail screen watches
  /// `quoteByIdProvider`, and refreshing only the list would leave the
  /// artisan looking at the status they just changed away from.
  Future<Quote> changeStatus(String id, QuoteStatus status) async {
    final quote = await ref
        .read(quotesRepositoryProvider)
        .changeStatus(id, status);
    ref.invalidate(quoteByIdProvider(id));
    await reload();
    return quote;
  }

  /// Sends the quote to its client by email (PDF attached) and marks it sent.
  /// Like [changeStatus], invalidates the single-quote provider so the detail
  /// screen reflects the new status on return.
  Future<Quote> sendByEmail(String id) async {
    final quote = await ref.read(quotesRepositoryProvider).sendByEmail(id);
    ref.invalidate(quoteByIdProvider(id));
    await reload();
    return quote;
  }

  Future<void> deleteQuote(String id) async {
    await ref.read(quotesRepositoryProvider).delete(id);
    await reload();
  }

  /// Duplicates a quote into a new draft and returns it, so the caller can
  /// navigate straight to the copy the artisan will now edit.
  Future<Quote> duplicateQuote(String id) async {
    final copy = await ref.read(quotesRepositoryProvider).duplicate(id);
    await reload();
    return copy;
  }
}

final quotesNotifierProvider =
    AsyncNotifierProvider<QuotesNotifier, PagedList<Quote>>(QuotesNotifier.new);

final quoteByIdProvider = FutureProvider.family<Quote, String>((ref, id) {
  return ref.watch(quotesRepositoryProvider).get(id);
});

/// The pre-flight verdict for a single quote — powers the "Prêt à émettre / À
/// compléter" badge and the readiness gate. `autoDispose` so it re-checks each
/// time a detail screen is opened; the gate also refreshes it when an emit is
/// attempted, so fixing an issue elsewhere is reflected on return.
final quoteReadinessProvider = FutureProvider.autoDispose
    .family<QuoteReadiness, String>((ref, id) {
      return ref.watch(quotesRepositoryProvider).readiness(id);
    });

/// The rendered PDF bytes of a quote, for the in-app preview. Same endpoint
/// (and therefore the exact same document) the "Télécharger" action sends —
/// available in every status, drafts included, since the backend renders on
/// demand and never needs the quote to be sent first.
final quotePdfProvider = FutureProvider.family<Uint8List, String>((ref, id) {
  return ref.watch(quotesRepositoryProvider).downloadPdf(id);
});

/// The demo-quote PDF rendered with the company's current branding — powers
/// the "aperçu du rendu" after a template import and from Paramètres. Not a
/// `.family`: there is one sample per company, and it should re-fetch each
/// time it is opened so a just-imported logo shows immediately.
final quoteSamplePdfProvider = FutureProvider.autoDispose<Uint8List>((ref) {
  return ref.watch(quotesRepositoryProvider).downloadSamplePdf();
});
