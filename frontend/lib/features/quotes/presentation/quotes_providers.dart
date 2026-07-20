import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/current_company_provider.dart';
import '../../catalog/data/catalog_models.dart';
import '../../clients/data/client_model.dart';
import '../data/quote_models.dart';
import '../data/quotes_repository_impl.dart';
import '../domain/quote_draft_line.dart';

// Re-exported so existing callers can keep importing `QuoteDraftLine` from
// this file; the type itself now lives in the domain layer so the pure
// preview calculator can depend on it without pulling in Riverpod.
export '../domain/quote_draft_line.dart';

class QuotesNotifier extends AsyncNotifier<List<Quote>> {
  @override
  Future<List<Quote>> build() async {
    final companyId = await ref.watch(currentCompanyIdProvider.future);
    return ref.watch(quotesRepositoryProvider).list(companyId: companyId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final companyId = await refreshCurrentCompanyId(ref);
      return ref.read(quotesRepositoryProvider).list(companyId: companyId);
    });
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
    await refresh();
    return quote;
  }
}

final quotesNotifierProvider = AsyncNotifierProvider<QuotesNotifier, List<Quote>>(
  QuotesNotifier.new,
);

final quoteByIdProvider = FutureProvider.family<Quote, String>((ref, id) {
  return ref.watch(quotesRepositoryProvider).get(id);
});

class QuoteDraftNotifier extends Notifier<List<QuoteDraftLine>> {
  @override
  List<QuoteDraftLine> build() => [];

  void addLine(CatalogItem item, String quantity) {
    state = [...state, QuoteDraftLine(item: item, quantity: quantity)];
  }

  /// Updates the quantity of the line at [index] in place. Called on every
  /// keystroke of a line's quantity field so the preview totals recompute
  /// live (the "Bêta Ready" requirement: quantity change -> total change).
  void updateQuantityAt(int index, String quantity) {
    if (index < 0 || index >= state.length) return;
    final updated = [...state];
    updated[index] = updated[index].copyWith(quantity: quantity);
    state = updated;
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
