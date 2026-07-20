import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/clients/data/client_model.dart';
import 'package:artizen/features/clients/data/clients_repository_impl.dart';
import 'package:artizen/features/quotes/data/quote_models.dart';
import 'package:artizen/features/quotes/data/quotes_repository_impl.dart';
import 'package:artizen/features/quotes/domain/quotes_repository.dart';
import 'package:artizen/features/quotes/presentation/quote_form_screen.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../support/fake_repositories.dart';

Client _client() => Client(
      id: 'c1',
      companyId: 'co1',
      lastName: 'Dupont',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

CatalogCategory _category() => CatalogCategory(
      id: 'cat-1',
      companyId: 'co1',
      name: 'Chauffage',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

CatalogItem _item() => CatalogItem(
      id: 'item-1',
      companyId: 'co1',
      categoryId: 'cat-1',
      designation: 'Pompe à chaleur Atlantic 8 kW',
      itemType: ItemType.product,
      unit: 'u',
      unitPriceHt: '100.00',
      vatRate: '20.00',
      active: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

/// Records the create() call and returns a canned quote, so the test can
/// assert the exact lines that were submitted (bug #4).
class RecordingQuotesRepository implements QuotesRepository {
  String? lastClientId;
  List<QuoteLineInput>? lastLines;

  @override
  Future<Quote> create({
    required String companyId,
    required String clientId,
    required List<QuoteLineInput> lines,
  }) async {
    lastClientId = clientId;
    lastLines = lines;
    return Quote(
      id: 'q1',
      companyId: companyId,
      clientId: clientId,
      totalHt: '200.00',
      totalVat: '40.00',
      totalTtc: '240.00',
      lines: const [],
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );
  }

  @override
  Future<List<Quote>> list({required String companyId}) async => [];

  @override
  Future<Quote> get(String id) async => throw UnimplementedError();
}

Widget _app(RecordingQuotesRepository quotesRepo) {
  final router = GoRouter(
    initialLocation: '/quotes/new',
    routes: [
      GoRoute(path: '/quotes/new', builder: (context, state) => const QuoteFormScreen()),
      GoRoute(
        path: '/quotes/:id',
        builder: (context, state) => const Scaffold(body: Text('DETAIL PAGE')),
      ),
    ],
  );

  return ProviderScope(
    overrides: [
      currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
      clientsRepositoryProvider.overrideWithValue(FakeClientsRepository([_client()])),
      catalogRepositoryProvider.overrideWithValue(
        FakeCatalogRepository([_category()], [_item()]),
      ),
      quotesRepositoryProvider.overrideWithValue(quotesRepo),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  testWidgets(
    'full quote flow: pick client, add article (it appears), edit quantity '
    '(total recomputes), create the quote',
    (tester) async {
      final quotesRepo = RecordingQuotesRepository();
      await tester.pumpWidget(_app(quotesRepo));
      await tester.pumpAndSettle();

      // --- Bug #4 precondition: the button is disabled with no client/line.
      final createButton = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Créer le devis'),
      );
      expect(createButton.onPressed, isNull);

      // --- Pick a client.
      await tester.tap(find.text('Sélectionner un client'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dupont'));
      await tester.pumpAndSettle();
      expect(find.text('Dupont'), findsOneWidget); // now shown on the client tile

      // --- Bug #3: add an article; it must actually appear in the quote.
      await tester.tap(find.text('Ajouter un article'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pompe à chaleur Atlantic 8 kW'));
      await tester.pumpAndSettle();
      expect(find.text('Pompe à chaleur Atlantic 8 kW'), findsOneWidget);

      // Quantity defaults to 1 -> line + quote total = 120,00 € TTC.
      expect(find.textContaining('120,00'), findsWidgets);

      // --- Bug #5: change the quantity to 2 -> the total must recompute.
      await tester.enterText(find.byType(TextFormField), '2');
      await tester.pumpAndSettle();
      expect(find.textContaining('240,00'), findsWidgets); // 2 × 120 TTC
      expect(find.textContaining('120,00'), findsNothing);

      // --- Bug #4: create the quote.
      await tester.ensureVisible(find.widgetWithText(FilledButton, 'Créer le devis'));
      await tester.tap(find.widgetWithText(FilledButton, 'Créer le devis'));
      await tester.pumpAndSettle();

      // Navigated to the detail page...
      expect(find.text('DETAIL PAGE'), findsOneWidget);
      // ...and the submitted line carried the edited quantity.
      expect(quotesRepo.lastClientId, 'c1');
      expect(quotesRepo.lastLines, hasLength(1));
      expect(quotesRepo.lastLines!.single.catalogItemId, 'item-1');
      expect(quotesRepo.lastLines!.single.quantity, '2');
    },
  );
}
