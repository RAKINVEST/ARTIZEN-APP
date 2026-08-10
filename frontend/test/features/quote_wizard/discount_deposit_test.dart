import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/clients/data/client_model.dart';
import 'package:artizen/features/clients/data/clients_repository_impl.dart';
import 'package:artizen/features/quote_wizard/data/quote_draft.dart';
import 'package:artizen/features/quote_wizard/presentation/quote_draft_provider.dart';
import 'package:artizen/features/quote_wizard/presentation/quote_wizard_screen.dart';
import 'package:artizen/features/quotes/data/quote_models.dart';
import 'package:artizen/features/quotes/data/quotes_repository_impl.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

/// V1.1 #3 — quote-level discount + deposit (décision 5). The frontend collects
/// the parameters and displays what the backend returns; it never computes an
/// amount. The FakeQuotesRepository resolves the discount/deposit just enough
/// for these tests to assert the applied figures.
DraftLine _line(String id) => DraftLine(
  id: id,
  catalogItemId: id,
  designation: 'Article $id',
  unit: 'u',
  quantity: 1,
  unitPriceHt: '1.00',
  vatRate: '0.00',
);

Future<WidgetRef> _pumpRef(WidgetTester tester) async {
  late WidgetRef captured;
  await tester.pumpWidget(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, _) {
          captured = ref;
          return const SizedBox();
        },
      ),
    ),
  );
  return captured;
}

void main() {
  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        quotesRepositoryProvider.overrideWithValue(
          FakeQuotesRepository(const []),
        ),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('discount / deposit inputs', () {
    test('setDiscount records the type and value; clearDiscount resets', () {
      final c = makeContainer();
      final n = c.read(quoteDraftProvider.notifier);
      n.setDiscount('percent', '10');
      expect(c.read(quoteDraftProvider).discountType, 'percent');
      expect(c.read(quoteDraftProvider).discountValue, '10');
      n.clearDiscount();
      expect(c.read(quoteDraftProvider).discountType, isNull);
      expect(c.read(quoteDraftProvider).discountValue, isNull);
    });

    test('recalculate sends the discount and the backend nets it', () async {
      final c = makeContainer();
      final n = c.read(quoteDraftProvider.notifier);
      n.addArticle(_line('a'));
      n.addArticle(_line('b')); // gross total 2 in the fake
      n.setDiscount('percent', '50');
      await n.recalculate();
      final calc = c.read(quoteDraftProvider).calculation!;
      expect(calc.discountAmount, '1.00'); // 50% of 2
      expect(calc.netTotalTtc, '1.0'); // 2 - 1 (stub keeps the double form)
    });

    test('recalculate sends the deposit and returns the balance', () async {
      final c = makeContainer();
      final n = c.read(quoteDraftProvider.notifier);
      n.addArticle(_line('a'));
      n.addArticle(_line('b')); // total 2
      n.setDeposit('percent', '25');
      await n.recalculate();
      final calc = c.read(quoteDraftProvider).calculation!;
      expect(calc.depositAmount, '0.50'); // 25% of 2
      expect(calc.balanceDue, '1.50');
    });

    test('an amount discount is sent through too', () async {
      final c = makeContainer();
      final n = c.read(quoteDraftProvider.notifier);
      n.addArticle(_line('a'));
      n.addArticle(_line('b')); // total 2
      n.setDiscount('amount', '1.50');
      await n.recalculate();
      expect(c.read(quoteDraftProvider).calculation!.discountAmount, '1.50');
    });

    test('reset clears the discount and deposit', () {
      final c = makeContainer();
      final n = c.read(quoteDraftProvider.notifier);
      n.setDiscount('amount', '5');
      n.setDeposit('percent', '10');
      n.reset();
      final d = c.read(quoteDraftProvider);
      expect(d.discountType, isNull);
      expect(d.depositType, isNull);
    });
  });

  group('reopening a draft restores the discount/deposit', () {
    testWidgets('loadQuoteForEdit restores the discount + deposit inputs', (
      tester,
    ) async {
      final ref = await _pumpRef(tester);
      final quote = Quote(
        id: 'q1',
        companyId: 'co1',
        clientId: 'cl1',
        quoteNumber: 'DEV-2026-0001',
        status: QuoteStatus.draft,
        totalHt: '100.00',
        totalVat: '20.00',
        totalTtc: '120.00',
        discountType: 'percent',
        discountValue: '10.00',
        discountAmount: '10.00',
        netTotalHt: '90.00',
        netTotalVat: '18.00',
        netTotalTtc: '108.00',
        depositType: 'amount',
        depositValue: '50.00',
        depositAmount: '50.00',
        balanceDue: '58.00',
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
        lines: const [],
      );

      loadQuoteForEdit(ref, quote, clientLabel: 'Client X');
      await tester.pump();

      final d = ref.read(quoteDraftProvider);
      expect(d.discountType, 'percent');
      expect(d.discountValue, '10.00');
      expect(d.depositType, 'amount');
      expect(d.depositValue, '50.00');
    });
  });

  group('display', () {
    Client client(String id, String name) => Client(
      id: id,
      companyId: 'co1',
      lastName: name,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );
    CatalogCategory category(String id, String name) => CatalogCategory(
      id: id,
      companyId: 'co1',
      name: name,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );
    CatalogItem item(String id, String cat, String d) => CatalogItem(
      id: id,
      companyId: 'co1',
      categoryId: cat,
      designation: d,
      itemType: ItemType.product,
      unit: 'u',
      unitPriceHt: '1.00',
      vatRate: '0.00',
      active: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

    testWidgets('the Personnaliser step shows the remise once one is set', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
            clientsRepositoryProvider.overrideWithValue(
              FakeClientsRepository([client('c1', 'Dubois')]),
            ),
            catalogRepositoryProvider.overrideWithValue(
              FakeCatalogRepository(
                [category('cat1', 'Sanitaires')],
                [item('i1', 'cat1', 'WC suspendu')],
              ),
            ),
            quotesRepositoryProvider.overrideWithValue(
              FakeQuotesRepository(const []),
            ),
          ],
          child: const MaterialApp(home: QuoteWizardScreen()),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dubois'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Articles'));
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.ancestor(
            of: find.text('WC suspendu'),
            matching: find.byType(Card),
          ),
          matching: find.widgetWithText(FilledButton, 'Ajouter'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Suivant')); // → Personnaliser
      await tester.pumpAndSettle();

      // Set a 50% discount through the same provider the UI drives, then let
      // the debounced recalculation land.
      final container = ProviderScope.containerOf(
        tester.element(find.byType(QuoteWizardScreen)),
      );
      container.read(quoteDraftProvider.notifier).setDiscount('percent', '50');
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      // The totals card now shows the remise and the net total (1 line of 1,
      // discounted 50% -> net 0.5 in the stub).
      expect(find.textContaining('Remise'), findsWidgets);
      expect(find.textContaining('Total HT net'), findsOneWidget);
    });
  });
}
