import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/debouncer.dart';
import '../../../core/widgets/error_state.dart';
import '../../../shared/widgets/debounced_search_field.dart';
import '../../branding/presentation/branding_providers.dart';
import '../../catalog/data/catalog_models.dart';
import '../../catalog/presentation/catalog_providers.dart';
import '../../clients/data/client_model.dart';
import '../../clients/presentation/clients_providers.dart';
import '../../quotes/data/quote_calculation.dart';
import '../../quotes/data/quote_models.dart';
import '../../quotes/presentation/quotes_providers.dart';
import '../data/quote_draft.dart';
import 'draft_quote_preview_screen.dart';
import 'live_devis_preview.dart';
import 'quote_draft_provider.dart';
import 'wizard_step.dart';

/// Renders the body of a step under its question. Every step keeps a single
/// objective — the question at the top is the one decision to make — and every
/// one is wired to the backend.
class WizardStepView extends StatelessWidget {
  const WizardStepView({required this.step, super.key});

  final WizardStep step;

  @override
  Widget build(BuildContext context) {
    // The Catalogue step runs its own full-height layout (tabs + lists that
    // scroll themselves), so it isn't wrapped in the scrolling _StepScaffold.
    if (step == WizardStep.catalogue) return const _CatalogueStep();
    // Personnaliser too: on a wide screen it splits into editing + a live
    // preview pane, which has to escape the scrolling scaffold to give the PDF
    // a bounded height.
    if (step == WizardStep.personnaliser) return const _PersonnaliserStep();
    return _StepScaffold(
      step: step,
      child: switch (step) {
        WizardStep.client => const _ClientStep(),
        WizardStep.recap => const _RecapStep(),
        WizardStep.creer => const _CreerStep(),
        WizardStep.confirmation => const _ConfirmationStep(),
        WizardStep.catalogue => const SizedBox.shrink(), // handled above
        WizardStep.personnaliser => const SizedBox.shrink(), // handled above
      },
    );
  }
}

class _StepScaffold extends StatelessWidget {
  const _StepScaffold({required this.step, required this.child});

  final WizardStep step;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView(
          padding: const EdgeInsets.all(ArtizenSpacing.md),
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: ArtizenColors.infoSurface,
                  child: Icon(step.icon, color: ArtizenColors.nightBlue),
                ),
                const SizedBox(width: ArtizenSpacing.sm),
                Expanded(
                  child: Text(
                    step.question,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ArtizenSpacing.md),
            child,
          ],
        ),
      ),
    );
  }
}

// --- Étape 1 : Client — pour qui ? (câblé sur l'API) -----------------------

class _ClientStep extends ConsumerStatefulWidget {
  const _ClientStep();

  @override
  ConsumerState<_ClientStep> createState() => _ClientStepState();
}

class _ClientStepState extends ConsumerState<_ClientStep> {
  /// Mirrors the field's text so the empty state can tell "no clients at all"
  /// from "nothing matches this search". Updated in step with the query that
  /// actually reaches the server (the field debounces before calling back).
  String _query = '';

  Future<void> _createClient() async {
    // The form returns the client it created (or null if cancelled). A new
    // client is selected straight away — the artisan came here to use it.
    final created = await context.push<Client?>('/clients/new');
    if (!mounted) return;
    if (created != null) {
      ref
          .read(quoteDraftProvider.notifier)
          .selectClient(id: created.id, label: created.displayName);
    }
    // Refresh the picker so a just-created client also appears in the list.
    ref.invalidate(clientSearchProvider);
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(clientSearchProvider);
    final draft = ref.watch(quoteDraftProvider);
    final selectedId = draft.clientId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (selectedId != null)
          _SelectedClientBanner(
            label: draft.clientLabel ?? 'Client',
            onClear: () => ref.read(quoteDraftProvider.notifier).clearClient(),
          ),
        DebouncedSearchField(
          hintText: 'Rechercher un client',
          // Discrete trailing spinner while a search refreshes; the rows below
          // stay put instead of flashing a full-screen loader.
          isLoading: results.isLoading,
          onChanged: (query) {
            setState(() => _query = query.trim());
            ref.read(clientSearchProvider.notifier).search(query);
          },
        ),
        const SizedBox(height: ArtizenSpacing.sm),
        results.when(
          // Keep the current rows visible while a new search resolves.
          skipLoadingOnReload: true,
          skipLoadingOnRefresh: true,
          loading: () => const Padding(
            padding: EdgeInsets.all(ArtizenSpacing.lg),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => ErrorState(
            error: error,
            onRetry: () => ref.invalidate(clientSearchProvider),
          ),
          data: (clients) => clients.isEmpty
              ? _EmptyClients(query: _query)
              : Column(
                  children: [
                    for (final client in clients)
                      Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person_outline),
                          ),
                          title: Text(client.displayName),
                          subtitle: client.email == null
                              ? null
                              : Text(client.email!),
                          trailing: client.id == selectedId
                              ? const Icon(
                                  Icons.check_circle,
                                  color: ArtizenColors.success,
                                  semanticLabel: 'Client sélectionné',
                                )
                              : null,
                          selected: client.id == selectedId,
                          // The one thing this step does: tell the draft who the
                          // quote is for. Selecting again is a harmless no-op, so
                          // a double tap can't hurt. Choosing a client also asks
                          // the wizard to move on — tapping the name *is* the
                          // answer, no second click on Suivant needed.
                          onTap: () {
                            ref
                                .read(quoteDraftProvider.notifier)
                                .selectClient(
                                  id: client.id,
                                  label: client.displayName,
                                );
                            ref
                                .read(wizardAdvanceRequestProvider.notifier)
                                .state++;
                          },
                        ),
                      ),
                  ],
                ),
        ),
        const SizedBox(height: ArtizenSpacing.sm),
        OutlinedButton.icon(
          onPressed: _createClient,
          icon: const Icon(Icons.person_add_outlined),
          label: const Text('Nouveau client'),
        ),
      ],
    );
  }
}

/// The chosen client, shown above the search so it is unmistakable who the
/// quote is for — with a one-tap way to remove the selection and pick again.
class _SelectedClientBanner extends StatelessWidget {
  const _SelectedClientBanner({required this.label, required this.onClear});

  final String label;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ArtizenColors.infoSurface,
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: ArtizenColors.success),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: const Text('Client de ce devis'),
        trailing: TextButton.icon(
          onPressed: onClear,
          icon: const Icon(Icons.close),
          label: const Text('Retirer'),
        ),
      ),
    );
  }
}

/// Tells "no clients yet" apart from "the search matched nothing", so the
/// artisan reads the right next step instead of a generic dead end.
class _EmptyClients extends StatelessWidget {
  const _EmptyClients({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final message = query.isEmpty
        ? "Vous n'avez pas encore de client. Créez-en un ci-dessous."
        : 'Aucun client ne correspond à « $query ». Vérifiez l\'orthographe, '
              'ou créez ce client.';
    return Padding(
      padding: const EdgeInsets.all(ArtizenSpacing.md),
      child: Row(
        children: [
          const Icon(
            Icons.person_search_outlined,
            color: ArtizenColors.textSecondary,
          ),
          const SizedBox(width: ArtizenSpacing.sm),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}

// --- Étape 2 : Catalogue — quels articles ? (3 onglets) --------------------

/// Snapshot [item] onto a draft line (décision 5: its designation, unit and
/// price travel with the line). Shared by the three catalogue tabs — an article
/// added from any of them piles onto the same draft.
void _addToDraft(WidgetRef ref, CatalogItem item, num quantity) {
  ref
      .read(quoteDraftProvider.notifier)
      .addArticle(
        DraftLine(
          catalogItemId: item.id,
          designation: item.designation,
          unit: item.unit,
          quantity: quantity,
          unitPriceHt: item.unitPriceHt,
          vatRate: item.vatRate,
        ),
      );
}

/// The Catalogue step: one decision — "what goes on the quote?" — reached three
/// ways, each an onglet with its own search. **Catalogue** browses by trade
/// (métier → dossier → articles), **Articles** searches every article flat, and
/// **Caisse à outils** picks from the artisan's favourites. Replaces the former
/// two steps (Dossier + Articles). It runs full-height (tabs + self-scrolling
/// lists), so it isn't wrapped in the standard scrolling step scaffold.
class _CatalogueStep extends StatelessWidget {
  const _CatalogueStep();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  ArtizenSpacing.md,
                  ArtizenSpacing.md,
                  ArtizenSpacing.md,
                  ArtizenSpacing.xs,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ArtizenColors.infoSurface,
                      child: Icon(
                        WizardStep.catalogue.icon,
                        color: ArtizenColors.nightBlue,
                      ),
                    ),
                    const SizedBox(width: ArtizenSpacing.sm),
                    Expanded(
                      child: Text(
                        WizardStep.catalogue.question,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
              const TabBar(
                labelColor: kArtizenViolet,
                unselectedLabelColor: ArtizenColors.textSecondary,
                indicatorColor: kArtizenViolet,
                labelStyle: TextStyle(fontWeight: FontWeight.w700),
                tabs: [
                  Tab(text: 'Catalogue'),
                  Tab(text: 'Articles'),
                  Tab(text: 'Caisse à outils'),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    _CatalogueBrowseTab(),
                    _CatalogueArticlesTab(),
                    _CatalogueToolboxTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A scrollable list of articles, each with the − N + / ✔ add control (the
/// [_ArticleRow] used everywhere in the wizard). The draft is the single source
/// of each row's quantity. Shared by the three catalogue tabs.
class _ArticleList extends ConsumerWidget {
  const _ArticleList({required this.items, required this.emptyMessage});

  final List<CatalogItem> items;
  final String emptyMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (items.isEmpty) return _CatalogueEmpty(message: emptyMessage);
    final quantityByItem = ref.watch(
      quoteDraftProvider.select(
        (draft) => {
          for (final line in draft.lines) line.catalogItemId: line.quantity,
        },
      ),
    );
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        ArtizenSpacing.sm,
        ArtizenSpacing.xs,
        ArtizenSpacing.sm,
        ArtizenSpacing.lg,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _ArticleRow(
          key: ValueKey(item.id),
          item: item,
          quantity: quantityByItem[item.id],
          onAdd: (qty) => _addToDraft(ref, item, qty),
          onRemoveOne: () => ref
              .read(quoteDraftProvider.notifier)
              .setQuantity(item.id, (quantityByItem[item.id] ?? 1) - 1),
        );
      },
    );
  }
}

/// The "Articles" onglet: every active article, flat and server-searched.
class _CatalogueArticlesTab extends ConsumerWidget {
  const _CatalogueArticlesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(catalogItemSearchProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.sm),
          child: DebouncedSearchField(
            hintText: 'Rechercher un article (désignation, code)',
            isLoading: results.isLoading,
            onChanged: (query) =>
                ref.read(catalogItemSearchProvider.notifier).search(query),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.xs),
        Expanded(
          child: results.when(
            skipLoadingOnReload: true,
            skipLoadingOnRefresh: true,
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => ErrorState(
              error: error,
              onRetry: () => ref.invalidate(catalogItemSearchProvider),
            ),
            data: (items) => _ArticleList(
              items: items,
              emptyMessage: 'Aucun article ne correspond à cette recherche.',
            ),
          ),
        ),
      ],
    );
  }
}

/// The "Caisse à outils" onglet: the artisan's starred favourites, searched
/// client-side (a toolbox is a curated handful, not a paged catalogue).
class _CatalogueToolboxTab extends ConsumerStatefulWidget {
  const _CatalogueToolboxTab();

  @override
  ConsumerState<_CatalogueToolboxTab> createState() =>
      _CatalogueToolboxTabState();
}

class _CatalogueToolboxTabState extends ConsumerState<_CatalogueToolboxTab> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final favourites = ref.watch(favoriteItemsProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.sm),
          child: DebouncedSearchField(
            hintText: 'Rechercher dans la caisse à outils',
            onChanged: (query) => setState(() => _query = query.trim()),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.xs),
        Expanded(
          child: favourites.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => ErrorState(
              error: error,
              onRetry: () => ref.invalidate(favoriteItemsProvider),
            ),
            data: (items) {
              final query = _query.toLowerCase();
              final filtered = query.isEmpty
                  ? items
                  : items
                        .where(
                          (item) =>
                              item.designation.toLowerCase().contains(query) ||
                              (item.code?.toLowerCase().contains(query) ??
                                  false),
                        )
                        .toList();
              return _ArticleList(
                items: filtered,
                emptyMessage: items.isEmpty
                    ? 'Votre caisse à outils est vide. Ajoutez des favoris (🧰) '
                          'depuis le catalogue.'
                    : 'Aucun favori ne correspond à cette recherche.',
              );
            },
          ),
        ),
      ],
    );
  }
}

/// The "Catalogue" onglet: browse by trade (métier → dossier), searchable, then
/// drill into a folder to add its articles. Reuses the folder-scoped
/// [articlePickerProvider] once a folder is open.
class _CatalogueBrowseTab extends ConsumerStatefulWidget {
  const _CatalogueBrowseTab();

  @override
  ConsumerState<_CatalogueBrowseTab> createState() =>
      _CatalogueBrowseTabState();
}

class _CatalogueBrowseTabState extends ConsumerState<_CatalogueBrowseTab> {
  String _treeQuery = '';

  /// A métier whose name matches keeps all its folders; otherwise only the
  /// folders whose name matches (a métier with neither is dropped).
  List<(TradeGroup, List<TradeCategory>)> _filterTree(
    List<TradeGroup> groups,
    String query,
  ) {
    if (query.isEmpty) {
      return [for (final group in groups) (group, group.categories)];
    }
    final result = <(TradeGroup, List<TradeCategory>)>[];
    for (final group in groups) {
      if (group.label.toLowerCase().contains(query)) {
        result.add((group, group.categories));
      } else {
        final folders = group.categories
            .where((category) => category.name.toLowerCase().contains(query))
            .toList();
        if (folders.isNotEmpty) result.add((group, folders));
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // A folder is open: show its articles with a way back to the tree.
    if (ref.watch(selectedFolderProvider) != null) {
      return _FolderArticles(
        onBack: () => ref.read(selectedFolderProvider.notifier).clear(),
      );
    }

    final groups = ref.watch(catalogByTradeProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.sm),
          child: DebouncedSearchField(
            hintText: 'Rechercher un métier ou un dossier',
            onChanged: (query) => setState(() => _treeQuery = query.trim()),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.xs),
        Expanded(
          child: groups.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => ErrorState(
              error: error,
              onRetry: () =>
                  ref.read(catalogByTradeProvider.notifier).refresh(),
            ),
            data: (list) {
              if (list.isEmpty) {
                return const _CatalogueEmpty(
                  message:
                      'Votre catalogue est vide. Activez un métier '
                      '(Paramètres → Mes métiers) pour le remplir.',
                );
              }
              final query = _treeQuery.toLowerCase();
              final filtered = _filterTree(list, query);
              if (filtered.isEmpty) {
                return _CatalogueEmpty(
                  message:
                      'Aucun métier ni dossier ne correspond à « $_treeQuery ».',
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  ArtizenSpacing.sm,
                  ArtizenSpacing.xs,
                  ArtizenSpacing.sm,
                  ArtizenSpacing.lg,
                ),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final (group, folders) = filtered[index];
                  return _TradeTile(
                    key: ValueKey('${group.label}|$query'),
                    label: group.label,
                    folders: folders,
                    initiallyExpanded: query.isNotEmpty,
                    onOpenFolder: (id) =>
                        ref.read(selectedFolderProvider.notifier).open(id),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

/// The articles of the folder currently open in the Catalogue onglet, with the
/// same add control as everywhere else and a "back to folders" affordance.
class _FolderArticles extends ConsumerWidget {
  const _FolderArticles({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(articlePickerProvider);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text('Dossiers'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: ArtizenSpacing.sm),
          child: DebouncedSearchField(
            hintText: 'Rechercher dans ce dossier',
            isLoading: results.isLoading,
            onChanged: (query) =>
                ref.read(articlePickerProvider.notifier).search(query),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.xs),
        Expanded(
          child: results.when(
            skipLoadingOnReload: true,
            skipLoadingOnRefresh: true,
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => ErrorState(
              error: error,
              onRetry: () => ref.invalidate(articlePickerProvider),
            ),
            data: (items) => _ArticleList(
              items: items,
              emptyMessage: 'Ce dossier ne contient aucun article.',
            ),
          ),
        ),
      ],
    );
  }
}

/// One métier in the Catalogue onglet's tree, opening to its folders; tapping a
/// folder drills into its articles ([onOpenFolder]).
class _TradeTile extends StatelessWidget {
  const _TradeTile({
    required this.label,
    required this.folders,
    required this.onOpenFolder,
    this.initiallyExpanded = false,
    super.key,
  });

  final String label;
  final List<TradeCategory> folders;
  final ValueChanged<String> onOpenFolder;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final count = folders.length;
    return Card(
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        leading: const CircleAvatar(child: Icon(Icons.handyman_outlined)),
        title: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '$count dossier${count > 1 ? 's' : ''}',
          style: const TextStyle(
            fontSize: 13,
            color: ArtizenColors.textSecondary,
          ),
        ),
        childrenPadding: const EdgeInsets.only(bottom: ArtizenSpacing.xs),
        children: [
          for (final folder in folders)
            ListTile(
              contentPadding: const EdgeInsets.only(left: 24, right: 12),
              leading: const Icon(Icons.folder_outlined),
              title: Text(folder.name),
              trailing: Text(
                '${folder.itemCount}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () => onOpenFolder(folder.id),
            ),
        ],
      ),
    );
  }
}

/// A centred empty/placeholder message for a catalogue onglet.
class _CatalogueEmpty extends StatelessWidget {
  const _CatalogueEmpty({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(ArtizenSpacing.lg),
      children: [
        const SizedBox(height: 32),
        const Icon(
          Icons.inventory_2_outlined,
          size: 40,
          color: ArtizenColors.textSecondary,
        ),
        const SizedBox(height: 12),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: ArtizenColors.textSecondary),
        ),
      ],
    );
  }
}

/// One catalog article, and the one action this step is about: add it to the
/// quote — with its quantity chosen right here (− N +), so a whole line is set
/// in a single gesture instead of adding then adjusting elsewhere. Added lines
/// show "✔ Ajouté" with their quantity and quick +/− controls — the same
/// correction the Personnaliser step offers. The price shown is the catalog's
/// (a snapshot); no total is computed here.
class _ArticleRow extends StatefulWidget {
  const _ArticleRow({
    required this.item,
    required this.quantity,
    required this.onAdd,
    required this.onRemoveOne,
    super.key,
  });

  final CatalogItem item;

  /// Its quantity on the draft, or null if not added yet.
  final num? quantity;

  /// Add [quantity] units of this article to the draft.
  final void Function(int quantity) onAdd;
  final VoidCallback onRemoveOne;

  @override
  State<_ArticleRow> createState() => _ArticleRowState();
}

class _ArticleRowState extends State<_ArticleRow> {
  /// The quantity composed before adding. A fresh row starts at 1.
  int _pending = 1;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final quantity = widget.quantity;
    final added = quantity != null;
    return Card(
      color: added ? ArtizenColors.infoSurface : null,
      child: ListTile(
        isThreeLine: added,
        title: Text(
          item.designation,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${item.unitPriceHt} € HT · ${item.unit}'),
            if (added)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  '✔ Ajouté au devis (× $quantity)',
                  style: const TextStyle(
                    color: ArtizenColors.success,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        // The quantity control lives in the trailing so the row stays compact
        // (one price line), and many articles still fit on screen at once.
        trailing: added
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    tooltip: 'Retirer une unité',
                    onPressed: widget.onRemoveOne,
                  ),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.add),
                    tooltip: 'Ajouter une unité',
                    onPressed: () => widget.onAdd(1),
                  ),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _QuantityStepper(
                    value: _pending,
                    onChanged: (value) => setState(() => _pending = value),
                  ),
                  const SizedBox(width: ArtizenSpacing.xs),
                  FilledButton.tonalIcon(
                    // The global button theme forces full width
                    // (Size.fromHeight), which would demand an infinite width
                    // inside this Row. Size to content instead.
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 40),
                    ),
                    onPressed: () => widget.onAdd(_pending),
                    icon: const Icon(Icons.add),
                    label: const Text('Ajouter'),
                  ),
                ],
              ),
      ),
    );
  }
}

/// A compact "− N +" control for a whole-number quantity. Its floor is 1: it
/// composes a quantity before adding, so stepping down to nothing is not its
/// job (removing a line is the Personnaliser step's, or the row's ✔ state).
class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          iconSize: 20,
          visualDensity: VisualDensity.compact,
          tooltip: 'Diminuer la quantité',
          onPressed: value > 1 ? () => onChanged(value - 1) : null,
        ),
        Text(
          '$value',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          iconSize: 20,
          visualDensity: VisualDensity.compact,
          tooltip: 'Augmenter la quantité',
          onPressed: () => onChanged(value + 1),
        ),
      ],
    );
  }
}

// --- Étape 4 : Personnaliser — quantités, prix, lignes libres --------------

class _PersonnaliserStep extends ConsumerStatefulWidget {
  const _PersonnaliserStep();

  @override
  ConsumerState<_PersonnaliserStep> createState() => _PersonnaliserStepState();
}

class _PersonnaliserStepState extends ConsumerState<_PersonnaliserStep> {
  // A short debounce so a burst of +/- taps triggers one server calculation,
  // not one per tap.
  final Debouncer _debouncer = Debouncer(const Duration(milliseconds: 400));
  bool _recalculating = false;

  void _scheduleRecalc() {
    _debouncer.run(() async {
      if (!mounted) return;
      setState(() => _recalculating = true);
      await ref.read(quoteDraftProvider.notifier).recalculate();
      if (mounted) setState(() => _recalculating = false);
    });
  }

  @override
  void initState() {
    super.initState();
    // Price whatever is already on the draft when the step is first built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && ref.read(quoteDraftProvider).lines.isNotEmpty) {
        _scheduleRecalc();
      }
    });
  }

  @override
  void dispose() {
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Any change to the lines (a quantity, a removal, or articles added
    // upstream) asks the backend to re-price. The backend is the only place a
    // total is ever computed (décision 3); Flutter just shows its answer.
    ref.listen(
      quoteDraftProvider.select((draft) => draft.lines),
      (_, _) => _scheduleRecalc(),
    );

    final draft = ref.watch(quoteDraftProvider);
    final wide = MediaQuery.sizeOf(context).width >= 980;

    if (wide) {
      // Two panes: editing on the left, the live premium preview on the right.
      // The preview pane is an Expanded, so the PDF fills a *bounded* height —
      // never the unbounded one that blanked the web build before.
      return Padding(
        padding: const EdgeInsets.all(ArtizenSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: ListView(
                children: [
                  _header(context),
                  const SizedBox(height: ArtizenSpacing.md),
                  // A Column (not spread children): it builds all the lines and
                  // the totals eagerly, so they exist off-screen too.
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: _editing(draft),
                  ),
                ],
              ),
            ),
            const SizedBox(width: ArtizenSpacing.md),
            const Expanded(flex: 4, child: LiveDevisPreview()),
          ],
        ),
      );
    }

    // Narrow: the classic scrolling column + a full-screen preview button.
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView(
          padding: const EdgeInsets.all(ArtizenSpacing.md),
          children: [
            _header(context),
            const SizedBox(height: ArtizenSpacing.md),
            // A Column (not spread children): it builds the lines and the
            // totals eagerly, so they exist off-screen too.
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _editing(draft),
            ),
            const SizedBox(height: ArtizenSpacing.md),
            OutlinedButton.icon(
              icon: const Icon(Icons.visibility_outlined),
              label: const Text('Aperçu du devis'),
              onPressed:
                  draft.clientId == null ? null : () => _openPreview(draft),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: ArtizenColors.infoSurface,
          child: Icon(
            WizardStep.personnaliser.icon,
            color: ArtizenColors.nightBlue,
          ),
        ),
        const SizedBox(width: ArtizenSpacing.sm),
        Expanded(
          child: Text(
            WizardStep.personnaliser.question,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }

  List<Widget> _editing(QuoteDraft draft) {
    if (draft.lines.isEmpty) {
      return const [
        Text(
          "Ajoutez des articles à l'étape précédente pour les personnaliser.",
        ),
      ];
    }
    // The line total is the backend's, matched by article — null (shown as "—")
    // until the first calculation lands.
    final totalByItem = {
      for (final line
          in draft.calculation?.lines ?? const <QuoteCalculationLine>[])
        line.catalogItemId: line.totalHt,
    };
    return [
      for (final line in draft.lines)
        _EditableLine(
          line: line,
          totalHt: totalByItem[line.catalogItemId],
          onIncrement: () => ref
              .read(quoteDraftProvider.notifier)
              .setQuantity(line.catalogItemId, line.quantity + 1),
          onDecrement: () => ref
              .read(quoteDraftProvider.notifier)
              .setQuantity(line.catalogItemId, line.quantity - 1),
          onRemove: () => ref
              .read(quoteDraftProvider.notifier)
              .removeLine(line.catalogItemId),
        ),
      const SizedBox(height: ArtizenSpacing.sm),
      _TotalsCard(calculation: draft.calculation, recalculating: _recalculating),
    ];
  }

  void _openPreview(QuoteDraft draft) {
    final clientId = draft.clientId;
    if (clientId == null || draft.lines.isEmpty) return;
    final lines = [
      for (final line in draft.lines)
        QuoteLineInput(
          catalogItemId: line.catalogItemId,
          quantity: line.quantity.toString(),
        ),
    ];
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            DraftQuotePreviewScreen(clientId: clientId, lines: lines),
      ),
    );
  }
}

/// One draft line the artisan can adjust: change its quantity or drop it. The
/// price shown is the catalog snapshot and the line total is the backend's —
/// nothing is multiplied here.
class _EditableLine extends StatelessWidget {
  const _EditableLine({
    required this.line,
    required this.totalHt,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  final DraftLine line;
  final String? totalHt;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  String get _quantityLabel => line.quantity % 1 == 0
      ? line.quantity.toInt().toString()
      : line.quantity.toString();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ArtizenSpacing.sm,
          vertical: ArtizenSpacing.xs,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    line.designation,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Retirer la ligne',
                  onPressed: onRemove,
                ),
              ],
            ),
            Text(
              'PU ${line.unitPriceHt} € HT · ${line.unit}',
              style: const TextStyle(
                color: ArtizenColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: ArtizenSpacing.xs),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  tooltip: 'Diminuer la quantité',
                  onPressed: onDecrement,
                ),
                SizedBox(
                  width: 36,
                  child: Text(
                    _quantityLabel,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  tooltip: 'Augmenter la quantité',
                  onPressed: onIncrement,
                ),
                const Spacer(),
                Text(
                  totalHt == null ? '—' : '$totalHt € HT',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// The running totals — always the backend's figures, with a discreet
/// "Recalcul…" while a fresh calculation is in flight.
class _TotalsCard extends StatelessWidget {
  const _TotalsCard({required this.calculation, required this.recalculating});

  final QuoteCalculation? calculation;
  final bool recalculating;

  @override
  Widget build(BuildContext context) {
    final calc = calculation;
    return Card(
      color: ArtizenColors.infoSurface,
      child: Padding(
        padding: const EdgeInsets.all(ArtizenSpacing.md),
        child: Column(
          children: [
            _RecapRow('Total HT', calc == null ? '—' : '${calc.totalHt} €'),
            _RecapRow('TVA', calc == null ? '—' : '${calc.totalVat} €'),
            const Divider(),
            _RecapRow(
              'Total TTC',
              calc == null ? '—' : '${calc.totalTtc} €',
              strong: true,
            ),
            if (recalculating)
              const Padding(
                padding: EdgeInsets.only(top: ArtizenSpacing.xs),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 14,
                      width: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: ArtizenSpacing.xs),
                    Text(
                      'Recalcul…',
                      style: TextStyle(color: ArtizenColors.textSecondary),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// --- Étape 5 : Récapitulatif — vérifier les montants -----------------------

class _RecapStep extends ConsumerStatefulWidget {
  const _RecapStep();

  @override
  ConsumerState<_RecapStep> createState() => _RecapStepState();
}

class _RecapStepState extends ConsumerState<_RecapStep> {
  @override
  void initState() {
    super.initState();
    // Safety net: guarantee there is a total to review. Personnaliser normally
    // keeps the calculation fresh; this only fires if it hasn't run yet.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final draft = ref.read(quoteDraftProvider);
      if (mounted && draft.lines.isNotEmpty && draft.calculation == null) {
        ref.read(quoteDraftProvider.notifier).recalculate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(quoteDraftProvider);
    if (draft.lines.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(ArtizenSpacing.md),
        child: Text('Aucune ligne à récapituler.'),
      );
    }

    final calc = draft.calculation;
    final totalByItem = {
      for (final line in calc?.lines ?? const <QuoteCalculationLine>[])
        line.catalogItemId: line.totalHt,
    };
    final lineCount = draft.lines.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The quality-control checklist: everything the artisan verifies before
        // committing, ticked off at a glance. Amounts are the backend's.
        Card(
          child: Padding(
            padding: const EdgeInsets.all(ArtizenSpacing.md),
            child: Column(
              children: [
                _CheckItem('Client', draft.clientLabel ?? '—'),
                _CheckItem(
                  'Lignes',
                  '$lineCount article${lineCount > 1 ? 's' : ''}',
                ),
                const Divider(),
                _CheckItem(
                  'Total HT',
                  calc == null ? '…' : '${calc.totalHt} €',
                ),
                _CheckItem('TVA', calc == null ? '…' : '${calc.totalVat} €'),
                const Divider(),
                _CheckItem(
                  'Total TTC',
                  calc == null ? '…' : '${calc.totalTtc} €',
                  strong: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.md),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: ArtizenSpacing.xs),
          child: Text(
            'Détail des lignes',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.xs),
        for (final line in draft.lines)
          _RecapLineRow(line: line, totalHt: totalByItem[line.catalogItemId]),
      ],
    );
  }
}

/// One ticked verification line — a green check, a label, and the value.
class _CheckItem extends StatelessWidget {
  const _CheckItem(this.label, this.value, {this.strong = false});

  final String label;
  final String value;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final valueStyle = strong
        ? const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: ArtizenColors.nightBlue,
          )
        : const TextStyle();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: ArtizenColors.success,
            size: 20,
          ),
          const SizedBox(width: ArtizenSpacing.sm),
          Expanded(child: Text(label)),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}

/// One quote line, read-only: what it is, how much of it, its unit price, and
/// its backend-computed line total.
class _RecapLineRow extends StatelessWidget {
  const _RecapLineRow({required this.line, required this.totalHt});

  final DraftLine line;
  final String? totalHt;

  String get _quantityLabel => line.quantity % 1 == 0
      ? line.quantity.toInt().toString()
      : line.quantity.toString();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          line.designation,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '$_quantityLabel × ${line.unitPriceHt} € HT · ${line.unit}',
        ),
        trailing: Text(
          totalHt == null ? '—' : '$totalHt € HT',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _RecapRow extends StatelessWidget {
  const _RecapRow(this.label, this.value, {this.strong = false});

  final String label;
  final String value;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final style = strong
        ? const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: ArtizenColors.nightBlue,
          )
        : const TextStyle();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}

// --- Étape 6 : Créer — la cérémonie de création ----------------------------

class _CreerStep extends ConsumerStatefulWidget {
  const _CreerStep();

  @override
  ConsumerState<_CreerStep> createState() => _CreerStepState();
}

class _CreerStepState extends ConsumerState<_CreerStep> {
  bool _creating = false;
  Object? _error;

  Future<void> _create() async {
    final draft = ref.read(quoteDraftProvider);
    if (draft.clientId == null || draft.lines.isEmpty) return;
    setState(() {
      _creating = true;
      _error = null;
    });
    try {
      // The backend assigns the number, computes the totals and persists it —
      // Flutter only hands over the client and the lines (décision 3 & 4).
      final quote = await ref
          .read(quotesNotifierProvider.notifier)
          .createQuote(
            clientId: draft.clientId!,
            lines: [
              for (final line in draft.lines)
                QuoteLineInput(
                  catalogItemId: line.catalogItemId,
                  quantity: line.quantity.toString(),
                ),
            ],
          );
      // Reopened a brouillon to edit? The edits now live in this fresh quote,
      // so the original is removed — delete + recreate is how a quote is
      // corrected (there is no in-place edit). Done after a successful create
      // so a failure never loses the brouillon being edited; a failed delete
      // only leaves a harmless extra draft the artisan can remove by hand.
      final editingId = ref.read(editingQuoteIdProvider);
      if (editingId != null) {
        try {
          await ref
              .read(quotesNotifierProvider.notifier)
              .deleteQuote(editingId);
        } catch (_) {
          // Non-fatal: the new quote exists; the old brouillon just lingers.
        }
        ref.read(editingQuoteIdProvider.notifier).state = null;
      }
      if (!mounted) return;
      // Publishing it drives the wizard to its Confirmation step.
      ref.read(createdQuoteProvider.notifier).state = quote;
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _creating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final createdQuote = ref.watch(createdQuoteProvider);
    if (createdQuote != null) {
      // Reached only by stepping back after creation — the quote is done.
      return Card(
        color: ArtizenColors.infoSurface,
        child: ListTile(
          leading: const Icon(
            Icons.verified_outlined,
            color: ArtizenColors.success,
          ),
          title: Text('Devis ${createdQuote.quoteNumber} déjà créé'),
          subtitle: const Text(
            'Passez à l\'étape suivante pour la confirmation.',
          ),
        ),
      );
    }

    final draft = ref.watch(quoteDraftProvider);
    final calc = draft.calculation;
    final hasError = _error != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(ArtizenSpacing.md),
            child: Column(
              children: [
                _CheckItem('Client', draft.clientLabel ?? '—'),
                _CheckItem(
                  'Lignes',
                  '${draft.lines.length} article${draft.lines.length > 1 ? 's' : ''}',
                ),
                _CheckItem(
                  'Total TTC',
                  calc == null ? '…' : '${calc.totalTtc} €',
                  strong: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.md),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(bottom: ArtizenSpacing.sm),
            child: Text(
              'La création a échoué. Vérifiez votre connexion, puis réessayez.',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        FilledButton.icon(
          onPressed: _creating ? null : _create,
          icon: _creating
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.check_circle_outline),
          label: Text(
            _creating
                ? 'Création…'
                : (hasError ? 'Réessayer' : 'Créer le devis'),
          ),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            backgroundColor: kArtizenViolet,
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: ArtizenSpacing.xs),
        const Text(
          'Un numéro officiel (DEV-2026-…) lui sera attribué.',
          textAlign: TextAlign.center,
          style: TextStyle(color: ArtizenColors.textSecondary, fontSize: 12),
        ),
      ],
    );
  }
}

// --- Étape 7 : Terminé — le devis existe -----------------------------------

class _ConfirmationStep extends ConsumerWidget {
  const _ConfirmationStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quote = ref.watch(createdQuoteProvider);
    if (quote == null) {
      // Not created yet (shouldn't be reachable — the gate blocks it).
      return const Padding(
        padding: EdgeInsets.all(ArtizenSpacing.md),
        child: Text("Revenez à l'étape précédente pour créer le devis."),
      );
    }
    // Gentle nudge (never a blocker) — a complete identity makes the PDF look
    // professional. Shown only if something is missing; the profile is cached,
    // so this costs nothing extra once loaded.
    final profile = ref.watch(brandingProfileNotifierProvider).valueOrNull;
    final identityIncomplete =
        profile != null &&
        ((profile.company.addressLine ?? '').trim().isEmpty ||
            (profile.company.siret ?? '').trim().isEmpty ||
            (profile.brand.logoPath ?? '').trim().isEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: ArtizenColors.infoSurface,
          child: Padding(
            padding: const EdgeInsets.all(ArtizenSpacing.md),
            child: Column(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: ArtizenColors.success,
                  size: 48,
                ),
                const SizedBox(height: ArtizenSpacing.sm),
                Text(
                  'Votre devis existe',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  quote.quoteNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: ArtizenColors.nightBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${quote.totalTtc} € TTC',
                  style: const TextStyle(color: ArtizenColors.textSecondary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.md),
        OutlinedButton.icon(
          onPressed: () => context.push('/quotes/${quote.id}/pdf'),
          icon: const Icon(Icons.picture_as_pdf_outlined),
          label: const Text('Ouvrir le PDF'),
        ),
        const SizedBox(height: ArtizenSpacing.sm),
        FilledButton.icon(
          // Full success: leave for the list first (where the new quote already
          // appears), then clear the wizard — so a hiccup on the way out never
          // wipes the draft before the artisan has actually left.
          onPressed: () {
            final draftNotifier = ref.read(quoteDraftProvider.notifier);
            final folderNotifier = ref.read(selectedFolderProvider.notifier);
            final createdNotifier = ref.read(createdQuoteProvider.notifier);
            context.go('/quotes');
            draftNotifier.reset();
            folderNotifier.clear();
            createdNotifier.state = null;
          },
          icon: const Icon(Icons.list_alt_outlined),
          label: const Text('Voir mes devis'),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
        ),
        if (identityIncomplete) ...[
          const SizedBox(height: ArtizenSpacing.md),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.tips_and_updates_outlined,
                color: ArtizenColors.gold,
              ),
              title: const Text('Rendez vos devis encore plus pro'),
              subtitle: const Text(
                'Ajoutez votre logo, votre adresse et votre SIRET pour un PDF impeccable.',
              ),
              trailing: TextButton(
                onPressed: () => context.push('/company-profile'),
                child: const Text('Compléter'),
              ),
              isThreeLine: true,
            ),
          ),
        ],
      ],
    );
  }
}
