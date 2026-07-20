import 'package:artizen/features/quote_wizard/presentation/quote_wizard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('opens on the Client step with the progress at 1/7', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: QuoteWizardScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Pour quel client faites-vous ce devis ?'), findsOneWidget);
    expect(find.text('Étape 1 / 7'), findsOneWidget);
    // Left menu is present (permanent).
    expect(find.text('ARTIZEN'), findsOneWidget);
  });

  testWidgets('Suivant advances the step, Précédent goes back', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: QuoteWizardScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Dans quel dossier de votre catalogue piochez-vous ?'), findsOneWidget);
    expect(find.text('Étape 2 / 7'), findsOneWidget);

    await tester.tap(find.text('Précédent'));
    await tester.pumpAndSettle();
    expect(find.text('Étape 1 / 7'), findsOneWidget);
  });

  testWidgets('Précédent is disabled on the first step', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: QuoteWizardScreen()));
    await tester.pumpAndSettle();

    final previous = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Précédent'),
    );
    expect(previous.onPressed, isNull);
  });

  testWidgets('tapping a step in the progress bar jumps to it', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: QuoteWizardScreen()));
    await tester.pumpAndSettle();

    // The progress bar exposes every step label; tap "Récap" (step 5).
    await tester.tap(find.text('Récap'));
    await tester.pumpAndSettle();

    expect(find.text('Vérifiez les montants avant de créer.'), findsOneWidget);
    expect(find.text('Étape 5 / 7'), findsOneWidget);
  });
}
