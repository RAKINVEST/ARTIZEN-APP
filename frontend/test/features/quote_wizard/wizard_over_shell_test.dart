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

/// Reproduces the *exact* mount the web build used: the wizard pushed
/// full-screen on the ROOT navigator, on top of a `StatefulShellRoute`
/// (the bottom-nav shell) — not the bare `MaterialApp(home:)` the other
/// wizard tests use. On the web renderer this collapsed the flexible content
/// column to zero height: only the left menu and the progress bar showed
/// ("le devis s'ouvre vide"). Run under `flutter test --platform chrome` to
/// exercise the real web renderer.
Future<void> _pumpOverShell(WidgetTester tester) async {
  final rootKey = GlobalKey<NavigatorState>();
  final router = GoRouter(
    navigatorKey: rootKey,
    initialLocation: '/quotes',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => Scaffold(
          body: shell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: shell.currentIndex,
            onDestinationSelected: (index) => shell.goBranch(index),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.description),
                label: 'Devis',
              ),
              NavigationDestination(icon: Icon(Icons.people), label: 'Clients'),
            ],
          ),
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/quotes',
                builder: (context, state) => Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      onPressed: () => context.push('/assistant'),
                      child: const Text('Créer un devis'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/clients',
                builder: (context, state) =>
                    const Scaffold(body: Center(child: Text('clients'))),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/assistant',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const QuoteWizardScreen(),
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        clientsRepositoryProvider.overrideWithValue(
          FakeClientsRepository([_client('c1', 'Dubois')]),
        ),
        catalogRepositoryProvider.overrideWithValue(
          FakeCatalogRepository(const [], const []),
        ),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Créer un devis'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'wizard pushed over the shell shows its content, not just chrome',
    (tester) async {
      tester.view.physicalSize = const Size(1400, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await _pumpOverShell(tester);

      // The chrome that survived the bug:
      expect(find.text('ARTIZEN'), findsOneWidget); // left menu
      expect(find.text('Étape 1 / 6'), findsOneWidget); // progress bar

      // The content that VANISHED in the bug — the flexible column collapsed to
      // zero, so the step (question + client picker) never got any height.
      expect(
        find.text('Pour quel client faites-vous ce devis ?'),
        findsOneWidget,
        reason: 'the step content must render — this is the "devis vide" bug',
      );
      expect(find.text('Nouveau client'), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);

      // And the PageView must have real height (the collapse showed as ~0).
      final pageViewSize = tester.getSize(find.byType(PageView));
      expect(pageViewSize.height, greaterThan(100));
    },
  );
}
