import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/quotes/presentation/quotes_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

CatalogItem _item(String id) => CatalogItem(
      id: id,
      companyId: 'co1',
      categoryId: 'cat-1',
      designation: 'Article $id',
      itemType: ItemType.service,
      unit: 'u',
      unitPriceHt: '100.00',
      vatRate: '20.00',
      active: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

void main() {
  test('addLine appends a draft line (bug #3: the article must appear)', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(quoteDraftLinesProvider.notifier);
    expect(container.read(quoteDraftLinesProvider), isEmpty);

    notifier.addLine(_item('a'), '1');

    final lines = container.read(quoteDraftLinesProvider);
    expect(lines, hasLength(1));
    expect(lines.first.item.id, 'a');
    expect(lines.first.quantity, '1');
  });

  test('updateQuantityAt changes only the targeted line (bug #5: editable quantity)', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(quoteDraftLinesProvider.notifier)
      ..addLine(_item('a'), '1')
      ..addLine(_item('b'), '1');

    notifier.updateQuantityAt(0, '3');

    final lines = container.read(quoteDraftLinesProvider);
    expect(lines[0].quantity, '3');
    expect(lines[1].quantity, '1');
    // The item reference is preserved, only the quantity changed.
    expect(lines[0].item.id, 'a');
  });

  test('updateQuantityAt ignores out-of-range indices', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(quoteDraftLinesProvider.notifier)..addLine(_item('a'), '1');
    notifier.updateQuantityAt(5, '9'); // no-op, must not throw

    expect(container.read(quoteDraftLinesProvider).single.quantity, '1');
  });

  test('removeLineAt and clear empty the draft', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(quoteDraftLinesProvider.notifier)
      ..addLine(_item('a'), '1')
      ..addLine(_item('b'), '2');

    notifier.removeLineAt(0);
    expect(container.read(quoteDraftLinesProvider).single.item.id, 'b');

    notifier.clear();
    expect(container.read(quoteDraftLinesProvider), isEmpty);
  });
}
