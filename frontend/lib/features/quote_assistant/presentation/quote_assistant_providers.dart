import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/current_company_provider.dart';
import '../data/quote_assistant_repository_impl.dart';
import '../data/quote_suggestion_models.dart';

/// Holds the latest AI suggestion (or `null` before the first analysis).
/// A thin wrapper around the repository call — nothing here re-derives
/// or second-guesses the backend's `confidence`/`items`.
class QuoteAssistantNotifier extends AsyncNotifier<QuoteSuggestion?> {
  @override
  Future<QuoteSuggestion?> build() async => null;

  Future<void> analyze(String description) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      final companyId = await ref.read(currentCompanyIdProvider.future);
      return ref
          .read(quoteAssistantRepositoryProvider)
          .suggest(companyId: companyId, description: description);
    });
    state = result;

    final suggestion = result.valueOrNull;
    if (suggestion != null) {
      ref.read(acceptedSuggestionItemsProvider.notifier).setAll(suggestion.items);
    }
  }

  void clear() {
    state = const AsyncValue.data(null);
    ref.read(acceptedSuggestionItemsProvider.notifier).clear();
  }
}

final quoteAssistantNotifierProvider =
    AsyncNotifierProvider<QuoteAssistantNotifier, QuoteSuggestion?>(QuoteAssistantNotifier.new);

/// Editable working copy of the suggested items: the user can drop an
/// item or adjust its quantity before creating the quote ("possibilité
/// de modifier" in the brief) — this notifier is that draft, separate
/// from the read-only `QuoteSuggestion` the AI returned.
class AcceptedSuggestionItemsNotifier extends Notifier<List<QuoteSuggestionItem>> {
  @override
  List<QuoteSuggestionItem> build() => [];

  void setAll(List<QuoteSuggestionItem> items) => state = items;

  /// Adds a line the user picked manually from the catalog — Étape 9's
  /// "ajout manuel d'un article" — alongside whatever the AI proposed,
  /// with no `reason` implying it came from a match.
  void addItem(QuoteSuggestionItem item) => state = [...state, item];

  void removeAt(int index) => state = [...state]..removeAt(index);

  void updateQuantity(int index, String quantity) {
    state = [
      for (var i = 0; i < state.length; i++)
        i == index ? state[i].copyWith(quantity: quantity) : state[i],
    ];
  }

  void clear() => state = [];
}

final acceptedSuggestionItemsProvider =
    NotifierProvider<AcceptedSuggestionItemsNotifier, List<QuoteSuggestionItem>>(
  AcceptedSuggestionItemsNotifier.new,
);
