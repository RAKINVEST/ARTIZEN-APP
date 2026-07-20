import 'package:artizen/features/metiers/data/metiers_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CatalogSource maps snake_case fields, the status enum and the changelog', () {
    final source = CatalogSource.fromJson({
      'slug': 'chauffage',
      'label': 'Chauffage',
      'description': 'Chaudières, PAC, radiateurs.',
      'packs': [
        {'name': 'Production', 'item_count': 18},
        {'name': 'Émetteurs', 'item_count': 22},
      ],
      'item_count': 47,
      'product_count': 30,
      'prestation_count': 17,
      'status': 'update_available',
      'version': 2,
      'imported_version': 1,
      'imported_at': '2026-07-18T10:00:00Z',
      'update_item_count': 3,
      'update_notes': ['Ajout des PAC R290', 'Ajout du vase 12 L'],
    });

    expect(source.slug, 'chauffage');
    expect(source.status, CatalogSourceStatus.updateAvailable);
    expect(source.itemCount, 47);
    expect(source.productCount, 30);
    expect(source.prestationCount, 17);
    expect(source.packCount, 2);
    expect(source.packs.first.itemCount, 18);
    expect(source.importedVersion, 1);
    expect(source.importedAt, DateTime.utc(2026, 7, 18, 10));
    expect(source.updateItemCount, 3);
    expect(source.updateNotes, ['Ajout des PAC R290', 'Ajout du vase 12 L']);
  });

  test('an available source carries null imported fields', () {
    final source = CatalogSource.fromJson({
      'slug': 'plomberie',
      'label': 'Plomberie',
      'packs': <dynamic>[],
      'item_count': 162,
      'product_count': 130,
      'prestation_count': 32,
      'status': 'available',
      'version': 1,
    });

    expect(source.status, CatalogSourceStatus.available);
    expect(source.importedVersion, isNull);
    expect(source.importedAt, isNull);
    expect(source.updateNotes, isNull);
    expect(source.packCount, 0);
  });

  test('CatalogImportResult maps the additive counts', () {
    final result = CatalogImportResult.fromJson({
      'slug': 'plomberie',
      'label': 'Plomberie',
      'categories_created': 9,
      'items_created': 162,
      'items_skipped': 0,
    });

    expect(result.categoriesCreated, 9);
    expect(result.itemsCreated, 162);
    expect(result.itemsSkipped, 0);
  });
}
