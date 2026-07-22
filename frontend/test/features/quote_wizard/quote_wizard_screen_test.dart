import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/clients/data/client_model.dart';
import 'package:artizen/features/clients/data/clients_repository_impl.dart';
import 'package:artizen/features/quote_wizard/presentation/quote_wizard_screen.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

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

CatalogItem _item(String id, String categoryId, String designation) =>
    CatalogItem(
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
        clientsRepositoryProvider.overrideWithValue(
          FakeClientsRepository([...clients]),
        ),
        catalogRepositoryProvider.overrideWithValue(
          FakeCatalogRepository([...categories], [...items]),
        ),
      ],
      child: const MaterialApp(home: QuoteWizardScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

/// Pumps the wizard *pushed onto a route*, so leaving it (Quitter / back) has
/// somewhere to pop to — the home route shows an "Ouvrir" button.
Future<void> _pumpRouted(
  WidgetTester tester, {
  List<Client> clients = const [],
}) async {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => context.push('/assistant'),
              child: const Text('Ouvrir'),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/assistant',
        builder: (context, state) => const QuoteWizardScreen(),
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        clientsRepositoryProvider.overrideWithValue(
          FakeClientsRepository([...clients]),
        ),
        catalogRepositoryProvider.overrideWithValue(
          FakeCatalogRepository(
            const <CatalogCategory>[],
            const <CatalogItem>[],
          ),
        ),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Ouvrir'));
  await tester.pumpAndSettle();
}

FilledButton _suivant(WidgetTester tester) =>
    tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Suivant'));

Future<void> _chooseClientAndAdvance(WidgetTester tester) async {
  // Tapping the client both selects it and advances to the Catalogue step.
  await tester.tap(find.text('Dubois'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('opens on the Client step with the progress at 1/6', (
    tester,
  ) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    expect(
      find.text('Pour quel client faites-vous ce devis ?'),
      findsOneWidget,
    );
    expect(find.text('Étape 1 / 6'), findsOneWidget);
    expect(find.text('ARTIZEN'), findsOneWidget); // left menu is permanent
  });

  testWidgets(
    'Suivant is gated with no client; choosing one advances by itself',
    (tester) async {
      await _pump(
        tester,
        clients: [_client('c1', 'Dubois')],
        categories: [_category('cat1', 'Sanitaires')],
      );

      expect(_suivant(tester).onPressed, isNull); // step 1, no client yet

      await tester.tap(find.text('Dubois'));
      await tester.pumpAndSettle();

      // Tapping the client is the answer — the wizard moves to the Catalogue
      // step without a second press on Suivant.
      expect(find.text('Étape 2 / 6'), findsOneWidget);
    },
  );

  testWidgets(
    'the Catalogue step: adding an article from the Articles onglet enables Suivant',
    (tester) async {
      await _pump(
        tester,
        clients: [_client('c1', 'Dubois')],
        categories: [_category('cat1', 'Sanitaires')],
        items: [
          _item('i1', 'cat1', 'WC suspendu'),
          _item('i2', 'cat1', 'Lavabo'),
        ],
      );
      await _chooseClientAndAdvance(tester); // → Catalogue step

      expect(find.text('Étape 2 / 6'), findsOneWidget);
      expect(_suivant(tester).onPressed, isNull); // nothing added yet → gated

      // The flat "Articles" onglet lists every active article.
      await tester.tap(find.text('Articles'));
      await tester.pumpAndSettle();
      expect(find.text('WC suspendu'), findsOneWidget);

      // Adding one puts a line on the draft and unlocks Suivant.
      await tester.tap(find.widgetWithText(FilledButton, 'Ajouter').first);
      await tester.pumpAndSettle();
      expect(_suivant(tester).onPressed, isNotNull);
    },
  );

  testWidgets('cannot jump forward past an incomplete step', (tester) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    await tester.ensureVisible(find.text('Récap'));
    await tester.tap(find.text('Récap'));
    await tester.pumpAndSettle();

    expect(find.text('Étape 1 / 6'), findsOneWidget); // blocked
  });

  testWidgets('Précédent is disabled on the first step', (tester) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    final previous = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Précédent'),
    );
    expect(previous.onPressed, isNull);
  });

  testWidgets('leaving an in-progress draft asks to confirm, and cancel stays', (
    tester,
  ) async {
    await _pumpRouted(tester, clients: [_client('c1', 'Dubois')]);
    await tester.tap(find.text('Dubois')); // draft now holds a client
    await tester.pumpAndSettle();

    await tester.tap(find.text('Quitter'));
    await tester.pumpAndSettle();
    expect(find.text('Abandonner ce devis ?'), findsOneWidget);

    await tester.tap(find.text('Continuer le devis'));
    await tester.pumpAndSettle();
    // Choosing the client advanced to step 2; cancelling the exit stays there.
    expect(find.text('Étape 2 / 6'), findsOneWidget); // still in the wizard
    expect(find.text('Ouvrir'), findsNothing);
  });

  testWidgets('confirming abandon leaves the wizard', (tester) async {
    await _pumpRouted(tester, clients: [_client('c1', 'Dubois')]);
    await tester.tap(find.text('Dubois'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Quitter'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Abandonner'));
    await tester.pumpAndSettle();

    expect(find.text('Ouvrir'), findsOneWidget); // back on the home route
    expect(find.text('Étape 1 / 6'), findsNothing);
  });

  testWidgets('leaving an empty draft does not prompt', (tester) async {
    await _pumpRouted(tester); // no client chosen

    await tester.tap(find.text('Quitter'));
    await tester.pumpAndSettle();

    expect(find.text('Abandonner ce devis ?'), findsNothing);
    expect(find.text('Ouvrir'), findsOneWidget); // left immediately
  });
}
