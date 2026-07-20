// Minimal driver target for the design-QA recette: it logs in through the
// Flutter engine (whose text entry works on the device, unlike adb's IME
// injection), which persists the auth token to secure storage. Re-launching
// the app then auto-logs-in, so every other screen can be captured with plain
// adb taps + screencap — no text entry needed.
import 'package:artizen/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const email = String.fromEnvironment('UAT_EMAIL');
  const password = String.fromEnvironment('UAT_PASSWORD');

  Future<void> waitFor(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 25),
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      await tester.pump(const Duration(milliseconds: 300));
      if (finder.evaluate().isNotEmpty) return;
    }
    throw TestFailure('Timed out waiting for: ${finder.describeMatch(Plurality.many)}');
  }

  testWidgets('login persists the auth token for the recette', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ArtizenApp()));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    // Already authenticated (token in storage) — nothing to do.
    if (find.text('SE CONNECTER').evaluate().isEmpty) return;

    await tester.enterText(find.byType(TextFormField).at(0), email);
    await tester.enterText(find.byType(TextFormField).at(1), password);
    await waitFor(tester, find.text('SE CONNECTER'));
    await tester.tap(find.text('SE CONNECTER'));
    await waitFor(tester, find.text('Tableau de bord'));
  }, timeout: const Timeout(Duration(minutes: 2)));
}
