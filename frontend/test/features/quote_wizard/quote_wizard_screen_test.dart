import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
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

Future<void> _pump(
  WidgetTester tester, {
  List<Client> clients = const [],
  List<CatalogCategory> categories = const [],
  List<CatalogItem> items = const [],
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        clientsRepositoryProvider.overrideWithValue(FakeClientsRepository([...clients])),
        catalogRepositoryProvider
            .overrideWithValue(FakeCatalogRepository([...categories], [...items])),
      ],
      child: const MaterialApp(home: QuoteWizardScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

FilledButton _suivant(WidgetTester tester) =>
    tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Suivant'));

Future<void> _chooseClientAndAdvance(WidgetTester tester) async {
  await tester.tap(find.text('Dubois'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Suivant'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('opens on the Client step with the progress at 1/7', (tester) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    expect(find.text('Pour quel client faites-vous ce devis ?'), findsOneWidget);
    expect(find.text('Étape 1 / 7'), findsOneWidget);
    expect(find.text('ARTIZEN'), findsOneWidget); // left menu is permanent
  });

  testWidgets('Suivant is gated until a client is chosen, then it advances', (tester) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')], categories: [_category('cat1', 'Sanitaires')]);

    expect(_suivant(tester).onPressed, isNull); // no client yet

    await tester.tap(find.text('Dubois'));
    await tester.pumpAndSettle();

    expect(_suivant(tester).onPressed, isNotNull);
    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Étape 2 / 7'), findsOneWidget);
  });

  testWidgets('the Dossier step lists folders with counts, and opening one enables Suivant',
      (tester) async {
    await _pump(
      tester,
      clients: [_client('c1', 'Dubois')],
      categories: [_category('cat1', 'Sanitaires')],
      items: [_item('i1', 'cat1', 'WC suspendu'), _item('i2', 'cat1', 'Lavabo')],
    );
    await _chooseClientAndAdvance(tester);

    expect(find.text('Sanitaires'), findsOneWidget);
    expect(find.text('2 articles'), findsOneWidget);

    // Can't advance until a folder is open.
    expect(_suivant(tester).onPressed, isNull);
    await tester.tap(find.text('Sanitaires'));
    await tester.pumpAndSettle();
    expect(_suivant(tester).onPressed, isNotNull);
  });

  testWidgets('cannot jump forward past an incomplete step', (tester) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    await tester.ensureVisible(find.text('Récap'));
    await tester.tap(find.text('Récap'));
    await tester.pumpAndSettle();

    expect(find.text('Étape 1 / 7'), findsOneWidget); // blocked
  });

  testWidgets('Précédent is disabled on the first step', (tester) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    final previous = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Précédent'),
    );
    expect(previous.onPressed, isNull);
  });
}
