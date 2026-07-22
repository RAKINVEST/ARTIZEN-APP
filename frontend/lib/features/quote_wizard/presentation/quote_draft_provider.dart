import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/current_company_provider.dart';
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

  /// Forget the chosen client. The Client step reports incomplete again, so
  /// the wizard gates "Suivant" until another client is picked. Only the
  /// client is cleared — any lines already added stay put.
  void clearClient() {
    state = state.copyWith(clientId: null, clientLabel: null);
  }

  /// Add an article. If it's already in the draft, bump its quantity rather
  /// than duplicate the line — ticking it twice means "more of it", not a
  /// second line.
  void addArticle(DraftLine line) {
    final existing = state.lines.indexWhere(
      (l) => l.catalogItemId == line.catalogItemId,
    );
    if (existing >= 0) {
      setQuantity(
        line.catalogItemId,
        state.lines[existing].quantity + line.quantity,
      );
      return;
    }
    state = state.copyWith(lines: [...state.lines, line]);
  }

  void removeLine(String catalogItemId) {
    state = state.copyWith(
      lines: state.lines
          .where((l) => l.catalogItemId != catalogItemId)
          .toList(),
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
    final calculation = await ref
        .read(quotesRepositoryProvider)
        .calculate(
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

final quoteDraftProvider = NotifierProvider<QuoteDraftNotifier, QuoteDraft>(
  QuoteDraftNotifier.new,
);

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
    NotifierProvider<SelectedFolderNotifier, String?>(
      SelectedFolderNotifier.new,
    );

/// The artisan's catalog folders — name, article count, sample designations —
/// shown by the "Dossier" step so he can pick where to work.
final foldersProvider = FutureProvider<List<CategoryOverview>>((ref) {
  return ref.watch(catalogRepositoryProvider).listCategoryOverviews();
});

/// The active articles of the folder currently open ([selectedFolderProvider]),
/// server-searched and bounded — the source of the "Articles" step. It
/// re-fetches when the open folder changes, and (like the client picker) keeps
/// the current rows visible while a new search resolves, so typing never blanks
/// the list. Filtering and search are the backend's job (décision 3): a folder
/// of any size stays one bounded, searchable page — paging can be added later
/// without touching how this is used.
class ArticlePickerNotifier
    extends AutoDisposeAsyncNotifier<List<CatalogItem>> {
  /// Comfortably above a real folder's size; a bigger folder relies on search.
  static const int _limit = 100;

  String _query = '';
  int _requestId = 0;

  Future<List<CatalogItem>> _fetch(String? query) async {
    final categoryId = ref.read(selectedFolderProvider);
    if (categoryId == null) return const [];
    final companyId = await ref.read(currentCompanyIdProvider.future);
    return ref
        .read(catalogRepositoryProvider)
        .listItems(
          companyId: companyId,
          categoryId: categoryId,
          activeOnly: true,
          query: query == null || query.isEmpty ? null : query,
          limit: _limit,
        );
  }

  @override
  Future<List<CatalogItem>> build() async {
    // Re-fetch whenever the open folder changes.
    ref.watch(selectedFolderProvider);
    return _fetch(_query);
  }

  /// Debounced upstream by the search field; ignores out-of-order responses so
  /// a slow early query can't overwrite a fast later one.
  Future<void> search(String rawQuery) async {
    final trimmed = rawQuery.trim();
    if (trimmed == _query) return;
    _query = trimmed;
    final requestId = ++_requestId;
    state = const AsyncValue<List<CatalogItem>>.loading().copyWithPrevious(
      state,
    );
    final next = await AsyncValue.guard(() => _fetch(trimmed));
    if (requestId != _requestId) return;
    state = next;
  }
}

final articlePickerProvider =
    AutoDisposeAsyncNotifierProvider<ArticlePickerNotifier, List<CatalogItem>>(
      ArticlePickerNotifier.new,
    );

/// A one-shot "the artisan made this step's choice, move on" signal, bumped by
/// a step the moment its single decision is taken — a client tapped, a folder
/// opened. The wizard shell listens and advances to the next step: the tap *is*
/// the answer, so it shouldn't also need a press on Suivant (gain de fluidité).
/// A counter, not a bool, so tapping again (even the same choice) still fires.
/// Deliberately left untouched by a pre-selected client (arriving from a
/// client's "Créer un devis"), which lands on the Client step ready to review
/// rather than skipping straight past it.
final wizardAdvanceRequestProvider = StateProvider<int>((ref) => 0);

/// The quote once it has been created — its number and totals come from the
/// backend (`POST /quotes`). Set on the Créer step's success; it drives the
/// wizard to its Confirmation step and is cleared only when the artisan
/// finally leaves for the devis list. Non-null means "the work is saved":
/// leaving no longer risks losing anything.
final createdQuoteProvider = StateProvider<Quote?>((ref) => null);

/// Clears everything the wizard held — draft, open folder, created quote — so
/// the next "Nouveau devis" starts from a clean slate. Called only after a
/// full, successful flow (or a confirmed abandon).
void resetWizardDraft(WidgetRef ref) {
  ref.read(quoteDraftProvider.notifier).reset();
  ref.read(selectedFolderProvider.notifier).clear();
  ref.read(createdQuoteProvider.notifier).state = null;
}

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
    // Advancing off Créer means the quote has actually been created — the
    // wizard auto-advances to Confirmation the moment it is.
    WizardStep.creer => ref.watch(createdQuoteProvider) != null,
    WizardStep.confirmation => true,
  };
});
