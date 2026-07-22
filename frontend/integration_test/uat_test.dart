// User Acceptance Test — drives the REAL Artizen web app in a REAL Chrome
// browser against the REAL Docker backend (PostgreSQL, auth, storage, PDF).
//
// There are NO provider overrides here: this is the fully real application.
// On web, flutter_secure_storage (localStorage) and printing work for real,
// so nothing is faked. The app's default API base URL is
// http://localhost:8000/api — the Docker backend.
//
// Run with:
//   flutter drive --driver=test_driver/integration_test.dart \
//     --target=integration_test/uat_test.dart -d chrome --web-port=3000
//
// The V1 prerequisites (a catalog and a client) are seeded via the API by
// uat_seed.py before this runs, as the same UAT user this test logs in as.
// That keeps the journey focused on the V2 lifecycle — numbering, status,
// duplication, PDF — driven through the real UI.

import 'package:artizen/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Credentials of the user uat_seed.py created and seeded. Passed in via
  // --dart-define so the same account is shared between the seed step, this
  // UI journey, and the post-run backend verification.
  const email = String.fromEnvironment('UAT_EMAIL');
  const password = String.fromEnvironment('UAT_PASSWORD');

  // Real network calls need real wall-clock time; pumpAndSettle alone spins
  // on animations, not on HTTP. This polls the widget tree until [finder]
  // appears or the deadline passes.
  Future<void> waitFor(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 20),
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      await tester.pump(const Duration(milliseconds: 300));
      if (finder.evaluate().isNotEmpty) return;
    }
    throw TestFailure('Timed out waiting for: ${finder.describeMatch(Plurality.many)}');
  }

  // Tab labels double as screen titles ("Devis" is both a bottom-nav
  // destination and an app-bar title), so a bare text finder is ambiguous.
  // Scope the tap to the NavigationBar.
  Future<void> tapTab(WidgetTester tester, String label) async {
    final tab = find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text(label),
    );
    await waitFor(tester, tab);
    await tester.tap(tab);
    await tester.pumpAndSettle();
  }

  testWidgets('UAT: an artisan composes, sends, accepts and duplicates a quote', (tester) async {
    expect(email, isNotEmpty, reason: 'UAT_EMAIL must be provided via --dart-define');

    await tester.pumpWidget(const ProviderScope(child: ArtizenApp()));
    await tester.pumpAndSettle();

    // The browser may carry a JWT in localStorage from a previous run —
    // flutter_secure_storage is real on web, so the token really persists.
    // Ensure a clean logged-out start (and exercise the logout flow while
    // we're here).
    await tester.pump(const Duration(seconds: 2));
    if (find.text('Se connecter').evaluate().isEmpty) {
      await waitFor(tester, find.text('Paramètres'));
      await tapTab(tester, 'Paramètres');
      await waitFor(tester, find.text('Se déconnecter'));
      await tester.tap(find.text('Se déconnecter'));
      await waitFor(tester, find.text('Se connecter'));
    }

    debugPrint('UAT-STEP 1: login');
    // --- Step 1: Connexion (real auth against Docker) ---
    await waitFor(tester, find.text('Se connecter'));
    await tester.enterText(find.byType(TextFormField).at(0), email);
    await tester.enterText(find.byType(TextFormField).at(1), password);
    await tester.tap(find.text('Se connecter'));
    await waitFor(tester, find.text('Tableau de bord'));

    debugPrint('UAT-STEP 3-6: create quote');
    // --- Steps 3-6: create a quote (client + 2 lines → numbering + totals) ---
    await tapTab(tester, 'Devis');
    // FAB on the quotes list opens the new-quote form.
    await waitFor(tester, find.byType(FloatingActionButton));
    await tester.tap(find.byType(FloatingActionButton));
    await waitFor(tester, find.text('Nouveau devis'));

    // Pick the seeded client.
    await tester.tap(find.text('Sélectionner un client'));
    await waitFor(tester, find.text('Client UAT'));
    await tester.tap(find.text('Client UAT'));
    await tester.pumpAndSettle();

    // Add line 1 (the 20% item).
    await tester.tap(find.text('Ajouter un article'));
    await waitFor(tester, find.text('Chauffe-eau UAT'));
    await tester.tap(find.text('Chauffe-eau UAT'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '1');
    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();

    // Add line 2 (the 10% item).
    await tester.tap(find.text('Ajouter un article'));
    await waitFor(tester, find.text('Main-d\'oeuvre UAT'));
    await tester.tap(find.text('Main-d\'oeuvre UAT'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '2');
    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();

    debugPrint('UAT-STEP: submitting quote');
    await tester.tap(find.text('Créer le devis'));

    // Lands on the detail screen: the DEV number is the app-bar title, and
    // the total is rendered. This proves numbering + calculation through
    // the real backend.
    await waitFor(tester, find.textContaining('DEV-'));
    expect(find.textContaining('DEV-'), findsWidgets);
    // 1 × 450 @20% = 540 ; 2 × 60 @10% = 132 ; TTC 672,00 (seeded prices).
    await waitFor(tester, find.textContaining('672,00'));

    debugPrint('UAT-STEP 7-8: pdf');
    // --- Steps 7-8: PDF. On web this triggers a browser download; we drive
    // the button and assert the screen survives (the PDF's byte-correctness
    // is proven authoritatively by the backend UAT script). ---
    expect(find.byTooltip('PDF'), findsOneWidget);
    await tester.tap(find.byTooltip('PDF'));
    await tester.pump(const Duration(seconds: 2));
    // Still on the detail screen.
    expect(find.textContaining('DEV-'), findsWidgets);

    debugPrint('UAT-STEP 9a: validate (brouillon → en attente)');
    // --- Step 9a: Valider le devis (draft freezes into "en attente") ---
    await waitFor(tester, find.text('Valider le devis'));
    await tester.tap(find.text('Valider le devis'));
    await waitFor(tester, find.text('Valider ce devis ?'));
    await tester.tap(find.widgetWithText(FilledButton, 'Valider').last);
    await waitFor(tester, find.text('En attente'));

    debugPrint('UAT-STEP 9b: send by email (en attente → envoyé)');
    // --- Step 9b: Envoyer par e-mail (real email + PDF, marks it sent) ---
    await waitFor(tester, find.text('Envoyer par e-mail'));
    await tester.tap(find.text('Envoyer par e-mail'));
    // Readiness gate passes silently for the seeded quote, then confirmation.
    await waitFor(tester, find.text('Envoyer ce devis par e-mail ?'));
    await tester.tap(find.widgetWithText(FilledButton, 'Envoyer').last);
    await waitFor(tester, find.text('Envoyé'));

    debugPrint('UAT-STEP 10: accept');
    // --- Step 10: Accepté ---
    await waitFor(tester, find.text('Le client a accepté'));
    await tester.tap(find.text('Le client a accepté'));
    await waitFor(tester, find.text('Accepté'));
    // A terminal quote offers duplication rather than a dead end.
    expect(find.text('Dupliquer en nouveau brouillon'), findsOneWidget);

    debugPrint('UAT-STEP 11: duplicate');
    // --- Step 11: Duplicate → a new draft ---
    await tester.tap(find.text('Dupliquer en nouveau brouillon'));
    debugPrint('UAT-STEP: tapped duplicate, waiting for the copy detail');
    // Lands on the copy detail. 'Supprimer' shows only on a draft, so it is
    // the unambiguous signal that the editable copy loaded.
    await tester.pumpAndSettle();
    await waitFor(tester, find.text('Supprimer'), timeout: const Duration(seconds: 60));
    debugPrint('UAT-STEP 12-13: on the draft copy');
    expect(find.text('Brouillon'), findsWidgets);

    // --- Steps 12-13: the draft is editable (deletable) and re-renders a PDF ---
    // The copy shows the delete action (only drafts do) and the PDF button.
    expect(find.text('Supprimer'), findsOneWidget);
    expect(find.byTooltip('PDF'), findsOneWidget);
    await tester.tap(find.byTooltip('PDF'));
    await tester.pump(const Duration(seconds: 2));
    expect(find.textContaining('DEV-'), findsWidgets);

    // --- Step 17: Déconnexion, then log back in (real auth round-trip) ---
    // The detail screen is a pushed route with no bottom NavigationBar;
    // return to the shell before switching tabs.
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tapTab(tester, 'Paramètres');
    await waitFor(tester, find.text('Se déconnecter'));
    await tester.tap(find.text('Se déconnecter'));
    await waitFor(tester, find.text('Se connecter'));

    await tester.enterText(find.byType(TextFormField).at(0), email);
    await tester.enterText(find.byType(TextFormField).at(1), password);
    await tester.tap(find.text('Se connecter'));
    await waitFor(tester, find.text('Tableau de bord'));
    // The quote survived the session: its number shows on the dashboard's
    // recent quotes.
    await tapTab(tester, 'Devis');
    await waitFor(tester, find.textContaining('DEV-'));
    expect(find.textContaining('DEV-'), findsWidgets);
  }, timeout: const Timeout(Duration(minutes: 4)));
}
