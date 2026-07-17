import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

Map<String, dynamic> _itemJson({required bool active}) => {
  'id': 'i1',
  'company_id': 'co1',
  'category_id': 'cat1',
  'code': null,
  'designation': 'Pose carrelage',
  'description': null,
  'item_type': 'service',
  'unit': 'm2',
  'unit_price_ht': '45.00',
  'vat_rate': '20.00',
  'estimated_duration_minutes': null,
  'active': active,
  'created_at': '2026-01-01T10:00:00',
  'updated_at': '2026-01-01T10:00:00',
};

void main() {
  late MockDio dio;
  late CatalogRepositoryImpl repository;

  setUp(() {
    dio = MockDio();
    repository = CatalogRepositoryImpl(dio);
  });

  group('reactivateItem', () {
    test('sends only {"active": true}, leaving every other field untouched', () async {
      // The backend applies exclude_unset, so anything sent here is
      // written. Sending a whole item to flip one boolean would silently
      // overwrite fields the caller never meant to touch — hence the bare
      // body, and hence this test pinning it.
      when(
        () => dio.put<Map<String, dynamic>>('/catalog/items/i1', data: {'active': true}),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/catalog/items/i1'),
          statusCode: 200,
          data: _itemJson(active: true),
        ),
      );

      final item = await repository.reactivateItem('i1');

      expect(item.active, isTrue);
      verify(
        () => dio.put<Map<String, dynamic>>('/catalog/items/i1', data: {'active': true}),
      ).called(1);
    });
  });

  group('CatalogItemInput', () {
    test('omits active when null, so an ordinary edit never clears it', () {
      // CatalogItem.active is NOT NULL. With this class's includeIfNull:
      // true, an unguarded `active` would serialize as null on every edit
      // and the backend's exclude_unset would set the column to NULL — a
      // 500 on any item edit.
      const input = CatalogItemInput(
        categoryId: 'cat1',
        designation: 'Pose carrelage',
        itemType: ItemType.service,
        unit: 'm2',
        unitPriceHt: '45.00',
        vatRate: '20.00',
      );

      final json = input.toJson();

      expect(json.containsKey('active'), isFalse);
    });

    test('sends the other null fields explicitly, so clearing one clears it', () {
      const input = CatalogItemInput(
        categoryId: 'cat1',
        designation: 'Pose carrelage',
        itemType: ItemType.service,
        unit: 'm2',
        unitPriceHt: '45.00',
        vatRate: '20.00',
        code: null,
      );

      final json = input.toJson();

      expect(json.containsKey('code'), isTrue);
      expect(json['code'], isNull);
      expect(json.containsKey('description'), isTrue);
    });
  });
}
