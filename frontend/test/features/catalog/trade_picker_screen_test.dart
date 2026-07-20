import 'package:artizen/features/catalog/data/catalog_models.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/catalog/presentation/trade_picker_screen.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../support/fake_repositories.dart';

const _plombier = Trade(
  slug: 'plombier',
  name: 'Plombier',
  description: 'Tubes, chauffe-eau, robinetterie…',
  categoryCount: 5,
  itemCount: 17,
);

Widget _app(FakeCatalogRepository fake) {
  // TradePickerScreen pops through go_router, so it needs a router ancestor.
  final router = GoRouter(
    initialLocation: '/catalog/trades',
    routes: [
      GoRoute(path: '/catalog/trades', builder: (context, state) => const TradePickerScreen()),
    ],
  );
  return ProviderScope(
    overrides: [
      currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
      catalogRepositoryProvider.overrideWithValue(fake),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  testWidgets('lists the installable trades', (tester) async {
    await tester.pumpWidget(_app(FakeCatalogRepository([], [], const [_plombier])));
    await tester.pumpAndSettle();

    expect(find.text('Quel est votre métier ?'), findsOneWidget);
    expect(find.text('Plombier'), findsOneWidget);
    expect(find.text('5 catégories · 17 articles'), findsOneWidget);
  });

  testWidgets('picking a trade installs its pack', (tester) async {
    final fake = FakeCatalogRepository([], [], const [_plombier]);
    await tester.pumpWidget(_app(fake));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Plombier'));
    await tester.pumpAndSettle();

    // The pack for the tapped trade is the one that gets installed. (The
    // confirmation snackbar isn't asserted: pumpAndSettle runs its
    // auto-dismiss timer, so it's gone by the time the frame settles.)
    expect(fake.installedTradeSlug, 'plombier');
  });
}
