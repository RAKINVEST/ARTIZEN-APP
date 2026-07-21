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

/// The recap's checklist card — scoped so assertions don't collide with the
/// (still-mounted) Personnaliser totals behind the current page.
Finder _checklist() =>
    find.ancestor(of: find.text('Client'), matching: find.byType(Card)).first;

/// Boots the wizard all the way to the Récap step, adding [add] on the way,
/// and lets the calculation settle.
Future<void> _pumpToRecap(
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
  await tester.tap(find.text('Suivant')); // Récap
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 500)); // let the calculation land
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('presents a quality-control checklist: client, line count, totals',
      (tester) async {
    await _pumpToRecap(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
      add: ['WC suspendu'],
    );

    final checklist = _checklist();
    expect(find.descendant(of: checklist, matching: find.text('Dubois')), findsOneWidget);
    expect(find.descendant(of: checklist, matching: find.text('1 article')), findsOneWidget);
    expect(find.descendant(of: checklist, matching: find.text('Total HT')), findsOneWidget);
    expect(find.descendant(of: checklist, matching: find.text('TVA')), findsOneWidget);
    expect(find.descendant(of: checklist, matching: find.text('Total TTC')), findsOneWidget);
  });

  testWidgets('lists each quote line with its quantity and unit price', (tester) async {
    await _pumpToRecap(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu'), _item('i2', 'cat1', 'Lavabo')],
      open: 'Sanitaires',
      add: ['WC suspendu', 'Lavabo'],
    );

    expect(find.text('Détail des lignes'), findsOneWidget);
    // The recap line rows use "qty × PU" — a format unique to this step, so it
    // counts exactly the two lines on the quote.
    expect(find.textContaining('× 10.00 € HT'), findsNWidgets(2));
  });

  testWidgets('totals are the backend calculation, not computed here',
      (tester) async {
    await _pumpToRecap(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu'), _item('i2', 'cat1', 'Lavabo')],
      open: 'Sanitaires',
      add: ['WC suspendu', 'Lavabo'],
    );

    final checklist = _checklist();
    // Quantity-aware fake: two lines of quantity 1 total "2".
    expect(find.descendant(of: checklist, matching: find.text('2 articles')), findsOneWidget);
    expect(find.descendant(of: checklist, matching: find.text('2 €')), findsWidgets); // HT & TTC
  });

  testWidgets('with a valid calculation, the create step is reachable',
      (tester) async {
    await _pumpToRecap(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
      add: ['WC suspendu'],
    );

    // The Récap → Créer gate requires a valid calculation, which is present.
    expect(_suivant(tester).onPressed, isNotNull);
  });
}
