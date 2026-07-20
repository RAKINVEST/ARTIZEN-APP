import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../catalog/data/catalog_models.dart';
import '../../catalog/data/catalog_repository_impl.dart';
import '../../quotes/data/quote_models.dart';
import '../../quotes/data/quotes_repository_impl.dart';
import '../data/quote_draft.dart';
import 'wizard_step.dart';

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

/// The folder open at the "Dossier" step — pure navigation state, **outside**
/// the draft on purpose (a folder guides browsing, it is not part of the
/// quote). Structurally can't be persisted with the quote.
class SelectedFolderNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  /// "Open this folder" — the one thing the Dossier step does.
  void open(String folderId) => state = folderId;

  void clear() => state = null;
}

final selectedFolderProvider =
    NotifierProvider<SelectedFolderNotifier, String?>(SelectedFolderNotifier.new);

/// The artisan's catalog folders — name, article count, sample designations —
/// shown by the "Dossier" step so he can pick where to work.
final foldersProvider = FutureProvider<List<CategoryOverview>>((ref) {
  return ref.watch(catalogRepositoryProvider).listCategoryOverviews();
});

/// Whether the artisan may leave [step] — the single place step-completion is
/// decided. The wizard's Précédent/Suivant/progress ask *this*, never the
/// widgets ("does this screen contain something?"). Reactive: it recomputes
/// when the draft changes, so the Suivant button enables itself the moment a
/// step is satisfied.
final stepCompleteProvider = Provider.family<bool, WizardStep>((ref, step) {
  final draft = ref.watch(quoteDraftProvider);
  return switch (step) {
    WizardStep.client => draft.hasClient,
    // Navigation state, not the draft: "a folder is open".
    WizardStep.dossier => ref.watch(selectedFolderProvider) != null,
    WizardStep.articles => draft.hasLines,
    WizardStep.personnaliser => draft.hasLines,
    WizardStep.recap => draft.hasValidCalculation,
    WizardStep.creer => draft.canCreate,
    WizardStep.envoyer => true,
  };
});
