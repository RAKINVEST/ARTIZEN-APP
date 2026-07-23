import 'package:artizen/features/dashboard/presentation/widgets/quick_access_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('is a permanent "Bienvenue" panel with three clickable tiles',
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

    // Every tile is present and stays clickable. "Ajouter un client" moved out
    // of here to the Clients screen, so it is no longer one of these tiles.
    for (final label in const [
      'Configurer mon entreprise',
      'Mes catalogues',
      'Ma caisse à outils',
    ]) {
      final inkWell = tester.widget<InkWell>(
        find.ancestor(of: find.text(label), matching: find.byType(InkWell)),
      );
      expect(inkWell.onTap, isNotNull, reason: '"$label" must be clickable');
    }
    expect(find.text('Ajouter un client'), findsNothing);
  });
}
