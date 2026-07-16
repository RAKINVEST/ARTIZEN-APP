import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CatalogItem', () {
    test('fromJson parses item_type and keeps decimal fields as strings', () {
      final json = {
        'id': 'i1',
        'company_id': 'co1',
        'category_id': 'cat1',
        'code': null,
        'designation': 'Chauffe-eau Atlantic 200 L',
        'description': null,
        'item_type': 'product',
        'unit': 'unité',
        'unit_price_ht': '450.00',
        'vat_rate': '20.00',
        'estimated_duration_minutes': null,
        'active': true,
        'created_at': '2026-01-01T10:00:00Z',
        'updated_at': '2026-01-01T10:00:00Z',
      };

      final item = CatalogItem.fromJson(json);

      expect(item.itemType, ItemType.product);
      // Kept as String, not parsed to double: Flutter never computes with
      // these, only displays them (see core/utils/currency.dart).
      expect(item.unitPriceHt, '450.00');
      expect(item.unitPriceHt, isA<String>());
      expect(item.active, isTrue);
    });

    test('itemType round-trips through toJson using the backend\'s lowercase values', () {
      const input = CatalogItemInput(
        categoryId: 'cat1',
        designation: 'Main-d\'oeuvre plomberie',
        itemType: ItemType.service,
        unit: 'heure',
        unitPriceHt: '45.00',
        vatRate: '20.00',
      );

      final json = input.toJson();

      expect(json['item_type'], 'service');
    });
  });

  group('CatalogCategory', () {
    test('fromJson parses a category without a description', () {
      final category = CatalogCategory.fromJson({
        'id': 'cat1',
        'company_id': 'co1',
        'name': 'Plomberie',
        'description': null,
        'created_at': '2026-01-01T10:00:00Z',
        'updated_at': '2026-01-01T10:00:00Z',
      });

      expect(category.name, 'Plomberie');
      expect(category.description, isNull);
    });
  });
}
