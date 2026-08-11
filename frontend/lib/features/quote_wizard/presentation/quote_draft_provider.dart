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

  /// Add a line. If a line with the same [DraftLine.id] is already in the draft
  /// (i.e. the same catalog article ticked again), bump its quantity rather
  /// than duplicate it. A free line carries a unique id, so it always appends —
  /// two free lines never collapse into one.
  void addArticle(DraftLine line) {
    final existing = state.lines.indexWhere((l) => l.id == line.id);
    if (existing >= 0) {
      setQuantity(line.id, state.lines[existing].quantity + line.quantity);
      return;
    }
    state = state.copyWith(lines: [...state.lines, line]);
  }

  void removeLine(String id) {
    state = state.copyWith(
      lines: state.lines.where((l) => l.id != id).toList(),
    );
  }

  /// Set a line's quantity. Zero or less removes it — the artisan stepped it
  /// down to nothing, which means they no longer want it.
  void setQuantity(String id, num quantity) {
    if (quantity <= 0) {
      removeLine(id);
      return;
    }
    state = state.copyWith(
      lines: [
        for (final line in state.lines)
          if (line.id == id) line.copyWith(quantity: quantity) else line,
      ],
    );
  }

  /// Override a line's unit price (décision 5 — "un prix peut différer de celui
  /// du catalogue"). Marks it overridden so a catalog line's new price travels
  /// to the backend instead of being re-read from the catalog. The calculator
  /// still computes every total (décision 3) — this only changes an input.
  void setUnitPrice(String id, String unitPriceHt) {
    state = state.copyWith(
      lines: [
        for (final line in state.lines)
          if (line.id == id)
            line.copyWith(unitPriceHt: unitPriceHt, priceOverridden: true)
          else
            line,
      ],
    );
  }

  /// Replace the editable fields of a free line (its whole snapshot). Only for
  /// lines the artisan typed — a catalog line's désignation/unité stay the
  /// catalog's.
  void updateFreeLine(
    String id, {
    required String designation,
    required String unit,
    required num quantity,
    required String unitPriceHt,
    required String vatRate,
  }) {
    state = state.copyWith(
      lines: [
        for (final line in state.lines)
          if (line.id == id)
            line.copyWith(
              designation: designation,
              unit: unit,
              quantity: quantity,
              unitPriceHt: unitPriceHt,
              vatRate: vatRate,
            )
          else
            line,
      ],
    );
  }

  /// Set the quote-level discount (décision 5). [type] is `'percent'` or
  /// `'amount'`; [value] the entered figure. The backend computes the euro
  /// amount and re-prices — nothing is multiplied here.
  void setDiscount(String type, String value) {
    state = state.copyWith(discountType: type, discountValue: value);
  }

  void clearDiscount() {
    state = state.copyWith(discountType: null, discountValue: null);
  }

  /// Set the quote-level deposit (acompte). Same shape as the discount; the
  /// deposit only splits the net TTC — it changes no total.
  void setDeposit(String type, String value) {
    state = state.copyWith(depositType: type, depositValue: value);
  }

  void clearDeposit() {
    state = state.copyWith(depositType: null, depositValue: null);
  }

  /// Set the quote's objet (V1.1 #6). Empty or whitespace-only clears it back
  /// to null, so an untouched or blanked field persists nothing.
  void setObject(String? value) {
    final trimmed = value?.trim();
    state = state.copyWith(
      object: (trimmed == null || trimmed.isEmpty) ? null : trimmed,
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
    try {
      final calculation = await ref
          .read(quotesRepositoryProvider)
          .calculate(
            lines: [for (final line in state.lines) line.toInput()],
            discountType: state.discountType,
            discountValue: state.discountValue,
            depositType: state.depositType,
            depositValue: state.depositValue,
          );
      state = state.copyWith(calculation: calculation);
    } catch (_) {
      // A transient invalid input — a discount typed mid-edit that briefly
      // exceeds the total, say (422). Keep the last good calculation rather
      // than blank the live preview; a real create surfaces the error itself.
    }
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

/// The brouillon being *reopened* to edit (its id), or null for a brand-new
/// quote. A quote has no in-place edit path (décision 2: `QuoteCalculator` has
/// no recalculation entry point, so nothing may rewrite an existing quote's
/// lines) — "Modifier" therefore rebuilds it: the wizard creates a fresh
/// brouillon and, on success, deletes this original. Set by [loadQuoteForEdit].
final editingQuoteIdProvider = StateProvider<String?>((ref) => null);

/// Load an existing brouillon [quote] into the wizard so the artisan can reopen
/// and adjust it — "reprendre là où on était". Its client and lines are copied
/// onto a fresh draft; [editingQuoteIdProvider] remembers the original so the
/// Créer step can delete it once the edited version is created. [clientLabel]
/// is the client's display name (the quote carries only the id).
void loadQuoteForEdit(
  WidgetRef ref,
  Quote quote, {
  required String clientLabel,
}) {
  final notifier = ref.read(quoteDraftProvider.notifier);
  notifier.reset();
  notifier.selectClient(id: quote.clientId, label: clientLabel);
  for (final line in quote.lines) {
    // A former free line — or one whose catalog item was later deleted (SET
    // NULL) — has no catalogItemId: it keeps its snapshot and stays a free line.
    final catalogItemId = line.catalogItemId;
    notifier.addArticle(
      DraftLine(
        id: catalogItemId ?? newFreeLineId(),
        catalogItemId: catalogItemId,
        designation: line.designation,
        unit: line.unit,
        quantity: num.tryParse(line.quantity) ?? 1,
        unitPriceHt: line.unitPriceHt,
        vatRate: line.vatRate,
        // A brouillon is a photograph (décision 5): reopening it must preserve
        // the exact price shown, not silently re-fetch the current catalog one.
        // So a reopened catalog line travels as an override of its snapshot
        // price; a free line already carries its whole snapshot. (To get the
        // current catalog price, the artisan removes and re-adds the line.)
        priceOverridden: catalogItemId != null,
      ),
    );
  }
  // Restore the quote-level discount/deposit inputs (their *values*, so a
  // percentage re-resolves to the same amount) — the reopened draft is a
  // photograph and must reproduce exactly what was shown.
  if (quote.discountType != null) {
    notifier.setDiscount(quote.discountType!, quote.discountValue);
  }
  if (quote.depositType != null) {
    notifier.setDeposit(quote.depositType!, quote.depositValue);
  }
  // Restore the objet (V1.1 #6) — a reopened quote shows its saved subject.
  notifier.setObject(quote.object);
  ref.read(selectedFolderProvider.notifier).clear();
  ref.read(createdQuoteProvider.notifier).state = null;
  ref.read(editingQuoteIdProvider.notifier).state = quote.id;
}

/// Seed the wizard from the copilote IA's accepted articles: a fresh draft
/// whose lines are those catalog items, so the artisan continues **in the
/// wizard** (choisir le client → vérifier → créer) instead of a separate form.
/// Same shape as [loadQuoteForEdit] — a clean draft, folder and markers cleared
/// — but built from catalog items and *without* a client: the copilote proposes
/// the lines, the wizard's Client step decides who the quote is for. The
/// mapping [CatalogItem] → [DraftLine] is the same one the "Catalogue" step
/// uses, so a copilote line and a hand-picked line are indistinguishable
/// afterwards — the artisan can adjust or drop either exactly the same way.
void seedWizardFromCatalogItems(
  WidgetRef ref,
  List<({CatalogItem item, num quantity})> lines,
) {
  final notifier = ref.read(quoteDraftProvider.notifier);
  notifier.reset();
  for (final entry in lines) {
    notifier.addArticle(
      DraftLine(
        // Catalog line: its id is the catalog item's id. The copilote never
        // supplies a custom price (Invariant #1), so priceOverridden stays false.
        id: entry.item.id,
        catalogItemId: entry.item.id,
        designation: entry.item.designation,
        unit: entry.item.unit,
        quantity: entry.quantity,
        unitPriceHt: entry.item.unitPriceHt,
        vatRate: entry.item.vatRate,
      ),
    );
  }
  ref.read(selectedFolderProvider.notifier).clear();
  ref.read(createdQuoteProvider.notifier).state = null;
  ref.read(editingQuoteIdProvider.notifier).state = null;
}

/// Clears everything the wizard held — draft, open folder, created quote, and
/// the "editing" marker — so the next "Nouveau devis" starts from a clean
/// slate. Called only after a full, successful flow (or a confirmed abandon).
void resetWizardDraft(WidgetRef ref) {
  ref.read(quoteDraftProvider.notifier).reset();
  ref.read(selectedFolderProvider.notifier).clear();
  ref.read(createdQuoteProvider.notifier).state = null;
  ref.read(editingQuoteIdProvider.notifier).state = null;
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
    // One "Catalogue" step (browse / articles / caisse à outils) — complete
    // as soon as at least one article is on the quote.
    WizardStep.catalogue => draft.hasLines,
    WizardStep.personnaliser => draft.hasLines,
    WizardStep.recap => draft.hasValidCalculation,
    // Advancing off Créer means the quote has actually been created — the
    // wizard auto-advances to Confirmation the moment it is.
    WizardStep.creer => ref.watch(createdQuoteProvider) != null,
    WizardStep.confirmation => true,
  };
});
