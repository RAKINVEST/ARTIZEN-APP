import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/catalog/presentation/item_form_screen.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

CatalogCategory _category() => CatalogCategory(
      id: 'cat-1',
      companyId: 'co1',
      name: 'Chauffage',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

Widget _app() {
  return ProviderScope(
    overrides: [
      currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
      catalogRepositoryProvider.overrideWithValue(FakeCatalogRepository([_category()], [])),
    ],
    child: const MaterialApp(home: ItemFormScreen()),
  );
}

void main() {
  testWidgets('category field is first, above the designation (point #1)', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    expect(find.text('Catégorie *'), findsOneWidget);
    expect(find.text('Regroupe des articles de même famille.'), findsOneWidget);
    expect(
      find.text('Un article est un produit ou une prestation utilisé dans vos devis.'),
      findsOneWidget,
    );

    // Category is positioned above the designation field.
    final categoryY = tester.getTopLeft(find.text('Catégorie *')).dy;
    final designationY = tester.getTopLeft(find.text('Désignation *')).dy;
    expect(categoryY, lessThan(designationY));
  });

  testWidgets('fields carry example placeholders (point #1)', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    expect(find.text('Pompe à chaleur Atlantic 8 kW'), findsOneWidget); // designation hint
    expect(find.text('Fourniture et pose avec mise en service.'), findsOneWidget); // description hint
  });

  testWidgets('labour time offers minutes / hours / days (point #6)', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    expect(find.text('Durée estimée'), findsOneWidget);
    // The unit selector defaults to minutes and exposes the three units.
    expect(find.text('min'), findsOneWidget);

    // The field sits below the fold in the test viewport — scroll to it
    // first, otherwise the tap lands outside the render tree.
    await tester.ensureVisible(find.text('min'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('min'));
    await tester.pumpAndSettle();

    // Menu open: all three units are offered.
    expect(find.text('h'), findsWidgets);
    expect(find.text('j'), findsWidgets);
  });
}
