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
    'QuotesNotifier loads every quote when no status filter is set',
    () async {
      final container = _containerWith([
        _quote('1', QuoteStatus.draft),
        _quote('2', QuoteStatus.sent),
      ]);

      final page = await container.read(quotesNotifierProvider.future);

      expect(page.items, hasLength(2));
    },
  );

  test(
    'Setting the "en attente" view re-fetches draft + sent (server ?status=)',
    () async {
      final container = _containerWith([
        _quote('1', QuoteStatus.draft),
        _quote('2', QuoteStatus.sent),
        _quote('3', QuoteStatus.accepted),
      ]);

      await container.read(quotesNotifierProvider.future);
      // "En attente" folds draft + sent into one compound view — a single fetch.
      container.read(quotesFilterProvider.notifier).state =
          QuotesFilter.pending;

      final page = await container.read(quotesNotifierProvider.future);
      expect(page.items, hasLength(2)); // draft + sent, never the accepted one
      expect(
        page.items.every(
          (quote) =>
              quote.status == QuoteStatus.draft ||
              quote.status == QuoteStatus.sent,
        ),
        isTrue,
      );
    },
  );

  test('QuotesNotifier.loadMore appends the next page', () async {
    final quotes = [
      for (var i = 0; i < 35; i++) _quote('$i', QuoteStatus.draft),
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
