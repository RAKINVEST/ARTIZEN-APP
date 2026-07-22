import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/catalog/presentation/toolbox_screen.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

CatalogItem _item(String id, String designation, {required bool favorite}) => CatalogItem(
      id: id,
      companyId: 'co1',
      categoryId: 'cat1',
      designation: designation,
      itemType: ItemType.product,
      unit: 'unité',
      unitPriceHt: '10.00',
      vatRate: '20.00',
      active: true,
      isFavorite: favorite,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

Widget _app(FakeCatalogRepository repo) => ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        catalogRepositoryProvider.overrideWithValue(repo),
      ],
      child: const MaterialApp(home: ToolboxScreen()),
    );

void main() {
  testWidgets('lists only the starred articles', (tester) async {
    await tester.pumpWidget(
      _app(
        FakeCatalogRepository(const [], [
          _item('i1', 'Clé à molette', favorite: true),
          _item('i2', 'Tournevis', favorite: false),
        ]),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Clé à molette'), findsOneWidget);
    expect(find.text('Tournevis'), findsNothing);
  });

  testWidgets('an empty toolbox explains how to fill it', (tester) async {
    await tester.pumpWidget(_app(FakeCatalogRepository(const [], const [])));
    await tester.pumpAndSettle();

    expect(find.textContaining('Ta caisse à outils est vide'), findsOneWidget);
  });

  testWidgets('removing an article takes it out of the toolbox', (tester) async {
    await tester.pumpWidget(
      _app(
        FakeCatalogRepository(const [], [
          _item('i1', 'Clé à molette', favorite: true),
        ]),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Clé à molette'), findsOneWidget);
    await tester.tap(find.byTooltip('Retirer de ma caisse à outils'));
    await tester.pumpAndSettle();

    expect(find.text('Clé à molette'), findsNothing);
    expect(find.textContaining('Ta caisse à outils est vide'), findsOneWidget);
  });
}
