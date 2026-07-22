import 'package:artizen/core/theme/app_theme.dart';
import 'package:artizen/features/metiers/data/metiers_models.dart';
import 'package:artizen/features/metiers/data/metiers_repository_impl.dart';
import 'package:artizen/features/metiers/presentation/metiers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_repositories.dart';

CatalogSource _source(String slug, CatalogSourceStatus status) => CatalogSource(
      slug: slug,
      label: slug,
      itemCount: 10,
      productCount: 7,
      prestationCount: 3,
      status: status,
      version: 1,
    );

// Renders the real screen under the real theme. Model/notifier tests never
// build the widget tree, so a layout bug (the full-width button theme forcing
// an infinite width inside the action Row) shipped invisibly and left the
// screen blank. This test builds the screen so that class of bug cannot hide.
Widget _app(FakeMetiersRepository repository) => ProviderScope(
      overrides: [metiersRepositoryProvider.overrideWithValue(repository)],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const MetiersScreen(),
      ),
    );

void main() {
  testWidgets('renders source cards and their actions without a layout exception',
      (tester) async {
    await tester.pumpWidget(
      _app(
        FakeMetiersRepository(
          activities: [
            _source('plomberie', CatalogSourceStatus.available),
            _source('chauffage', CatalogSourceStatus.imported),
          ],
          qualifications: [
            _source('pg', CatalogSourceStatus.available),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The regression guard: the action Row used to force an infinite width on
    // the full-width "Importer" button, crashing layout so nothing painted.
    expect(tester.takeException(), isNull);

    // And the cards actually render: the available source offers "Importer",
    // both sources show their labels.
    expect(find.text('Importer'), findsWidgets);
    expect(find.text('plomberie'), findsOneWidget);
    expect(find.text('chauffage'), findsOneWidget);
  });
}
