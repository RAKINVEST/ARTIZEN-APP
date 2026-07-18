import 'package:artizen/features/quote_assistant/data/quote_suggestion_models.dart';
import 'package:artizen/features/quote_assistant/presentation/quote_assistant_providers.dart';
import 'package:artizen/features/quote_assistant/presentation/quote_assistant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Étape 9 requires "affichage du score de confiance" to distinguish
/// "faible confiance" from "forte confiance" as separate UX states —
/// these widget tests prove the banner text actually reflects the
/// suggestion's `confidence`, not just that a notifier holds the right
/// number (already covered by `quote_assistant_notifier_test.dart`).
class _FixedSuggestionNotifier extends QuoteAssistantNotifier {
  _FixedSuggestionNotifier(this._suggestion);

  final QuoteSuggestion _suggestion;

  @override
  Future<QuoteSuggestion?> build() async => _suggestion;
}

QuoteSuggestion _suggestionWith(double confidence) => QuoteSuggestion(
      items: const [
        QuoteSuggestionItem(
          catalogItemId: 'item-1',
          designation: 'Chauffe-eau Atlantic 200 L',
          quantity: '1',
          reason: 'ok',
        ),
      ],
      confidence: confidence,
      comment: 'ok',
    );

Future<void> _pump(WidgetTester tester, double confidence) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        quoteAssistantNotifierProvider.overrideWith(
          () => _FixedSuggestionNotifier(_suggestionWith(confidence)),
        ),
      ],
      child: const MaterialApp(home: QuoteAssistantScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows a high-confidence banner for a confident suggestion', (tester) async {
    await _pump(tester, 0.9);

    expect(find.textContaining('Confiance forte'), findsOneWidget);
  });

  testWidgets('shows a moderate-confidence banner in the middle range', (tester) async {
    await _pump(tester, 0.5);

    expect(find.textContaining('Confiance modérée'), findsOneWidget);
  });

  testWidgets('shows a low-confidence banner for an uncertain suggestion', (tester) async {
    await _pump(tester, 0.2);

    expect(find.textContaining('Confiance faible'), findsOneWidget);
  });

  testWidgets('shows the "Ajouter un article" action once a suggestion is displayed', (
    tester,
  ) async {
    await _pump(tester, 0.9);

    expect(find.text('Ajouter un article'), findsOneWidget);
    // The primary CTA label is uppercased by AppPrimaryButton.
    expect(find.text('CRÉER LE DEVIS'), findsOneWidget);
  });
}
