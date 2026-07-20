import 'package:artizen/features/metiers/data/metiers_models.dart';
import 'package:artizen/features/metiers/data/metiers_repository_impl.dart';
import 'package:artizen/features/metiers/presentation/metiers_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

CatalogSource _source(
  String slug,
  CatalogSourceStatus status, {
  int version = 1,
  int? importedVersion,
}) {
  return CatalogSource(
    slug: slug,
    label: slug,
    itemCount: 10,
    productCount: 7,
    prestationCount: 3,
    status: status,
    version: version,
    importedVersion: importedVersion,
  );
}

void main() {
  ProviderContainer containerWith(FakeMetiersRepository repository) {
    final container = ProviderContainer(
      overrides: [metiersRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('activities load through the repository', () async {
    final container = containerWith(
      FakeMetiersRepository(
        activities: [_source('plomberie', CatalogSourceStatus.available)],
      ),
    );

    final list = await container.read(activitiesNotifierProvider.future);

    expect(list.single.slug, 'plomberie');
    expect(list.single.status, CatalogSourceStatus.available);
  });

  test('importing an activity flips it to imported and reports what it added', () async {
    final container = containerWith(
      FakeMetiersRepository(
        activities: [_source('plomberie', CatalogSourceStatus.available)],
      ),
    );
    await container.read(activitiesNotifierProvider.future);

    final result = await container.read(activitiesNotifierProvider.notifier).import('plomberie');

    expect(result.itemsCreated, 10);
    expect(
      container.read(activitiesNotifierProvider).value!.single.status,
      CatalogSourceStatus.imported,
    );
  });

  test('removing an activity flips it back to available', () async {
    final container = containerWith(
      FakeMetiersRepository(
        activities: [
          _source('plomberie', CatalogSourceStatus.imported, importedVersion: 1),
        ],
      ),
    );
    await container.read(activitiesNotifierProvider.future);

    await container.read(activitiesNotifierProvider.notifier).remove('plomberie');

    expect(
      container.read(activitiesNotifierProvider).value!.single.status,
      CatalogSourceStatus.available,
    );
  });

  test('qualifications have their own list and notifier', () async {
    final container = containerWith(
      FakeMetiersRepository(
        qualifications: [_source('pg', CatalogSourceStatus.available)],
      ),
    );

    final list = await container.read(qualificationsNotifierProvider.future);

    expect(list.single.slug, 'pg');
  });
}
