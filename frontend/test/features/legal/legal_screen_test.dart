import 'package:artizen/core/config/support_config.dart';
import 'package:artizen/features/legal/presentation/legal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Hosts a legal screen with the support address stubbed from the single source
/// (supportEmailProvider), so no real network is touched.
Widget _host(LegalDoc doc, {String supportEmail = 'contact@test.io'}) => ProviderScope(
      overrides: [supportEmailProvider.overrideWith((ref) => Future.value(supportEmail))],
      child: MaterialApp(home: LegalDocumentScreen(doc: doc)),
    );

void main() {
  testWidgets('shows the title, a draft banner and the body', (tester) async {
    await tester.pumpWidget(_host(legalCgu));
    await tester.pumpAndSettle();

    expect(find.text("Conditions Générales d'Utilisation"), findsOneWidget); // app bar
    expect(find.text('Document provisoire'), findsOneWidget);
    expect(find.byType(SelectableText), findsOneWidget);
  });

  testWidgets('substitutes {email} with the single-source support address', (tester) async {
    await tester.pumpWidget(_host(legalConfidentialite, supportEmail: 'aide@artizen-qa.io'));
    await tester.pumpAndSettle();

    final body = tester.widget<SelectableText>(find.byType(SelectableText)).data!;
    expect(body, contains('aide@artizen-qa.io'));
    expect(body, isNot(contains('{email}')));
  });

  test('the three legal documents each have a title and a substantial body', () {
    for (final doc in [legalMentions, legalCgu, legalConfidentialite]) {
      expect(doc.title, isNotEmpty);
      expect(doc.body.length, greaterThan(100));
    }
  });
}
