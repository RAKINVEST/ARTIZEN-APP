import 'package:artizen/features/dashboard/domain/dashboard_summary.dart';
import 'package:flutter_test/flutter_test.dart';

DashboardSummary _summary({
  bool siret = false,
  int clients = 0,
  int items = 0,
  int quotes = 0,
}) =>
    DashboardSummary(
      clientCount: ApproximateCount(value: clients, capped: false),
      catalogItemCount: ApproximateCount(value: items, capped: false),
      quoteCount: ApproximateCount(value: quotes, capped: false),
      recentQuotes: const [],
      companyHasSiret: siret,
    );

void main() {
  group('DashboardSummary onboarding', () {
    test('a brand-new company has nothing done', () {
      final summary = _summary();

      expect(summary.companyConfigured, isFalse);
      expect(summary.hasCatalogItem, isFalse);
      expect(summary.hasClient, isFalse);
      expect(summary.hasQuote, isFalse);
      expect(summary.onboardingDoneCount, 0);
      expect(summary.onboardingComplete, isFalse);
    });

    test('a SIRET marks the company step done', () {
      final summary = _summary(siret: true);

      expect(summary.companyConfigured, isTrue);
      expect(summary.onboardingDoneCount, 1);
    });

    test('each non-empty count completes its own step', () {
      expect(_summary(items: 2).hasCatalogItem, isTrue);
      expect(_summary(clients: 1).hasClient, isTrue);
      expect(_summary(quotes: 5).hasQuote, isTrue);
      expect(_summary(clients: 1, items: 1).onboardingDoneCount, 2);
    });

    test('all four done means the checklist is complete', () {
      final summary = _summary(siret: true, clients: 1, items: 1, quotes: 1);

      expect(summary.onboardingDoneCount, 4);
      expect(summary.onboardingComplete, isTrue);
    });
  });

  group('ApproximateCount', () {
    test('shows the plain number when the page was not full', () {
      const count = ApproximateCount(value: 12, capped: false);

      expect(count.display, '12');
    });

    test('shows "N+" when the page filled up, because N is a floor', () {
      // The dashboard counts a paginated list, so a full page means "at
      // least 100" — never "100". An artisan with 250 clients was shown a
      // flat "100" forever, with nothing to hint it was wrong.
      const count = ApproximateCount(value: 100, capped: true);

      expect(count.display, '100+');
    });

    test('an empty result is still an exact zero', () {
      const count = ApproximateCount(value: 0, capped: false);

      expect(count.display, '0');
    });
  });
}
