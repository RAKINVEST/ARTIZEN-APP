import 'package:artizen/features/branding/data/branding_models.dart';
import 'package:artizen/features/branding/data/branding_repository_impl.dart';
import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/clients/data/client_model.dart';
import 'package:artizen/features/clients/data/clients_repository_impl.dart';
import 'package:artizen/features/quote_wizard/presentation/quote_wizard_screen.dart';
import 'package:artizen/features/quotes/data/quote_models.dart';
import 'package:artizen/features/quotes/data/quotes_repository_impl.dart';
import 'package:artizen/features/quotes/domain/quotes_repository.dart';
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

Quote _quote(String id, String number) => Quote(
  id: id,
  companyId: 'co1',
  clientId: 'c1',
  quoteNumber: number,
  status: QuoteStatus.draft,
  totalHt: '10.00',
  totalVat: '1.00',
  totalTtc: '11.00',
  lines: const [],
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

Finder _addButtonFor(String designation) => find.descendant(
  of: find.ancestor(of: find.text(designation), matching: find.byType(Card)),
  matching: find.widgetWithText(FilledButton, 'Ajouter'),
);

/// A company whose identity is incomplete (no address / SIRET / logo) — makes
/// the confirmation step show its "complete your identity" nudge.
BrandingProfile _incompleteProfile() => const BrandingProfile(
  company: Company(id: 'co1'),
  brand: BrandProfile(id: 'b1'),
  templates: [],
);

List<Override> _overrides(QuotesRepository quotesRepo) => [
  currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
  clientsRepositoryProvider.overrideWithValue(
    FakeClientsRepository([_client('c1', 'Dubois')]),
  ),
  catalogRepositoryProvider.overrideWithValue(
    FakeCatalogRepository(
      [_category('cat1', 'Sanitaires')],
      [_item('i1', 'cat1', 'WC suspendu')],
    ),
  ),
  quotesRepositoryProvider.overrideWithValue(quotesRepo),
  brandingRepositoryProvider.overrideWithValue(
    FakeBrandingRepository(_incompleteProfile()),
  ),
];

/// Walks Client → Catalogue (Articles onglet) → Personnaliser → Récap → Créer,
/// assuming the wizard is already on screen.
Future<void> _walkToCreer(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.text('Dubois'));
  await tester.pumpAndSettle(); // → Catalogue step
  await tester.tap(find.text('Articles')); // the flat Articles onglet
  await tester.pumpAndSettle();
  await tester.tap(_addButtonFor('WC suspendu'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Suivant')); // Personnaliser
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 500)); // recalc
  await tester.pumpAndSettle();
  await tester.tap(find.text('Suivant')); // Récap
  await tester.pumpAndSettle();
  await tester.tap(find.text('Suivant')); // Créer
  await tester.pumpAndSettle();
}

Future<void> _pumpHome(WidgetTester tester, QuotesRepository quotesRepo) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: _overrides(quotesRepo),
      child: const MaterialApp(home: QuoteWizardScreen()),
    ),
  );
  await _walkToCreer(tester);
}

Future<void> _pumpRouted(
  WidgetTester tester,
  QuotesRepository quotesRepo,
) async {
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
        path: '/quotes',
        builder: (context, state) => Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Mes devis'),
                ElevatedButton(
                  onPressed: () => context.push('/assistant'),
                  child: const Text('Ouvrir'),
                ),
              ],
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/quotes/:id/pdf',
        builder: (context, state) => Scaffold(
          body: Center(child: Text('PDF ${state.pathParameters['id']}')),
        ),
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: _overrides(quotesRepo),
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Ouvrir'));
  await _walkToCreer(tester);
}

void main() {
  testWidgets(
    'creating the quote confirms it with its number, PDF and list actions',
    (tester) async {
      await _pumpHome(
        tester,
        FakeQuotesRepository([], createResult: _quote('q1', 'DEV-2026-0007')),
      );

      await tester.tap(find.widgetWithText(FilledButton, 'Créer le devis'));
      await tester.pumpAndSettle();

      // Auto-advanced to the confirmation step — "the quote exists".
      expect(find.text('Votre devis existe'), findsOneWidget);
      expect(find.text('DEV-2026-0007'), findsOneWidget);
      expect(
        find.widgetWithText(OutlinedButton, 'Ouvrir le PDF'),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(FilledButton, 'Voir mes devis'),
        findsOneWidget,
      );
    },
  );

  testWidgets('a creation failure is recoverable with Réessayer', (
    tester,
  ) async {
    await _pumpHome(tester, FakeQuotesRepository([])); // create throws

    await tester.tap(find.widgetWithText(FilledButton, 'Créer le devis'));
    await tester.pumpAndSettle();

    expect(find.textContaining('La création a échoué'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Réessayer'), findsOneWidget);
    // Still on the Créer step — nothing was lost.
    expect(find.text('Votre devis existe'), findsNothing);
  });

  testWidgets(
    'end to end: build a quote, create it, and land on the devis list',
    (tester) async {
      await _pumpRouted(
        tester,
        FakeQuotesRepository([], createResult: _quote('q1', 'DEV-2026-0007')),
      );

      await tester.tap(find.widgetWithText(FilledButton, 'Créer le devis'));
      await tester.pumpAndSettle();
      expect(find.text('DEV-2026-0007'), findsOneWidget);

      final voirDevis = find.widgetWithText(FilledButton, 'Voir mes devis');
      await tester.ensureVisible(voirDevis); // it can sit below the fold
      await tester.pumpAndSettle();
      await tester.tap(voirDevis);
      await tester.pumpAndSettle();
      expect(
        find.text('Mes devis'),
        findsOneWidget,
      ); // left the wizard for the list

      // Re-opening the wizard shows a clean slate — the draft was reset only now,
      // after the full flow succeeded.
      await tester.tap(find.text('Ouvrir'));
      await tester.pumpAndSettle();
      expect(
        find.text('Client de ce devis'),
        findsNothing,
      ); // no client carried over
    },
  );

  testWidgets(
    'an incomplete company identity nudges the artisan (non-blocking)',
    (tester) async {
      await _pumpHome(
        tester,
        FakeQuotesRepository([], createResult: _quote('q1', 'DEV-2026-0007')),
      );

      await tester.tap(find.widgetWithText(FilledButton, 'Créer le devis'));
      await tester.pumpAndSettle();

      // The nudge appears, but the primary actions are still there — never a block.
      expect(find.text('Rendez vos devis encore plus pro'), findsOneWidget);
      expect(
        find.widgetWithText(FilledButton, 'Voir mes devis'),
        findsOneWidget,
      );
    },
  );

  testWidgets('Ouvrir le PDF opens the quote PDF', (tester) async {
    await _pumpRouted(
      tester,
      FakeQuotesRepository([], createResult: _quote('q1', 'DEV-2026-0007')),
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Créer le devis'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(OutlinedButton, 'Ouvrir le PDF'));
    await tester.pumpAndSettle();

    expect(find.text('PDF q1'), findsOneWidget);
  });
}
