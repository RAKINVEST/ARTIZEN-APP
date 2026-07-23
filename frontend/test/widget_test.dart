import 'package:artizen/core/api/auth_token_storage.dart';
import 'package:artizen/core/navigation/app_router.dart';
import 'package:artizen/features/auth/data/auth_repository.dart';
import 'package:artizen/features/branding/data/branding_models.dart';
import 'package:artizen/features/branding/data/branding_repository_impl.dart';
import 'package:artizen/features/catalog/data/catalog_repository_impl.dart';
import 'package:artizen/features/clients/data/clients_repository_impl.dart';
import 'package:artizen/features/quotes/data/quotes_repository_impl.dart';
import 'package:artizen/main.dart';
import 'package:artizen/shared/providers/current_company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fake_auth_repository.dart';
import 'support/fake_auth_token_storage.dart';
import 'support/fake_repositories.dart';

/// A minimal company/brand profile for the dashboard's onboarding step, which
/// now reads `/branding/profile` to know whether the company has a SIRET.
BrandingProfile _emptyProfile() => const BrandingProfile(
  company: Company(id: 'co1'),
  brand: BrandProfile(id: 'b1'),
  templates: [],
);

void main() {
  testWidgets('App boots to the login screen and logs in to the dashboard', (
    tester,
  ) async {
    // A tall surface so the whole dashboard (the permanent quick-access panel,
    // the "Nouveau devis guidé" button and the three stat cards) lays out —
    // otherwise the lazy ListView leaves the stats unbuilt off-screen.
    tester.view.physicalSize = const Size(1200, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // The app now boots to the public landing page ('/') by default.
          // This test exercises the authenticated flow, so start it on
          // '/login' instead of driving the marketing page.
          initialLocationProvider.overrideWithValue('/login'),
          // The real storage needs platform channels flutter test doesn't
          // provide — this is exactly the substitution AuthTokenStorage
          // exists to make trivial.
          authTokenStorageProvider.overrideWithValue(FakeAuthTokenStorage()),
          // Login now calls the backend over real HTTP by default. A
          // widget test must not depend on that — the fake just accepts
          // any credentials.
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
          // Everything past login reads company_id, then the three
          // repositories, over real HTTP by default. A widget test must
          // not depend on the backend actually running, so every one of
          // them is replaced with an in-memory fake.
          currentCompanyIdProvider.overrideWith((ref) async => 'co1'),
          clientsRepositoryProvider.overrideWithValue(
            FakeClientsRepository([]),
          ),
          catalogRepositoryProvider.overrideWithValue(
            FakeCatalogRepository([], []),
          ),
          quotesRepositoryProvider.overrideWithValue(FakeQuotesRepository([])),
          brandingRepositoryProvider.overrideWithValue(
            FakeBrandingRepository(_emptyProfile()),
          ),
        ],
        child: const ArtizenApp(),
      ),
    );
    // The premium login hero runs a perpetual "detection" showcase animation,
    // so we pump a fixed slice instead of pumpAndSettle (a loop never settles).
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    // The wordmark; the CTA is now the emotional "Entrer dans mon atelier".
    expect(find.text('ARTIZEN'), findsOneWidget);
    expect(find.text('Entrer dans mon atelier'), findsOneWidget);

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'demo@artizen-qa.io',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'Password123!');
    await tester.ensureVisible(find.text('Entrer dans mon atelier'));
    await tester.pump();
    await tester.tap(find.text('Entrer dans mon atelier'));
    // Login navigates to the dashboard; once the login screen is gone its
    // looping animation is disposed, so the dashboard settles normally.
    await tester.pumpAndSettle();

    // Appears twice: the AppBar title and the bottom-nav label.
    expect(find.text('Tableau de bord'), findsNWidgets(2));

    // The dashboard opens on its permanent "Bienvenue" quick-access panel.
    expect(find.text('Bienvenue'), findsOneWidget);

    // The stat cards, all backed by the empty fakes above: clients, articles,
    // and the five devis cards (brouillon + en attente + devis + validés +
    // refusés).
    expect(find.text('0'), findsNWidgets(7));
  });
}
