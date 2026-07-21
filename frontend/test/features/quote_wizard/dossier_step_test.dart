import 'package:artizen/core/widgets/error_state.dart';
import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/catalog/domain/catalog_repository.dart';
import 'package:artizen/features/clients/data/client_model.dart';
import 'package:artizen/features/clients/data/clients_repository_impl.dart';
import 'package:artizen/features/quote_wizard/presentation/quote_wizard_screen.dart';
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

/// A catalog repository whose overview always fails — for the error state.
class _ThrowingCatalogRepository extends FakeCatalogRepository {
  _ThrowingCatalogRepository() : super(const [], const []);

  @override
  Future<List<CategoryOverview>> listCategoryOverviews() async {
    throw Exception('réseau indisponible');
  }
}

FilledButton _suivant(WidgetTester tester) =>
    tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Suivant'));

/// Boots the wizard and advances past the Client step so tests start on Dossier.
Future<void> _pumpToDossier(
  WidgetTester tester, {
  List<CatalogCategory> categories = const [],
  List<CatalogItem> items = const [],
  CatalogRepository? catalogRepo,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        clientsRepositoryProvider
            .overrideWithValue(FakeClientsRepository([_client('c1', 'Dubois')])),
        catalogRepositoryProvider
            .overrideWithValue(catalogRepo ?? FakeCatalogRepository([...categories], [...items])),
      ],
      child: const MaterialApp(home: QuoteWizardScreen()),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Dubois')); // choose the client
  await tester.pumpAndSettle();
  await tester.tap(find.text('Suivant')); // advance to Dossier
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('lists folders with name, article count and a content preview',
      (tester) async {
    await _pumpToDossier(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu'), _item('i2', 'cat1', 'Lavabo')],
    );

    expect(find.text('Sanitaires'), findsOneWidget); // name
    expect(find.text('2 articles'), findsOneWidget); // count (plural)
    expect(find.textContaining('Aperçu : WC suspendu, Lavabo'), findsOneWidget); // preview
  });

  testWidgets('a single-article folder reads "1 article"', (tester) async {
    await _pumpToDossier(
      tester,
      categories: [_category('cat1', 'Chantier')],
      items: [_item('i1', 'cat1', 'Déplacement')],
    );

    expect(find.text('1 article'), findsOneWidget);
  });

  testWidgets('an empty catalog invites activating a métier', (tester) async {
    await _pumpToDossier(tester); // no categories

    expect(find.textContaining('Votre catalogue est vide'), findsOneWidget);
    expect(find.text('Activer un métier'), findsOneWidget);
  });

  testWidgets('a network error shows a retry affordance', (tester) async {
    await _pumpToDossier(tester, catalogRepo: _ThrowingCatalogRepository());

    expect(find.byType(ErrorState), findsOneWidget);
  });

  testWidgets('opening a folder marks it and enables Suivant', (tester) async {
    await _pumpToDossier(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC')],
    );

    expect(_suivant(tester).onPressed, isNull); // nothing open yet
    await tester.tap(find.text('Sanitaires'));
    await tester.pumpAndSettle();

    expect(find.text('Dossier ouvert'), findsOneWidget);
    expect(_suivant(tester).onPressed, isNotNull);
  });

  testWidgets('opening another folder moves the selection', (tester) async {
    await _pumpToDossier(
      tester,
      categories: [_category('cat1', 'Sanitaires'), _category('cat2', 'Chauffage')],
      items: [_item('i1', 'cat1', 'WC'), _item('i2', 'cat2', 'Radiateur')],
    );

    await tester.tap(find.text('Sanitaires'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Chauffage'));
    await tester.pumpAndSettle();

    expect(find.text('Dossier ouvert'), findsOneWidget); // only one open
    final chauffageCard = find.ancestor(
      of: find.text('Chauffage'),
      matching: find.byType(Card),
    );
    expect(find.descendant(of: chauffageCard, matching: find.text('Dossier ouvert')),
        findsOneWidget);
  });

  testWidgets('the open folder survives navigating back to Client and returning',
      (tester) async {
    await _pumpToDossier(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC')],
    );

    await tester.tap(find.text('Sanitaires'));
    await tester.pumpAndSettle();
    expect(find.text('Dossier ouvert'), findsOneWidget);

    await tester.tap(find.text('Précédent')); // back to Client
    await tester.pumpAndSettle();
    await tester.tap(find.text('Suivant')); // forward to Dossier again
    await tester.pumpAndSettle();

    expect(find.text('Dossier ouvert'), findsOneWidget); // still open
  });

  testWidgets('double-tapping a folder keeps it open once', (tester) async {
    await _pumpToDossier(
      tester,
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC')],
    );

    await tester.tap(find.text('Sanitaires'));
    await tester.tap(find.text('Sanitaires'));
    await tester.pumpAndSettle();

    expect(find.text('Dossier ouvert'), findsOneWidget);
    expect(_suivant(tester).onPressed, isNotNull);
  });
}
