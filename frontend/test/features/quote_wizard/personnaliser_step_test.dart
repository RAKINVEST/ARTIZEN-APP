import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/clients/data/client_model.dart';
import 'package:artizen/features/clients/data/clients_repository_impl.dart';
import 'package:artizen/features/quote_wizard/presentation/quote_wizard_screen.dart';
import 'package:artizen/features/quotes/data/quotes_repository_impl.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

Client _client(String id, String name) => Client(
      id: id,
      companyId: 'co1',
      lastName: name,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

CatalogCategory _category(String id, String name) => CatalogCategory(
      id: id,
      companyId: 'co1',
      name: name,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

CatalogItem _item(String id, String categoryId, String designation) => CatalogItem(
      id: id,
      companyId: 'co1',
      categoryId: categoryId,
      designation: designation,
      itemType: ItemType.product,
      unit: 'unité',
      unitPriceHt: '10.00',
      vatRate: '10.00',
      active: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

FilledButton _suivant(WidgetTester tester) =>
    tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Suivant'));

Finder _addButtonFor(String designation) => find.descendant(
      of: find.ancestor(of: find.text(designation), matching: find.byType(Card)),
      matching: find.widgetWithText(FilledButton, 'Ajouter'),
    );

/// The value cell of a totals row (e.g. the "€" amount next to "Total TTC").
Finder _totalValue(String label, String value) => find.descendant(
      of: find.ancestor(of: find.text(label), matching: find.byType(Row)).first,
      matching: find.text(value),
    );

/// Boots the wizard and walks Client → Dossier → Articles → Personnaliser,
/// adding [add] on the way, then lets the debounced recalculation settle.
Future<void> _pumpToPersonnaliser(
  WidgetTester tester, {
  required List<CatalogCategory> categories,
  required List<CatalogItem> items,
  required String open,
  required List<String> add,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        clientsRepositoryProvider
            .overrideWithValue(FakeClientsRepository([_client('c1', 'Dubois')])),
        catalogRepositoryProvider
            .overrideWithValue(FakeCatalogRepository([...categories], [...items])),
        quotesRepositoryProvider.overrideWithValue(FakeQuotesRepository(const [])),
      ],
      child: const MaterialApp(home: QuoteWizardScreen()),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Dubois'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Suivant')); // Dossier
  await tester.pumpAndSettle();
  await tester.tap(find.text(open));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Suivant')); // Articles
  await tester.pumpAndSettle();
  for (final designation in add) {
    await tester.tap(_addButtonFor(designation));
    await tester.pumpAndSettle();
  }
  await tester.tap(find.text('Suivant')); // Personnaliser
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 500)); // outlast the recalc debounce
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows each line with its quantity and catalog unit price',
      (tester) async {
    await _pumpToPersonnaliser(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
      add: ['WC suspendu'],
    );

    expect(find.text('WC suspendu'), findsOneWidget);
    expect(find.textContaining('PU 10.00 € HT'), findsOneWidget);
    expect(find.text('1'), findsOneWidget); // the quantity stepper
  });

  testWidgets('shows backend totals once the calculation lands', (tester) async {
    await _pumpToPersonnaliser(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
      add: ['WC suspendu'],
    );

    // Quantity-aware fake: one line of quantity 1 totals "1".
    expect(find.text('Total TTC'), findsOneWidget);
    expect(_totalValue('Total TTC', '1 €'), findsOneWidget);
  });

  testWidgets('increasing a quantity re-prices via the backend', (tester) async {
    await _pumpToPersonnaliser(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
      add: ['WC suspendu'],
    );

    await tester.tap(find.byTooltip('Augmenter la quantité'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text('2'), findsOneWidget); // quantity updated (immediate, draft)
    expect(_totalValue('Total TTC', '2 €'), findsOneWidget); // total re-priced (backend)
  });

  testWidgets('decreasing a quantity re-prices via the backend', (tester) async {
    await _pumpToPersonnaliser(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
      add: ['WC suspendu'],
    );
    await tester.tap(find.byTooltip('Augmenter la quantité')); // to 2
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Diminuer la quantité')); // back to 1
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
    expect(_totalValue('Total TTC', '1 €'), findsOneWidget);
  });

  testWidgets('removing the last line empties the step and re-gates it',
      (tester) async {
    await _pumpToPersonnaliser(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
      add: ['WC suspendu'],
    );

    await tester.tap(find.byTooltip('Retirer la ligne'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Ajoutez des articles'), findsOneWidget);
    expect(_suivant(tester).onPressed, isNull); // no line → gated
  });

  testWidgets('totals cover several lines', (tester) async {
    await _pumpToPersonnaliser(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu'), _item('i2', 'cat1', 'Lavabo')],
      open: 'Sanitaires',
      add: ['WC suspendu', 'Lavabo'],
    );

    expect(find.text('WC suspendu'), findsOneWidget);
    expect(find.text('Lavabo'), findsOneWidget);
    // Two lines of quantity 1 total "2".
    expect(_totalValue('Total TTC', '2 €'), findsOneWidget);
  });

  testWidgets('an adjusted quantity survives leaving and returning', (tester) async {
    await _pumpToPersonnaliser(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
      add: ['WC suspendu'],
    );
    await tester.tap(find.byTooltip('Augmenter la quantité')); // to 2
    await tester.pumpAndSettle();

    await tester.tap(find.text('Précédent')); // back to Articles
    await tester.pumpAndSettle();
    await tester.tap(find.text('Suivant')); // forward to Personnaliser
    await tester.pumpAndSettle();

    expect(find.text('2'), findsOneWidget); // quantity preserved
  });
}
