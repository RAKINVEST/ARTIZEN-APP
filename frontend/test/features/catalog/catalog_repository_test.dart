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

Map<String, dynamic> _categoryJson(String id) => {
  'id': id,
  'company_id': 'co1',
  'name': 'Dossier $id',
  'description': null,
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

  group('listItems', () {
    test('forwards q/offset/limit for server-side search and paging', () async {
      when(
        () => dio.get<List<dynamic>>(
          '/catalog/items',
          queryParameters: {
            'company_id': 'co1',
            'active_only': true,
            'favorite_only': false,
            'q': 'carrelage',
            'offset': 0,
            'limit': 30,
          },
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/catalog/items'),
          statusCode: 200,
          data: [_itemJson(active: true)],
        ),
      );

      final items = await repository.listItems(
        companyId: 'co1',
        activeOnly: true,
        query: 'carrelage',
        offset: 0,
        limit: 30,
      );

      expect(items, hasLength(1));
      verify(
        () => dio.get<List<dynamic>>(
          '/catalog/items',
          queryParameters: {
            'company_id': 'co1',
            'active_only': true,
            'favorite_only': false,
            'q': 'carrelage',
            'offset': 0,
            'limit': 30,
          },
        ),
      ).called(1);
    });

    test('omits q/offset/limit when not provided (plain count call)', () async {
      when(
        () => dio.get<List<dynamic>>(
          '/catalog/items',
          queryParameters: {'company_id': 'co1', 'active_only': false, 'favorite_only': false},
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/catalog/items'),
          statusCode: 200,
          data: <dynamic>[],
        ),
      );

      await repository.listItems(companyId: 'co1');

      verify(
        () => dio.get<List<dynamic>>(
          '/catalog/items',
          queryParameters: {'company_id': 'co1', 'active_only': false, 'favorite_only': false},
        ),
      ).called(1);
    });
  });

  group('favorites', () {
    test('listItems forwards favorite_only for "Ma caisse à outils"', () async {
      when(
        () => dio.get<List<dynamic>>(
          '/catalog/items',
          queryParameters: {'company_id': 'co1', 'active_only': false, 'favorite_only': true},
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/catalog/items'),
          statusCode: 200,
          data: [_itemJson(active: true)],
        ),
      );

      final items = await repository.listItems(companyId: 'co1', favoriteOnly: true);

      expect(items, hasLength(1));
      verify(
        () => dio.get<List<dynamic>>(
          '/catalog/items',
          queryParameters: {'company_id': 'co1', 'active_only': false, 'favorite_only': true},
        ),
      ).called(1);
    });

    test('setFavorite sends only {"is_favorite": ...}, leaving the rest untouched', () async {
      // Same bare-body reasoning as reactivateItem: the backend applies
      // exclude_unset, so this touches only the toolbox flag.
      when(
        () => dio.put<Map<String, dynamic>>('/catalog/items/i1', data: {'is_favorite': true}),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/catalog/items/i1'),
          statusCode: 200,
          data: _itemJson(active: true),
        ),
      );

      await repository.setFavorite('i1', favorite: true);

      verify(
        () => dio.put<Map<String, dynamic>>('/catalog/items/i1', data: {'is_favorite': true}),
      ).called(1);
    });
  });

  group('listCategories', () {
    test('pages through every category until a short page ends the walk', () async {
      // A company that imported many trades has more folders than one page.
      // The picker must still receive all of them, so the repo pages through.
      final page1 = [for (var i = 0; i < 200; i++) _categoryJson('c$i')];
      final page2 = [for (var i = 200; i < 230; i++) _categoryJson('c$i')];

      when(
        () => dio.get<List<dynamic>>(
          '/catalog/categories',
          queryParameters: {'company_id': 'co1', 'offset': 0, 'limit': 200},
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/catalog/categories'),
          statusCode: 200,
          data: page1,
        ),
      );
      when(
        () => dio.get<List<dynamic>>(
          '/catalog/categories',
          queryParameters: {'company_id': 'co1', 'offset': 200, 'limit': 200},
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/catalog/categories'),
          statusCode: 200,
          data: page2,
        ),
      );

      final categories = await repository.listCategories(companyId: 'co1');

      expect(categories, hasLength(230));
      // The second page was actually fetched — a single call would have
      // silently dropped everything past the 200th folder.
      verify(
        () => dio.get<List<dynamic>>(
          '/catalog/categories',
          queryParameters: {'company_id': 'co1', 'offset': 200, 'limit': 200},
        ),
      ).called(1);
    });

    test('a single short page ends after one request', () async {
      when(
        () => dio.get<List<dynamic>>(
          '/catalog/categories',
          queryParameters: {'company_id': 'co1', 'offset': 0, 'limit': 200},
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/catalog/categories'),
          statusCode: 200,
          data: [_categoryJson('c1'), _categoryJson('c2')],
        ),
      );

      final categories = await repository.listCategories(companyId: 'co1');

      expect(categories, hasLength(2));
      verifyNever(
        () => dio.get<List<dynamic>>(
          '/catalog/categories',
          queryParameters: {'company_id': 'co1', 'offset': 200, 'limit': 200},
        ),
      );
    });
  });

  group('listCatalogByTrade', () {
    test('parses the trade groups and their folders', () async {
      when(() => dio.get<List<dynamic>>('/catalog/by-trade')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/catalog/by-trade'),
          statusCode: 200,
          data: [
            {
              'label': 'Plomberie',
              'categories': [
                {'id': 'c1', 'name': 'Sanitaires', 'item_count': 3},
              ],
            },
            {
              'label': 'Autres',
              'categories': [
                {'id': 'c2', 'name': 'Divers', 'item_count': 1},
              ],
            },
          ],
        ),
      );

      final groups = await repository.listCatalogByTrade();

      expect(groups, hasLength(2));
      expect(groups.first.label, 'Plomberie');
      expect(groups.first.categories.single.name, 'Sanitaires');
      expect(groups.first.categories.single.itemCount, 3);
      expect(groups.last.label, 'Autres');
    });
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
