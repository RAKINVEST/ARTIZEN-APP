import 'package:artizen/features/legal/presentation/legal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LegalDocumentScreen shows the title, a draft banner and a body', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LegalDocumentScreen(doc: legalCgu)));

    expect(find.text("Conditions Générales d'Utilisation"), findsOneWidget); // app bar
    // The provisional-status banner keeps the draft honest until legal validates.
    expect(find.text('Document provisoire'), findsOneWidget);
    expect(find.byType(SelectableText), findsOneWidget);
  });

  test('the three legal documents each have a title and a substantial body', () {
    for (final doc in [legalMentions, legalCgu, legalConfidentialite]) {
      expect(doc.title, isNotEmpty);
      expect(doc.body.length, greaterThan(100));
    }
  });
}
