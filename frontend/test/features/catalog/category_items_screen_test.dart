import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/catalog/presentation/category_items_screen.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

CatalogItem _item(String id, String categoryId, String designation) => CatalogItem(
      id: id,
      companyId: 'co1',
      categoryId: categoryId,
      designation: designation,
      itemType: ItemType.product,
      unit: 'unité',
      unitPriceHt: '10.00',
      vatRate: '20.00',
      active: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

void main() {
  testWidgets('lists only the opened folder\'s articles', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
          catalogRepositoryProvider.overrideWithValue(
            FakeCatalogRepository(const [], [
              _item('i1', 'cat1', 'WC suspendu'),
              _item('i2', 'cat2', 'Radiateur'),
            ]),
          ),
        ],
        child: const MaterialApp(
          home: CategoryItemsScreen(categoryId: 'cat1', categoryName: 'Sanitaires'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sanitaires'), findsOneWidget); // the app bar names the folder
    expect(find.text('WC suspendu'), findsOneWidget); // its own article
    expect(find.text('Radiateur'), findsNothing); // an article of another folder
  });

  testWidgets('an empty folder says so', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
          catalogRepositoryProvider
              .overrideWithValue(FakeCatalogRepository(const [], const [])),
        ],
        child: const MaterialApp(
          home: CategoryItemsScreen(categoryId: 'cat1', categoryName: 'Vide'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Ce dossier ne contient aucun article'), findsOneWidget);
  });
}
