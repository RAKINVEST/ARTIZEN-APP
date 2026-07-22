import 'package:artizen/features/dashboard/presentation/widgets/quick_access_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('is a permanent "Bienvenue" panel with four clickable tiles',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: QuickAccessCard()),
        ),
      ),
    );

    // Header is just "Bienvenue" — the onboarding wording and its "Masquer"
    // escape hatch are gone (this panel never disappears).
    expect(find.text('Bienvenue'), findsOneWidget);
    expect(find.textContaining('Voici comment démarrer'), findsNothing);
    expect(find.text('Masquer'), findsNothing);

    // Every tile is present and stays clickable — including the ones that used
    // to grey out once "done" (configure company, add client).
    for (final label in const [
      'Configurer mon entreprise',
      'Mes catalogues',
      'Ma caisse à outils',
      'Ajouter un client',
    ]) {
      final tile = tester.widget<ListTile>(
        find.ancestor(of: find.text(label), matching: find.byType(ListTile)),
      );
      expect(tile.onTap, isNotNull, reason: '"$label" must be clickable');
    }
  });
}
