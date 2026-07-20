import 'package:artizen/core/utils/search_text.dart';
import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/domain/catalog_tree.dart';
import 'package:flutter_test/flutter_test.dart';

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

CatalogItem _item(String id, String designation, String categoryId, {String? code}) => CatalogItem(
      id: id,
      companyId: 'co1',
      categoryId: categoryId,
      designation: designation,
      code: code,
      itemType: ItemType.product,
      unit: 'u',
      unitPriceHt: '0.00',
      vatRate: '20.00',
      active: true,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

/// 📁 Plombier → 📂 Tubes / 📂 Évacuation
List<CatalogCategory> _categories() => [
      _cat('root', 'Plombier'),
      _cat('tubes', 'Tubes', parentId: 'root', sortOrder: 0),
      _cat('evac', 'Évacuation', parentId: 'root', sortOrder: 1),
    ];

List<CatalogItem> _items() => [
      _item('i1', 'Tube PER', 'tubes'),
      _item('i2', 'Tube cuivre', 'tubes'),
      _item('i3', 'Siphon', 'evac', code: 'SIPH-40'),
    ];

void main() {
  group('normalizeForSearch', () {
    test('lowercases and strips French accents', () {
      expect(normalizeForSearch('Évacuation'), 'evacuation');
      expect(normalizeForSearch('Chauffe-eau'), 'chauffe-eau');
      expect(normalizeForSearch('Maçonnerie'), 'maconnerie');
      expect(normalizeForSearch('Cœur'), 'coeur');
    });

    test('matchesQuery ignores case and accents', () {
      expect(matchesQuery('Évacuation', normalizeForSearch('evac')), isTrue);
      expect(matchesQuery('Chauffe-eau', normalizeForSearch('CHAUFF')), isTrue);
      expect(matchesQuery('Tube PER', normalizeForSearch('per')), isTrue);
      expect(matchesQuery('Tube PER', normalizeForSearch('zzz')), isFalse);
    });
  });

  group('buildCatalogTree', () {
    test('nests sub-categories under their parent and attaches items', () {
      final tree = buildCatalogTree(_categories(), _items());

      expect(tree, hasLength(1));
      final root = tree.single;
      expect(root.category.name, 'Plombier');
      expect(root.items, isEmpty); // articles live in the sub-folders
      expect(root.children.map((c) => c.category.name), ['Tubes', 'Évacuation']);

      final tubes = root.children.first;
      // Articles within a folder are sorted alphabetically.
      expect(tubes.items.map((i) => i.designation), ['Tube cuivre', 'Tube PER']);
    });

    test('orders children by sortOrder, not alphabetically', () {
      // "Évacuation" sorts before "Tubes" alphabetically but has sortOrder 1.
      final tree = buildCatalogTree(_categories(), _items());
      expect(tree.single.children.map((c) => c.category.name), ['Tubes', 'Évacuation']);
    });

    test('totalItemCount counts the whole branch', () {
      final tree = buildCatalogTree(_categories(), _items());
      expect(tree.single.totalItemCount, 3);
      expect(tree.single.children.first.totalItemCount, 2);
    });

    test('treats a category with an unknown parent as a root (never hides items)', () {
      final orphan = _cat('orphan', 'Orpheline', parentId: 'disparue');
      final tree = buildCatalogTree([..._categories(), orphan], _items());
      expect(tree.map((n) => n.category.name), containsAll(['Plombier', 'Orpheline']));
    });
  });

  group('searchCatalogItems', () {
    test('finds an article by designation', () {
      final hits = searchCatalogItems(_categories(), _items(), 'PER');
      expect(hits.map((h) => h.item.designation), ['Tube PER']);
      expect(hits.single.categoryPath, 'Plombier › Tubes');
    });

    test('finds an article by its code', () {
      final hits = searchCatalogItems(_categories(), _items(), 'siph-40');
      expect(hits.map((h) => h.item.designation), ['Siphon']);
    });

    test('finds articles through their folder name, accent-insensitively', () {
      // "Siphon" contains no "evac" — it matches via its 📂 Évacuation folder.
      final hits = searchCatalogItems(_categories(), _items(), 'evacuation');
      expect(hits.map((h) => h.item.designation), ['Siphon']);
    });

    test('an empty query returns nothing (the tree is shown instead)', () {
      expect(searchCatalogItems(_categories(), _items(), '   '), isEmpty);
    });

    test('results are sorted by designation', () {
      final hits = searchCatalogItems(_categories(), _items(), 'tube');
      expect(hits.map((h) => h.item.designation), ['Tube cuivre', 'Tube PER']);
    });
  });
}
