import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/clients/data/client_model.dart';
import 'package:artizen/features/clients/data/clients_repository_impl.dart';
import 'package:artizen/features/quote_wizard/presentation/quote_wizard_screen.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:artizen/shared/widgets/debounced_search_field.dart';
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

Future<void> _search(WidgetTester tester, String text) async {
  await tester.enterText(
    find.descendant(of: find.byType(DebouncedSearchField), matching: find.byType(EditableText)),
    text,
  );
  await tester.pump(const Duration(milliseconds: 350)); // outlast the debounce
  await tester.pumpAndSettle();
}

/// Boots the wizard and walks Client → Dossier → Articles so tests start on
/// the Articles step, with [open] as the opened folder.
Future<void> _pumpToArticles(
  WidgetTester tester, {
  required List<CatalogCategory> categories,
  required List<CatalogItem> items,
  required String open,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        clientsRepositoryProvider
            .overrideWithValue(FakeClientsRepository([_client('c1', 'Dubois')])),
        catalogRepositoryProvider
            .overrideWithValue(FakeCatalogRepository([...categories], [...items])),
      ],
      child: const MaterialApp(home: QuoteWizardScreen()),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Dubois'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Suivant')); // to Dossier
  await tester.pumpAndSettle();
  await tester.tap(find.text(open)); // open the folder
  await tester.pumpAndSettle();
  await tester.tap(find.text('Suivant')); // to Articles
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('lists the open folder\'s articles with their catalog price',
      (tester) async {
    await _pumpToArticles(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu'), _item('i2', 'cat1', 'Lavabo')],
      open: 'Sanitaires',
    );

    expect(find.text('WC suspendu'), findsOneWidget);
    expect(find.text('Lavabo'), findsOneWidget);
    expect(find.textContaining('10.00 € HT'), findsWidgets);
  });

  testWidgets('adding an article gives immediate feedback and enables Suivant',
      (tester) async {
    await _pumpToArticles(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
    );

    expect(_suivant(tester).onPressed, isNull); // no line yet
    await tester.tap(_addButtonFor('WC suspendu'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Ajouté au devis'), findsOneWidget);
    expect(find.textContaining('(× 1)'), findsOneWidget);
    expect(_suivant(tester).onPressed, isNotNull);
  });

  testWidgets('adding the same article again bumps its quantity, not a duplicate',
      (tester) async {
    await _pumpToArticles(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
    );

    await tester.tap(_addButtonFor('WC suspendu'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Ajouter une unité')); // the "+" on the added row
    await tester.pumpAndSettle();

    expect(find.textContaining('(× 2)'), findsOneWidget);
    expect(find.textContaining('Ajouté au devis'), findsOneWidget); // still one row
  });

  testWidgets('removing units takes the line off the quote and re-gates the step',
      (tester) async {
    await _pumpToArticles(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
    );

    await tester.tap(_addButtonFor('WC suspendu'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Retirer une unité'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Ajouté au devis'), findsNothing);
    expect(_suivant(tester).onPressed, isNull); // back to no line
  });

  testWidgets('several different articles can be added quickly', (tester) async {
    await _pumpToArticles(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu'), _item('i2', 'cat1', 'Lavabo')],
      open: 'Sanitaires',
    );

    await tester.tap(_addButtonFor('WC suspendu'));
    await tester.pumpAndSettle();
    await tester.tap(_addButtonFor('Lavabo'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Ajouté au devis'), findsNWidgets(2));
    expect(_suivant(tester).onPressed, isNotNull);
  });

  testWidgets('search narrows the folder to matching articles', (tester) async {
    await _pumpToArticles(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu'), _item('i2', 'cat1', 'Lavabo')],
      open: 'Sanitaires',
    );

    await _search(tester, 'Lav');

    expect(find.text('Lavabo'), findsOneWidget);
    expect(find.text('WC suspendu'), findsNothing);
  });

  testWidgets('an empty folder says so', (tester) async {
    await _pumpToArticles(
      tester,
      categories: [_category('cat1', 'Vide')],
      items: const [],
      open: 'Vide',
    );

    expect(find.textContaining('Ce dossier ne contient aucun article'), findsOneWidget);
  });

  testWidgets('a search with no match explains it', (tester) async {
    await _pumpToArticles(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
    );

    await _search(tester, 'zzz');

    expect(find.textContaining('Aucun article ne correspond à « zzz »'), findsOneWidget);
  });

  testWidgets('added articles survive leaving and returning to the step',
      (tester) async {
    await _pumpToArticles(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu')],
      open: 'Sanitaires',
    );

    await tester.tap(_addButtonFor('WC suspendu'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Ajouté au devis'), findsOneWidget);

    await tester.tap(find.text('Précédent')); // back to Dossier
    await tester.pumpAndSettle();
    await tester.tap(find.text('Suivant')); // forward to Articles
    await tester.pumpAndSettle();

    expect(find.textContaining('Ajouté au devis'), findsOneWidget); // still added
  });

  testWidgets('a huge folder is fetched bounded, and search still finds an item',
      (tester) async {
    // 1000 items in one folder: the picker fetches a single bounded page
    // (limit 100), so the UI never tries to build all 1000 at once.
    final items = [for (var i = 0; i < 1000; i++) _item('i$i', 'cat1', 'Article $i')];
    await _pumpToArticles(
      tester,
      categories: [_category('cat1', 'Gros dossier')],
      items: items,
      open: 'Gros dossier',
    );

    // Exactly the bounded page is rendered, not the whole 1000.
    expect(find.widgetWithText(FilledButton, 'Ajouter'), findsNWidgets(100));

    // Server-side search reaches an item beyond the first page. Scope to the
    // Card so the field's own text (also "Article 777") isn't counted.
    await _search(tester, 'Article 777');
    expect(find.widgetWithText(Card, 'Article 777'), findsOneWidget);
  });
}
