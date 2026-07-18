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
  testWidgets('App boots to the login screen and logs in to the dashboard', (tester) async {
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
          clientsRepositoryProvider.overrideWithValue(FakeClientsRepository([])),
          catalogRepositoryProvider.overrideWithValue(FakeCatalogRepository([], [])),
          quotesRepositoryProvider.overrideWithValue(FakeQuotesRepository([])),
          brandingRepositoryProvider.overrideWithValue(FakeBrandingRepository(_emptyProfile())),
        ],
        child: const ArtizenApp(),
      ),
    );
    await tester.pumpAndSettle();

    // The wordmark and CTA are uppercase in the premium identity.
    expect(find.text('ARTIZEN'), findsOneWidget);
    expect(find.text('SE CONNECTER'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'demo@artizen-qa.io');
    await tester.enterText(find.byType(TextFormField).at(1), 'Password123!');
    // The premium login now leads with a brand banner, so the button can sit
    // below the fold on a small test surface — scroll it into view first.
    await tester.ensureVisible(find.text('SE CONNECTER'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('SE CONNECTER'));
    await tester.pumpAndSettle();

    // Appears twice: the AppBar title and the bottom-nav label.
    expect(find.text('Tableau de bord'), findsNWidgets(2));

    // A brand-new account (empty fakes, no SIRET) lands on the onboarding
    // checklist. Dismiss it via "Masquer" to reveal the underlying empty
    // dashboard — this also exercises the dismiss control.
    expect(find.text('Bienvenue ! Voici comment démarrer'), findsOneWidget);
    await tester.tap(find.text('Masquer'));
    await tester.pumpAndSettle();

    // The three stat cards, all backed by the empty fakes above.
    expect(find.text('0'), findsNWidgets(3));
  });
}
