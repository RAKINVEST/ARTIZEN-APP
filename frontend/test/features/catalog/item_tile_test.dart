import 'package:artizen/core/theme/app_theme.dart';
import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/presentation/widgets/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

CatalogItem _item({required bool favorite}) => CatalogItem(
      id: 'i1',
      companyId: 'co1',
      categoryId: 'cat1',
      designation: 'Clé à molette',
      itemType: ItemType.product,
      unit: 'unité',
      unitPriceHt: '10.00',
      vatRate: '20.00',
      active: true,
      isFavorite: favorite,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

Widget _host(ItemTile tile) =>
    MaterialApp(theme: AppTheme.light(), home: Scaffold(body: tile));

void main() {
  testWidgets('offers to add a non-favorite to the toolbox and fires the toggle',
      (tester) async {
    var toggled = 0;
    await tester.pumpWidget(
      _host(
        ItemTile(
          item: _item(favorite: false),
          onTap: () {},
          onDeactivate: () {},
          onReactivate: () {},
          onToggleFavorite: () => toggled++,
        ),
      ),
    );

    expect(find.byTooltip('Ajouter à ma caisse à outils'), findsOneWidget);
    expect(find.byTooltip('Retirer de ma caisse à outils'), findsNothing);

    await tester.tap(find.byTooltip('Ajouter à ma caisse à outils'));
    await tester.pump();
    expect(toggled, 1);
  });

  testWidgets('a favorite article offers to be taken out of the toolbox',
      (tester) async {
    await tester.pumpWidget(
      _host(
        ItemTile(
          item: _item(favorite: true),
          onTap: () {},
          onDeactivate: () {},
          onReactivate: () {},
          onToggleFavorite: () {},
        ),
      ),
    );

    expect(find.byTooltip('Retirer de ma caisse à outils'), findsOneWidget);
  });
}
