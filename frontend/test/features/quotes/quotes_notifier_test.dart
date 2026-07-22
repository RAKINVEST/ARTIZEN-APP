import 'package:artizen/features/quotes/data/quote_models.dart';
import 'package:artizen/features/quotes/data/quotes_repository_impl.dart';
import 'package:artizen/features/quotes/presentation/quotes_providers.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

Quote _quote(String id, QuoteStatus status, {String clientId = 'cl1'}) => Quote(
  id: id,
  companyId: 'co1',
  clientId: clientId,
  quoteNumber: 'DEV-2026-${id.padLeft(4, '0')}',
  status: status,
  totalHt: '100.00',
  totalVat: '20.00',
  totalTtc: '120.00',
  lines: const [],
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

ProviderContainer _containerWith(List<Quote> quotes) {
  final container = ProviderContainer(
    overrides: [
      currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
      quotesRepositoryProvider.overrideWithValue(FakeQuotesRepository(quotes)),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test(
    'the default view shows the devis (sent & beyond), not brouillons',
    () async {
      final container = _containerWith([
        _quote('1', QuoteStatus.draft), // brouillon — excluded from "Devis"
        _quote('2', QuoteStatus.pending), // en attente — excluded too
        _quote('3', QuoteStatus.sent),
        _quote('4', QuoteStatus.accepted),
      ]);

      // Default filter is QuotesFilter.all = the devis proper: sent + accepted
      // + refused. A brouillon or en-attente never shows here.
      final page = await container.read(quotesNotifierProvider.future);

      expect(page.items, hasLength(2)); // the sent + accepted ones
      expect(
        page.items.every(
          (quote) =>
              quote.status == QuoteStatus.sent ||
              quote.status == QuoteStatus.accepted ||
              quote.status == QuoteStatus.refused,
        ),
        isTrue,
      );
    },
  );

  test(
    'the "en attente" view re-fetches only pending (server ?status=)',
    () async {
      final container = _containerWith([
        _quote('1', QuoteStatus.draft),
        _quote('2', QuoteStatus.pending),
        _quote('3', QuoteStatus.sent),
      ]);

      await container.read(quotesNotifierProvider.future);
      container.read(quotesFilterProvider.notifier).state =
          QuotesFilter.pending;

      final page = await container.read(quotesNotifierProvider.future);
      expect(page.items, hasLength(1)); // only the pending one
      expect(page.items.single.status, QuoteStatus.pending);
    },
  );

  test('QuotesNotifier.loadMore appends the next page', () async {
    // Sent quotes so they show under the default "Devis" (sent & beyond) view.
    final quotes = [
      for (var i = 0; i < 35; i++) _quote('$i', QuoteStatus.sent),
    ];
    final container = _containerWith(quotes);

    final firstPage = await container.read(quotesNotifierProvider.future);
    expect(firstPage.items, hasLength(30));
    expect(firstPage.hasMore, isTrue);

    await container.read(quotesNotifierProvider.notifier).loadMore();

    final merged = container.read(quotesNotifierProvider).value!;
    expect(merged.items, hasLength(35));
    expect(merged.hasMore, isFalse);
  });
}
