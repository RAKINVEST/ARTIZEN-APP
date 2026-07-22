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

void main() {
  testWidgets('opening the wizard for a client pre-fills the client step',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
          clientsRepositoryProvider
              .overrideWithValue(FakeClientsRepository([_client('c1', 'Dubois')])),
          catalogRepositoryProvider
              .overrideWithValue(FakeCatalogRepository(const [], const [])),
        ],
        // Same route the clients screen navigates to: this client is carried in.
        child: const MaterialApp(
          home: QuoteWizardScreen(preselectClientId: 'c1', preselectClientName: 'Dubois'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The artisan never picked anyone, yet the client step is satisfied — the
    // client is chosen and "Suivant" is enabled, so they go straight to the folder.
    expect(find.text('Dubois'), findsWidgets);
    final suivant =
        tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Suivant'));
    expect(suivant.onPressed, isNotNull);
  });
}
