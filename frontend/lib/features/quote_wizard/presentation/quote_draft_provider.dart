import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../quotes/data/quote_models.dart';
import '../../quotes/data/quotes_repository_impl.dart';
import '../data/quote_draft.dart';

/// Owns the [QuoteDraft] and every operation on it. The seven wizard screens
/// go through this — they ask "add this article", "change this quantity",
/// "recalculate", "reset" — instead of manipulating lists themselves, so the
/// quote logic lives in one place rather than scattered across the flow.
///
/// A plain [Notifier]: the draft is a synchronous in-memory object. Only
/// [recalculate] reaches the network, and it just stores the server's answer
/// back into the draft.
class QuoteDraftNotifier extends Notifier<QuoteDraft> {
  @override
  QuoteDraft build() => const QuoteDraft();

  void selectClient({required String id, required String label}) {
    state = state.copyWith(clientId: id, clientLabel: label);
  }

  /// Add an article. If it's already in the draft, bump its quantity rather
  /// than duplicate the line — ticking it twice means "more of it", not a
  /// second line.
  void addArticle(DraftLine line) {
    final existing = state.lines.indexWhere((l) => l.catalogItemId == line.catalogItemId);
    if (existing >= 0) {
      setQuantity(line.catalogItemId, state.lines[existing].quantity + line.quantity);
      return;
    }
    state = state.copyWith(lines: [...state.lines, line]);
  }

  void removeLine(String catalogItemId) {
    state = state.copyWith(
      lines: state.lines.where((l) => l.catalogItemId != catalogItemId).toList(),
    );
  }

  /// Set a line's quantity. Zero or less removes it — the artisan stepped it
  /// down to nothing, which means they no longer want it.
  void setQuantity(String catalogItemId, num quantity) {
    if (quantity <= 0) {
      removeLine(catalogItemId);
      return;
    }
    state = state.copyWith(
      lines: [
        for (final line in state.lines)
          if (line.catalogItemId == catalogItemId)
            line.copyWith(quantity: quantity)
          else
            line,
      ],
    );
  }

  /// Start over — a fresh draft.
  void reset() => state = const QuoteDraft();

  /// Ask the backend to price the current lines and keep its answer. The only
  /// way an amount enters the draft, and always from the server (décision 3).
  /// An empty draft has no total, so it clears the calculation instead of
  /// calling out.
  Future<void> recalculate() async {
    if (state.lines.isEmpty) {
      state = state.copyWith(calculation: null);
      return;
    }
    final calculation = await ref.read(quotesRepositoryProvider).calculate(
          lines: [
            for (final line in state.lines)
              QuoteLineInput(
                catalogItemId: line.catalogItemId,
                quantity: line.quantity.toString(),
              ),
          ],
        );
    state = state.copyWith(calculation: calculation);
  }
}

final quoteDraftProvider =
    NotifierProvider<QuoteDraftNotifier, QuoteDraft>(QuoteDraftNotifier.new);
