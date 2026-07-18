import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/pagination/paged_list.dart';
import '../../../core/pagination/paged_list_notifier.dart';
import '../../../shared/providers/current_company_provider.dart';
import '../../catalog/data/catalog_models.dart';
import '../../clients/data/client_model.dart';
import '../data/quote_models.dart';
import '../data/quote_readiness.dart';
import '../data/quotes_repository_impl.dart';

/// The status chip selected on the devis list (`null` = "Tous"). Watched by
/// [QuotesNotifier.watchDependencies] so picking a chip re-runs the fetch
/// with `?status=` — kept as a separate provider (rather than notifier
/// state) so the chip bar can watch the selection reactively.
final quotesStatusFilterProvider = StateProvider<QuoteStatus?>((ref) => null);

/// The client filter selected on the devis list (`null` = all clients).
final quotesClientFilterProvider = StateProvider<String?>((ref) => null);

/// The devis list: server-side status/client filters + offset/limit paging.
/// Changing a filter re-runs `build` (via [watchDependencies]); with
/// `skipLoadingOnReload` in `PagedListView`, the current rows stay on screen
/// under a discrete indicator instead of flashing a full-page spinner.
class QuotesNotifier extends PagedListNotifier<Quote> {
  QuoteStatus? _status;
  String? _clientId;

  @override
  Future<String> watchDependencies() {
    // Read filters synchronously (before the first await) so build tracks
    // both providers and re-runs whenever either changes.
    _status = ref.watch(quotesStatusFilterProvider);
    _clientId = ref.watch(quotesClientFilterProvider);
    return ref.watch(currentCompanyIdProvider.future);
  }

  @override
  Future<List<Quote>> fetchPage(String companyId, {required int offset, required int limit}) {
    return ref.read(quotesRepositoryProvider).list(
          companyId: companyId,
          status: _status,
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
  }) async {
    final companyId = await ref.read(currentCompanyIdProvider.future);
    final quote = await ref.read(quotesRepositoryProvider).create(
          companyId: companyId,
          clientId: clientId,
          lines: lines,
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
    final quote = await ref.read(quotesRepositoryProvider).changeStatus(id, status);
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

final quotesNotifierProvider = AsyncNotifierProvider<QuotesNotifier, PagedList<Quote>>(
  QuotesNotifier.new,
);

final quoteByIdProvider = FutureProvider.family<Quote, String>((ref, id) {
  return ref.watch(quotesRepositoryProvider).get(id);
});

/// The pre-flight verdict for a single quote — powers the "Prêt à émettre / À
/// compléter" badge and the readiness gate. `autoDispose` so it re-checks each
/// time a detail screen is opened; the gate also refreshes it when an emit is
/// attempted, so fixing an issue elsewhere is reflected on return.
final quoteReadinessProvider = FutureProvider.autoDispose.family<QuoteReadiness, String>((ref, id) {
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

/// One line being assembled in the "new quote" form, before it's ever sent
/// to the backend. Deliberately carries no computed amount — see
/// `QuoteFormScreen`: nothing is calculated client-side, even for preview,
/// so there is nothing here to compute either.
class QuoteDraftLine {
  const QuoteDraftLine({required this.item, required this.quantity});

  final CatalogItem item;
  final String quantity;
}

class QuoteDraftNotifier extends Notifier<List<QuoteDraftLine>> {
  @override
  List<QuoteDraftLine> build() => [];

  void addLine(CatalogItem item, String quantity) {
    state = [...state, QuoteDraftLine(item: item, quantity: quantity)];
  }

  void removeLineAt(int index) {
    state = [...state]..removeAt(index);
  }

  void clear() => state = [];
}

final quoteDraftLinesProvider = NotifierProvider<QuoteDraftNotifier, List<QuoteDraftLine>>(
  QuoteDraftNotifier.new,
);

/// The client selected for the quote currently being drafted.
final quoteDraftClientProvider = StateProvider<Client?>((ref) => null);
