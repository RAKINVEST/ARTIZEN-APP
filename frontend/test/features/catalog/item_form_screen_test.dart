import 'package:artizen/core/theme/app_theme.dart';
import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/catalog/presentation/catalog_providers.dart';
import 'package:artizen/features/catalog/presentation/item_form_screen.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

CatalogCategory _category(String id, String name) => CatalogCategory(
      id: id,
      companyId: 'co1',
      name: name,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

CatalogItem _item(String id, String categoryId, String designation) => CatalogItem(
      id: id,
      companyId: 'co1',
      categoryId: categoryId,
      designation: designation,
      itemType: ItemType.product,
      unit: 'unité',
      unitPriceHt: '10.00',
      vatRate: '10.00',
      active: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

Widget _editing(CatalogItem item, List<CatalogCategory> categories) => ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        catalogRepositoryProvider
            .overrideWithValue(FakeCatalogRepository(categories, const [])),
        // Supply the edited item directly, so the form loads it without driving
        // the whole paged catalogue list in the test.
        itemByIdProvider(item.id).overrideWithValue(item),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: ItemFormScreen(itemId: item.id),
      ),
    );

void main() {
  testWidgets('editing an article whose folder is not in the loaded list does not crash',
      (tester) async {
    // The bug: only the first page of folders was loaded, so an article whose
    // folder sat past it handed the category dropdown a value with no matching
    // item — an assertion, and a red screen. Reproduce it with an absent folder.
    await tester.pumpWidget(
      _editing(
        _item('i1', 'cat-absent', 'WC suspendu'),
        [_category('cat1', 'Sanitaires'), _category('cat2', 'Chauffage')],
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Modifier l\'article'), findsOneWidget); // the form rendered
    expect(find.text('WC suspendu'), findsOneWidget); // designation prefilled
  });

  testWidgets('editing an article shows its own folder selected when present',
      (tester) async {
    await tester.pumpWidget(
      _editing(
        _item('i1', 'cat2', 'Radiateur'),
        [_category('cat1', 'Sanitaires'), _category('cat2', 'Chauffage')],
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    // The dropdown shows the article's real folder, not a fallback.
    expect(find.text('Chauffage'), findsOneWidget);
  });
}
