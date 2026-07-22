import 'package:artizen/core/theme/app_theme.dart';
import 'package:artizen/core/widgets/app_components.dart';
import 'package:artizen/features/clients/data/client_model.dart';
import 'package:artizen/features/clients/presentation/widgets/client_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Client _client(String id, String name) => Client(
      id: id,
      companyId: 'co1',
      lastName: name,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

Future<void> _pump(WidgetTester tester, ClientTile tile) async {
  // A comfortable width so the three action buttons lay out without wrapping.
  tester.view.physicalSize = const Size(1400, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(theme: AppTheme.light(), home: Scaffold(body: tile)),
  );
}

void main() {
  testWidgets('shows the three actions and fires the right callback for each',
      (tester) async {
    var created = 0, edited = 0, deleted = 0;
    await _pump(
      tester,
      ClientTile(
        client: _client('c1', 'Dubois'),
        onCreateQuote: () => created++,
        onEdit: () => edited++,
        onDelete: () => deleted++,
      ),
    );

    expect(find.widgetWithText(GradientButton, 'Créer un devis'), findsOneWidget);
    expect(find.widgetWithText(GradientButton, 'Modifier'), findsOneWidget);
    expect(find.widgetWithText(GradientButton, 'Supprimer'), findsOneWidget);

    await tester.tap(find.text('Créer un devis'));
    await tester.tap(find.text('Modifier'));
    await tester.tap(find.text('Supprimer'));
    await tester.pump();

    expect(created, 1);
    expect(edited, 1);
    expect(deleted, 1);
  });

  testWidgets('each action carries its gradient: create / edit / delete',
      (tester) async {
    await _pump(
      tester,
      ClientTile(
        client: _client('c1', 'Dubois'),
        onCreateQuote: () {},
        onEdit: () {},
        onDelete: () {},
      ),
    );

    List<Color> gradient(String label) => tester
        .widget<GradientButton>(find.widgetWithText(GradientButton, label))
        .gradient;

    expect(gradient('Créer un devis'), ArtizenGradients.create); // bleu
    expect(gradient('Modifier'), ArtizenGradients.edit); // orange
    expect(gradient('Supprimer'), ArtizenGradients.delete); // rouge
  });
}
