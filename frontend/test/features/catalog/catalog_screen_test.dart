import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/catalog/presentation/catalog_screen.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

CatalogCategory _cat(String id, String name, {String? parentId, int sortOrder = 0}) =>
    CatalogCategory(
      id: id,
      companyId: 'co1',
      name: name,
      parentId: parentId,
      sortOrder: sortOrder,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

CatalogItem _item(String id, String designation, String categoryId) => CatalogItem(
      id: id,
      companyId: 'co1',
      categoryId: categoryId,
      designation: designation,
      itemType: ItemType.product,
      unit: 'u',
      unitPriceHt: '10.00',
      vatRate: '20.00',
      active: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

/// 📁 Plombier → 📂 Tubes (Tube PER) / 📂 Évacuation (Siphon)
Widget _app({bool empty = false}) {
  final categories = empty
      ? <CatalogCategory>[]
      : [
          _cat('root', 'Plombier'),
          _cat('tubes', 'Tubes', parentId: 'root', sortOrder: 0),
          _cat('evac', 'Évacuation', parentId: 'root', sortOrder: 1),
        ];
  final items = empty
      ? <CatalogItem>[]
      : [_item('i1', 'Tube PER', 'tubes'), _item('i2', 'Siphon', 'evac')];

  return ProviderScope(
    overrides: [
      currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
      catalogRepositoryProvider.overrideWithValue(FakeCatalogRepository(categories, items)),
    ],
    child: const MaterialApp(home: CatalogScreen()),
  );
}

void main() {
  testWidgets('Catégories tab comes before Articles', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    final tabLabels = tester.widgetList<Tab>(find.byType(Tab)).map((t) => t.text).toList();
    expect(tabLabels, ['Catégories', 'Articles']);
  });

  testWidgets('Articles tab shows the métier tree, folders collapsed', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Articles'));
    await tester.pumpAndSettle();

    // The métier folder is expanded, its sub-folders are visible…
    expect(find.text('Plombier'), findsOneWidget);
    expect(find.text('Tubes'), findsOneWidget);
    expect(find.text('Évacuation'), findsOneWidget);
    // …but the articles inside them stay hidden until you open a sub-folder.
    expect(find.text('Tube PER'), findsNothing);
  });

  testWidgets('opening a sub-folder reveals its articles', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Articles'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tubes'));
    await tester.pumpAndSettle();

    expect(find.text('Tube PER'), findsOneWidget);
  });

  testWidgets('search finds an article without opening any folder', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Articles'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'PER');
    await tester.pumpAndSettle();

    expect(find.text('Tube PER'), findsOneWidget);
    expect(find.text('Plombier › Tubes'), findsOneWidget); // shows where it lives
    expect(find.text('Siphon'), findsNothing);
  });

  testWidgets('search matches the folder name, accent-insensitively', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Articles'));
    await tester.pumpAndSettle();

    // "Siphon" has no "evacuation" in its name — it matches via its folder.
    await tester.enterText(find.byType(TextField), 'evacuation');
    await tester.pumpAndSettle();

    expect(find.text('Siphon'), findsOneWidget);
    expect(find.text('Tube PER'), findsNothing);
  });

  testWidgets('an empty catalog offers to install a trade pack', (tester) async {
    await tester.pumpWidget(_app(empty: true));
    await tester.pumpAndSettle();

    expect(find.text('Votre catalogue est vide'), findsOneWidget);
    expect(find.text('Choisir mon métier'), findsOneWidget);
  });
}
