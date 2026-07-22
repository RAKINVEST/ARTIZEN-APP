import 'package:artizen/core/widgets/error_state.dart';
import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/clients/data/client_model.dart';
import 'package:artizen/features/clients/data/clients_repository_impl.dart';
import 'package:artizen/features/clients/domain/clients_repository.dart';
import 'package:artizen/features/clients/presentation/client_form_screen.dart';
import 'package:artizen/features/quote_wizard/presentation/quote_wizard_screen.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:artizen/shared/widgets/debounced_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../support/fake_repositories.dart';

Client _client(String id, String name, {String? email}) => Client(
  id: id,
  companyId: 'co1',
  lastName: name,
  email: email,
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

/// A repository whose list always fails — for the network-error state.
class _ThrowingClientsRepository extends FakeClientsRepository {
  _ThrowingClientsRepository() : super(const []);

  @override
  Future<List<Client>> list({
    required String companyId,
    String? query,
    int? offset,
    int? limit,
  }) async {
    throw Exception('réseau indisponible');
  }
}

Future<void> _pump(
  WidgetTester tester, {
  List<Client> clients = const [],
  List<CatalogCategory> categories = const [],
  ClientsRepository? clientsRepo,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        clientsRepositoryProvider.overrideWithValue(
          clientsRepo ?? FakeClientsRepository([...clients]),
        ),
        catalogRepositoryProvider.overrideWithValue(
          FakeCatalogRepository([...categories], const []),
        ),
      ],
      child: const MaterialApp(home: QuoteWizardScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

/// Boots the wizard *pushed onto a route*, with a real client form at
/// `/clients/new`, so the inline-creation round-trip can be exercised.
Future<void> _pumpRouted(
  WidgetTester tester, {
  required Client createResult,
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
      GoRoute(
        path: '/clients/new',
        builder: (context, state) => const ClientFormScreen(),
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        clientsRepositoryProvider.overrideWithValue(
          FakeClientsRepository([], createResult: createResult),
        ),
        catalogRepositoryProvider.overrideWithValue(
          FakeCatalogRepository(const [], const []),
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

Future<void> _type(WidgetTester tester, String text) async {
  await tester.enterText(
    find.descendant(
      of: find.byType(DebouncedSearchField),
      matching: find.byType(EditableText),
    ),
    text,
  );
  await tester.pump(const Duration(milliseconds: 350)); // outlast the debounce
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('an empty search lists every client', (tester) async {
    await _pump(
      tester,
      clients: [_client('c1', 'Dubois'), _client('c2', 'Martin')],
    );

    expect(find.text('Dubois'), findsOneWidget);
    expect(find.text('Martin'), findsOneWidget);
  });

  testWidgets('search filters the list to matching clients', (tester) async {
    await _pump(
      tester,
      clients: [_client('c1', 'Dubois'), _client('c2', 'Martin')],
    );

    await _type(tester, 'Dub');

    expect(find.text('Dubois'), findsOneWidget);
    expect(find.text('Martin'), findsNothing);
  });

  testWidgets('a search with no match explains why, mentioning the query', (
    tester,
  ) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    await _type(tester, 'zzz');

    // « zzz » (with guillemets) is unique to the message — the search field
    // holds a bare "zzz", so this asserts the query is echoed back.
    expect(
      find.textContaining('Aucun client ne correspond à « zzz »'),
      findsOneWidget,
    );
  });

  testWidgets('with no clients at all, invites creating one', (tester) async {
    await _pump(tester);

    expect(
      find.textContaining("Vous n'avez pas encore de client"),
      findsOneWidget,
    );
  });

  testWidgets('a network error shows a retry affordance', (tester) async {
    await _pump(tester, clientsRepo: _ThrowingClientsRepository());

    expect(find.byType(ErrorState), findsOneWidget);
  });

  testWidgets('choosing a client advances to the next step on its own', (
    tester,
  ) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    expect(_suivant(tester).onPressed, isNull); // step 1, nothing chosen yet
    await tester.tap(find.text('Dubois'));
    await tester.pumpAndSettle();

    // Tapping the client is the answer to "which client?" — the wizard moves
    // on without a second press on Suivant.
    expect(find.text('Étape 2 / 7'), findsOneWidget);
  });

  testWidgets('coming back and picking another client changes the selection', (
    tester,
  ) async {
    // A tall surface so both clients stay above the fold once the selected
    // banner pushes the list down — otherwise the second one can't be tapped.
    tester.view.physicalSize = const Size(1200, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await _pump(
      tester,
      clients: [_client('c1', 'Dubois'), _client('c2', 'Martin')],
    );

    await tester.tap(find.text('Dubois')); // selects + advances
    await tester.pumpAndSettle();
    await tester.tap(find.text('Précédent')); // back to the client step
    await tester.pumpAndSettle();
    await tester.tap(find.text('Martin')); // switch client (advances again)
    await tester.pumpAndSettle();
    await tester.tap(find.text('Précédent')); // back once more to inspect
    await tester.pumpAndSettle();

    final banner = find.ancestor(
      of: find.text('Client de ce devis'),
      matching: find.byType(Card),
    );
    expect(
      find.descendant(of: banner, matching: find.text('Martin')),
      findsOneWidget,
    );
  });

  testWidgets('removing the selected client re-gates the step', (tester) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    await tester.tap(find.text('Dubois')); // selects + advances
    await tester.pumpAndSettle();
    await tester.tap(find.text('Précédent')); // back to the client step
    await tester.pumpAndSettle();
    expect(_suivant(tester).onPressed, isNotNull);

    await tester.tap(find.text('Retirer'));
    await tester.pumpAndSettle();

    expect(find.text('Client de ce devis'), findsNothing);
    expect(_suivant(tester).onPressed, isNull); // gated again
  });

  testWidgets('double-tapping a client still advances just once', (
    tester,
  ) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    await tester.tap(find.text('Dubois'));
    await tester.tap(find.text('Dubois'));
    await tester.pumpAndSettle();

    // A fast double tap chooses the client once and advances once.
    expect(find.text('Étape 2 / 7'), findsOneWidget);
  });

  testWidgets('the chosen client survives moving to the next step and back', (
    tester,
  ) async {
    await _pump(
      tester,
      clients: [_client('c1', 'Dubois')],
      categories: [_category('cat1', 'Sanitaires')],
    );

    await tester.tap(find.text('Dubois')); // selects + advances to Dossier
    await tester.pumpAndSettle();
    expect(find.text('Sanitaires'), findsOneWidget); // on the Dossier step

    await tester.tap(find.text('Précédent'));
    await tester.pumpAndSettle();
    expect(find.text('Client de ce devis'), findsOneWidget); // still selected
  });

  testWidgets('creating a client inline selects it automatically', (
    tester,
  ) async {
    // A tall viewport so the whole client form (7 fields + button) fits without
    // scrolling — the submit button sits below a 600px fold otherwise.
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await _pumpRouted(tester, createResult: _client('c2', 'Nouveau'));

    await tester.tap(find.text('Nouveau client'));
    await tester.pumpAndSettle();
    // The primary button uppercases its label (AppPrimaryButton) — this is
    // also how we know we've reached the form.
    expect(find.text('CRÉER LE CLIENT'), findsOneWidget);

    await tester.enterText(
      find
          .descendant(
            of: find.byType(Form),
            matching: find.byType(EditableText),
          )
          .first,
      'Nouveau',
    );
    await tester.pump();
    await tester.tap(find.text('CRÉER LE CLIENT'));
    await tester.pumpAndSettle();

    // Back on the wizard, the just-created client is already selected.
    expect(find.text('Client de ce devis'), findsOneWidget);
    expect(_suivant(tester).onPressed, isNotNull);
  });
}
