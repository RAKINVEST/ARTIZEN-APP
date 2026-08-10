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

Widget _editing(CatalogItem item, List<CatalogCategory> categories) =>
    _editingWith(FakeCatalogRepository(categories, const []), item, categories);

Widget _editingWith(
  FakeCatalogRepository repo,
  CatalogItem item,
  List<CatalogCategory> categories,
) =>
    ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        catalogRepositoryProvider.overrideWithValue(repo),
        // Supply the edited item directly, so the form loads it without driving
        // the whole paged catalogue list in the test.
        itemByIdProvider(item.id).overrideWithValue(item),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: ItemFormScreen(itemId: item.id),
      ),
    );

Widget _creating(List<CatalogCategory> categories) => ProviderScope(
      overrides: [
        currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
        catalogRepositoryProvider
            .overrideWithValue(FakeCatalogRepository(categories, const [])),
      ],
      child: MaterialApp(theme: AppTheme.light(), home: const ItemFormScreen()),
    );

/// Records the input handed to updateItem, then throws so `_save` stops before
/// `context.pop()` (there is no router in these tests). The test only checks
/// which unit code was submitted.
class _RecordingCatalog extends FakeCatalogRepository {
  _RecordingCatalog(super.categories, super.items);

  CatalogItemInput? updated;

  @override
  Future<CatalogItem> updateItem(String id, CatalogItemInput input) async {
    updated = input;
    throw Exception('recorded');
  }
}

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

  // --- Friendly unit picker (V1.1) ---

  testWidgets('the article form offers friendly unit labels instead of free text',
      (tester) async {
    // Tall viewport so the unit field (below the fold in a 600px test window)
    // is on-screen and tappable.
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_creating([_category('cat1', 'Plomberie')]));
    await tester.pumpAndSettle();

    // New article: the default unit shows as a plain-French label.
    expect(find.text('À la pièce'), findsOneWidget);

    // Opening the picker reveals the other labels (no jargon like "ml").
    await tester.tap(find.text('À la pièce'));
    await tester.pumpAndSettle();
    expect(find.text('Au mètre'), findsWidgets);
    expect(find.text('Au m²'), findsWidgets);
    expect(find.text('Au forfait'), findsWidgets);
  });

  testWidgets('editing an article shows its unit as a friendly label', (tester) async {
    // The seeded item's unit is "unité" → shown as "À la pièce".
    await tester.pumpWidget(
      _editing(_item('i1', 'cat1', 'Coude'), [_category('cat1', 'Plomberie')]),
    );
    await tester.pumpAndSettle();

    expect(find.text('À la pièce'), findsOneWidget);
  });

  testWidgets('a legacy unit outside the list is preserved when editing', (tester) async {
    // Seeds use "ml", "m³", "jour"… — not one of the 7 friendly labels. Editing
    // must keep the exact value, never rewrite it silently.
    final legacy = _item('i1', 'cat1', 'Gaine').copyWith(unit: 'ml');
    await tester.pumpWidget(_editing(legacy, [_category('cat1', 'Plomberie')]));
    await tester.pumpAndSettle();

    expect(find.text('ml'), findsOneWidget); // raw value kept as a selectable option
  });

  testWidgets('selecting a unit and saving submits its code (unité → m)', (tester) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final recorder = _RecordingCatalog([_category('cat1', 'Plomberie')], const []);
    await tester.pumpWidget(
      _editingWith(recorder, _item('i1', 'cat1', 'Coude'), [_category('cat1', 'Plomberie')]),
    );
    await tester.pumpAndSettle();

    // Change the unit from "À la pièce" to "Au mètre".
    await tester.tap(find.text('À la pièce'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Au mètre').last);
    await tester.pumpAndSettle();

    // Save (designation/price/VAT are pre-filled from the edited item).
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    // The stored value is the short code, not the label.
    expect(recorder.updated?.unit, 'm');
  });
}
