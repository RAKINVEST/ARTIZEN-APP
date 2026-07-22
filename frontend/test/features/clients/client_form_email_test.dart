import 'package:artizen/features/clients/data/clients_repository_impl.dart';
import 'package:artizen/features/clients/presentation/client_form_screen.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

void main() {
  testWidgets('a malformed client email is caught inline and blocks the save',
      (tester) async {
    // Tall viewport so the submit button (bottom of the form) is reachable.
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
          clientsRepositoryProvider.overrideWithValue(FakeClientsRepository([])),
        ],
        child: const MaterialApp(home: ClientFormScreen()),
      ),
    );
    await tester.pumpAndSettle();

    // Fields, in order: Nom, Prénom, Société, Adresse, Téléphone, Email, Notes.
    final fields = find.descendant(of: find.byType(Form), matching: find.byType(EditableText));
    await tester.enterText(fields.at(0), 'Durand'); // Nom (required)
    await tester.enterText(fields.at(5), 'pas-un-email'); // Email (malformed)
    await tester.pump();

    await tester.tap(find.text('Créer le client'));
    await tester.pumpAndSettle();

    // Inline error shown, and the form did not proceed (still on the form).
    expect(find.text('Adresse email invalide'), findsOneWidget);
    expect(find.text('Créer le client'), findsOneWidget);
  });
}
