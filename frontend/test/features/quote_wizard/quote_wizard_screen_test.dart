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

Future<void> _pump(WidgetTester tester, {List<Client> clients = const []}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        clientsRepositoryProvider.overrideWithValue(FakeClientsRepository([...clients])),
      ],
      child: const MaterialApp(home: QuoteWizardScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

FilledButton _suivant(WidgetTester tester) =>
    tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Suivant'));

void main() {
  testWidgets('opens on the Client step with the progress at 1/7', (tester) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    expect(find.text('Pour quel client faites-vous ce devis ?'), findsOneWidget);
    expect(find.text('Étape 1 / 7'), findsOneWidget);
    expect(find.text('ARTIZEN'), findsOneWidget); // left menu is permanent
  });

  testWidgets('Suivant is gated until a client is chosen, then it advances', (tester) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    // No client yet → Suivant disabled (navigation driven by the draft).
    expect(_suivant(tester).onPressed, isNull);

    await tester.tap(find.text('Dubois'));
    await tester.pumpAndSettle();

    // Client chosen → Suivant enabled → advance to Dossier.
    expect(_suivant(tester).onPressed, isNotNull);
    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Étape 2 / 7'), findsOneWidget);
  });

  testWidgets('cannot jump forward past an incomplete step', (tester) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    await tester.ensureVisible(find.text('Récap'));
    await tester.tap(find.text('Récap'));
    await tester.pumpAndSettle();

    // Blocked: still on step 1.
    expect(find.text('Étape 1 / 7'), findsOneWidget);
  });

  testWidgets('Précédent is disabled on the first step', (tester) async {
    await _pump(tester, clients: [_client('c1', 'Dubois')]);

    final previous = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Précédent'),
    );
    expect(previous.onPressed, isNull);
  });
}
