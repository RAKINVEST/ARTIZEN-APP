import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/debouncer.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/error_state.dart';
import '../../../shared/widgets/debounced_search_field.dart';
import '../../branding/presentation/branding_providers.dart';
import '../../catalog/data/catalog_models.dart';
import '../../catalog/presentation/catalog_providers.dart';
import '../../clients/data/client_model.dart';
import '../../clients/presentation/clients_providers.dart';
import '../../quotes/data/quote_calculation.dart';
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
          id: item.id,
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
          child: Stack(
            children: [
              Column(
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
              // Overlaid, so it steals no height from the article lists — an
              // always-available entry to add a line typed from scratch. A free
              // line lets a devis exist entirely without the catalogue.
              const Positioned(
                top: ArtizenSpacing.xs,
                right: ArtizenSpacing.xs,
                child: _AddFreeLineButton(),
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
          for (final line in draft.lines)
            if (line.catalogItemId != null) line.catalogItemId!: line.quantity,
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
      quoteDraftProvider.select(
        (draft) => (
          draft.lines,
          draft.discountType,
          draft.discountValue,
          draft.depositType,
          draft.depositValue,
        ),
      ),
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
              onPressed: draft.clientId == null
                  ? null
                  : () => _openPreview(draft),
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
    // Line totals are the backend's, in the same order as the lines that were
    // sent (the service preserves order) — matched by index, so a free line
    // (no catalogItemId to key on) lines up too. "—" until the first
    // calculation lands, or while a stale calculation holds fewer lines.
    final calcLines =
        draft.calculation?.lines ?? const <QuoteCalculationLine>[];
    final notifier = ref.read(quoteDraftProvider.notifier);
    return [
      for (final (index, line) in draft.lines.indexed)
        _EditableLine(
          line: line,
          totalHt: index < calcLines.length ? calcLines[index].totalHt : null,
          onIncrement: () => notifier.setQuantity(line.id, line.quantity + 1),
          onDecrement: () => notifier.setQuantity(line.id, line.quantity - 1),
          onRemove: () => notifier.removeLine(line.id),
          onEditPrice: () => _editPrice(line),
          onEditFreeLine: line.catalogItemId == null
              ? () => _editFreeLine(line)
              : null,
        ),
      const SizedBox(height: ArtizenSpacing.sm),
      const _AdjustmentsCard(),
      const SizedBox(height: ArtizenSpacing.sm),
      _TotalsCard(
        calculation: draft.calculation,
        recalculating: _recalculating,
      ),
    ];
  }

  /// Override a line's unit price (décision 5). A small dialog rather than
  /// inline editing keeps the row calm; the backend re-prices on the next
  /// recalculation — nothing is multiplied here.
  Future<void> _editPrice(DraftLine line) async {
    final price = await showDialog<String>(
      context: context,
      builder: (_) => _PriceEditDialog(initial: line.unitPriceHt),
    );
    if (price != null) {
      ref.read(quoteDraftProvider.notifier).setUnitPrice(line.id, price);
    }
  }

  /// Edit a free line's whole snapshot (its désignation, unité, prix, TVA).
  Future<void> _editFreeLine(DraftLine line) async {
    final result = await showModalBottomSheet<FreeLineValues>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _FreeLineSheet(initial: line),
    );
    if (result != null) {
      ref
          .read(quoteDraftProvider.notifier)
          .updateFreeLine(
            line.id,
            designation: result.designation,
            unit: result.unit,
            quantity: result.quantity,
            unitPriceHt: result.unitPriceHt,
            vatRate: result.vatRate,
          );
    }
  }

  void _openPreview(QuoteDraft draft) {
    final clientId = draft.clientId;
    if (clientId == null || draft.lines.isEmpty) return;
    final lines = [for (final line in draft.lines) line.toInput()];
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DraftQuotePreviewScreen(
          clientId: clientId,
          lines: lines,
          discountType: draft.discountType,
          discountValue: draft.discountValue,
          depositType: draft.depositType,
          depositValue: draft.depositValue,
        ),
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
    required this.onEditPrice,
    this.onEditFreeLine,
  });

  final DraftLine line;
  final String? totalHt;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;
  final VoidCallback onEditPrice;

  /// Only set for a free line — reopens the full editor for its snapshot.
  final VoidCallback? onEditFreeLine;

  bool get _isFree => line.catalogItemId == null;

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
                if (_isFree)
                  Padding(
                    padding: const EdgeInsets.only(right: ArtizenSpacing.xs),
                    child: _LineBadge(
                      label: 'Libre',
                      color: kArtizenViolet,
                      onTap: onEditFreeLine,
                    ),
                  )
                else if (line.priceOverridden)
                  Padding(
                    padding: const EdgeInsets.only(right: ArtizenSpacing.xs),
                    child: _LineBadge(
                      label: 'Prix perso',
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Retirer la ligne',
                  onPressed: onRemove,
                ),
              ],
            ),
            // Tapping the price edits it — an override for a catalog line, the
            // free line's own price otherwise. The backend re-prices; nothing
            // is multiplied here.
            InkWell(
              onTap: onEditPrice,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        'PU ${line.unitPriceHt} € HT · ${line.unit}',
                        style: const TextStyle(
                          color: ArtizenColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: ArtizenSpacing.xs),
                    const Icon(
                      Icons.edit_outlined,
                      size: 14,
                      color: ArtizenColors.textSecondary,
                    ),
                  ],
                ),
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

/// A small pill — "Libre" on a free line, "Prix perso" once a catalog line's
/// price is overridden. Tappable only when [onTap] is given (the free-line
/// badge reopens its editor).
class _LineBadge extends StatelessWidget {
  const _LineBadge({required this.label, required this.color, this.onTap});

  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final chip = DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
    if (onTap == null) return chip;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: chip,
    );
  }
}

/// A button (in the Catalogue step) that opens the free-line editor and adds
/// the result to the draft — a line typed from scratch, no catalog article.
class _AddFreeLineButton extends ConsumerWidget {
  const _AddFreeLineButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      icon: const Icon(Icons.playlist_add),
      label: const Text('Ligne libre'),
      onPressed: () async {
        final result = await showModalBottomSheet<FreeLineValues>(
          context: context,
          isScrollControlled: true,
          builder: (_) => const _FreeLineSheet(),
        );
        if (result == null) return;
        ref
            .read(quoteDraftProvider.notifier)
            .addArticle(
              DraftLine(
                id: newFreeLineId(),
                designation: result.designation,
                unit: result.unit,
                quantity: result.quantity,
                unitPriceHt: result.unitPriceHt,
                vatRate: result.vatRate,
              ),
            );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ligne libre « ${result.designation} » ajoutée.'),
            ),
          );
        }
      },
    );
  }
}

/// The values a free line carries — returned by [_FreeLineSheet] to its caller.
class FreeLineValues {
  const FreeLineValues({
    required this.designation,
    required this.unit,
    required this.quantity,
    required this.unitPriceHt,
    required this.vatRate,
  });

  final String designation;
  final String unit;
  final num quantity;
  final String unitPriceHt;
  final String vatRate;
}

/// The form for a free line — création or édition. Decimals are validated and
/// normalized (comma → dot) on the way out, so a French keyboard never earns a
/// 422 on submit. No amount is computed here: the backend prices the line.
class _FreeLineSheet extends StatefulWidget {
  const _FreeLineSheet({this.initial});

  final DraftLine? initial;

  @override
  State<_FreeLineSheet> createState() => _FreeLineSheetState();
}

class _FreeLineSheetState extends State<_FreeLineSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _designation;
  late final TextEditingController _unit;
  late final TextEditingController _quantity;
  late final TextEditingController _price;
  late final TextEditingController _vat;

  @override
  void initState() {
    super.initState();
    final i = widget.initial;
    _designation = TextEditingController(text: i?.designation ?? '');
    _unit = TextEditingController(text: i?.unit ?? 'u');
    _quantity = TextEditingController(
      text: i == null
          ? '1'
          : (i.quantity % 1 == 0
                ? i.quantity.toInt().toString()
                : i.quantity.toString()),
    );
    _price = TextEditingController(text: i?.unitPriceHt ?? '');
    _vat = TextEditingController(text: i?.vatRate ?? '20');
  }

  @override
  void dispose() {
    _designation.dispose();
    _unit.dispose();
    _quantity.dispose();
    _price.dispose();
    _vat.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      FreeLineValues(
        designation: _designation.text.trim(),
        unit: _unit.text.trim(),
        quantity: num.parse(DecimalInput.normalize(_quantity.text)),
        unitPriceHt: DecimalInput.normalize(_price.text),
        vatRate: DecimalInput.normalize(_vat.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: ArtizenSpacing.md,
          right: ArtizenSpacing.md,
          top: ArtizenSpacing.md,
          bottom: MediaQuery.of(context).viewInsets.bottom + ArtizenSpacing.md,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.initial == null
                    ? 'Nouvelle ligne libre'
                    : 'Modifier la ligne libre',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: ArtizenSpacing.xs),
              const Text(
                'Un article hors catalogue (péage, location, prestation '
                'exceptionnelle). Le total est calculé par le serveur.',
                style: TextStyle(
                  color: ArtizenColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: ArtizenSpacing.sm),
              TextFormField(
                controller: _designation,
                decoration: const InputDecoration(labelText: 'Désignation'),
                textCapitalization: TextCapitalization.sentences,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Requis' : null,
              ),
              const SizedBox(height: ArtizenSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _unit,
                      decoration: const InputDecoration(labelText: 'Unité'),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Requis' : null,
                    ),
                  ),
                  const SizedBox(width: ArtizenSpacing.sm),
                  Expanded(
                    child: TextFormField(
                      controller: _quantity,
                      decoration: const InputDecoration(labelText: 'Quantité'),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (v) =>
                          DecimalInput.validate(v, exclusiveMin: true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ArtizenSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _price,
                      decoration: const InputDecoration(
                        labelText: 'Prix HT (€)',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (v) =>
                          DecimalInput.validate(v, exclusiveMin: true),
                    ),
                  ),
                  const SizedBox(width: ArtizenSpacing.sm),
                  Expanded(
                    child: TextFormField(
                      controller: _vat,
                      decoration: const InputDecoration(labelText: 'TVA (%)'),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (v) => DecimalInput.validate(v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ArtizenSpacing.md),
              FilledButton(
                onPressed: _submit,
                child: Text(
                  widget.initial == null ? 'Ajouter la ligne' : 'Enregistrer',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A one-field dialog to override a line's unit price (décision 5).
class _PriceEditDialog extends StatefulWidget {
  const _PriceEditDialog({required this.initial});

  final String initial;

  @override
  State<_PriceEditDialog> createState() => _PriceEditDialogState();
}

class _PriceEditDialogState extends State<_PriceEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _price = TextEditingController(
    text: widget.initial,
  );

  @override
  void dispose() {
    _price.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(DecimalInput.normalize(_price.text));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Prix personnalisé'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _price,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Prix HT (€)'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (v) => DecimalInput.validate(v, exclusiveMin: true),
          onFieldSubmitted: (_) => _submit(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Appliquer')),
      ],
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
    final hasDiscount = calc != null && calc.discountAmount != '0.00';
    final hasDeposit = calc != null && calc.depositAmount != '0.00';
    return Card(
      color: ArtizenColors.infoSurface,
      child: Padding(
        padding: const EdgeInsets.all(ArtizenSpacing.md),
        child: Column(
          children: [
            // With a discount, show the subtotal, the remise and the net HT;
            // without one, a single "Total HT" line — the figures are the
            // backend's (décision 3), never multiplied here.
            if (!hasDiscount)
              _RecapRow('Total HT', calc == null ? '—' : '${calc.totalHt} €')
            else ...[
              _RecapRow('Sous-total HT', '${calc.totalHt} €'),
              _RecapRow('Remise', '− ${calc.discountAmount} €'),
              _RecapRow('Total HT net', '${calc.netTotalHt} €'),
            ],
            _RecapRow('TVA', calc == null ? '—' : '${calc.netTotalVat} €'),
            const Divider(),
            _RecapRow(
              'Total TTC',
              calc == null ? '—' : '${calc.netTotalTtc} €',
              strong: true,
            ),
            if (hasDeposit) ...[
              const SizedBox(height: ArtizenSpacing.xs),
              _RecapRow('Acompte à verser', '${calc.depositAmount} €'),
              _RecapRow(
                'Solde à la livraison',
                '${calc.balanceDue} €',
                strong: true,
              ),
            ],
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
    final hasDiscount = calc != null && calc.discountAmount != '0.00';
    final hasDeposit = calc != null && calc.depositAmount != '0.00';
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
                if (hasDiscount) ...[
                  _CheckItem('Sous-total HT', '${calc.totalHt} €'),
                  _CheckItem('Remise', '− ${calc.discountAmount} €'),
                  _CheckItem('Total HT net', '${calc.netTotalHt} €'),
                ] else
                  _CheckItem(
                    'Total HT',
                    calc == null ? '…' : '${calc.netTotalHt} €',
                  ),
                _CheckItem('TVA', calc == null ? '…' : '${calc.netTotalVat} €'),
                const Divider(),
                _CheckItem(
                  'Total TTC',
                  calc == null ? '…' : '${calc.netTotalTtc} €',
                  strong: true,
                ),
                if (hasDeposit) ...[
                  _CheckItem('Acompte à verser', '${calc.depositAmount} €'),
                  _CheckItem(
                    'Solde à la livraison',
                    '${calc.balanceDue} €',
                    strong: true,
                  ),
                ],
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

/// Lets the artisan set a quote-level discount and deposit (décision 5). Both
/// are optional; the value field is enabled only once a type (% or €) is
/// picked. Every euro is computed by the backend on the next recalculation —
/// this only collects the parameters.
class _AdjustmentsCard extends ConsumerStatefulWidget {
  const _AdjustmentsCard();

  @override
  ConsumerState<_AdjustmentsCard> createState() => _AdjustmentsCardState();
}

class _AdjustmentsCardState extends ConsumerState<_AdjustmentsCard> {
  late final TextEditingController _discount;
  late final TextEditingController _deposit;

  @override
  void initState() {
    super.initState();
    final draft = ref.read(quoteDraftProvider);
    _discount = TextEditingController(text: draft.discountValue ?? '');
    _deposit = TextEditingController(text: draft.depositValue ?? '');
  }

  @override
  void dispose() {
    _discount.dispose();
    _deposit.dispose();
    super.dispose();
  }

  String _value(String raw) => DecimalInput.normalize(raw.isEmpty ? '0' : raw);

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(quoteDraftProvider.notifier);
    final discountType = ref.watch(
      quoteDraftProvider.select((d) => d.discountType),
    );
    final depositType = ref.watch(
      quoteDraftProvider.select((d) => d.depositType),
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(ArtizenSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Remise et acompte',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: ArtizenSpacing.xs),
            _AdjustmentRow(
              label: 'Remise',
              noneLabel: 'Aucune',
              type: discountType,
              controller: _discount,
              onTypeChanged: (type) {
                if (type == null) {
                  notifier.clearDiscount();
                } else {
                  notifier.setDiscount(type, _value(_discount.text));
                }
              },
              onValueChanged: (raw) {
                final type = ref.read(quoteDraftProvider).discountType;
                if (type != null) notifier.setDiscount(type, _value(raw));
              },
            ),
            const SizedBox(height: ArtizenSpacing.xs),
            _AdjustmentRow(
              label: 'Acompte',
              noneLabel: 'Aucun',
              type: depositType,
              controller: _deposit,
              onTypeChanged: (type) {
                if (type == null) {
                  notifier.clearDeposit();
                } else {
                  notifier.setDeposit(type, _value(_deposit.text));
                }
              },
              onValueChanged: (raw) {
                final type = ref.read(quoteDraftProvider).depositType;
                if (type != null) notifier.setDeposit(type, _value(raw));
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// One "type + value" line of [_AdjustmentsCard]. The value field is disabled
/// (and shows a dash) until a percentage or euro type is chosen.
class _AdjustmentRow extends StatelessWidget {
  const _AdjustmentRow({
    required this.label,
    required this.noneLabel,
    required this.type,
    required this.controller,
    required this.onTypeChanged,
    required this.onValueChanged,
  });

  final String label;
  final String noneLabel;
  final String? type;
  final TextEditingController controller;
  final ValueChanged<String?> onTypeChanged;
  final ValueChanged<String> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 72, child: Text(label)),
        DropdownButton<String?>(
          value: type,
          onChanged: onTypeChanged,
          items: [
            DropdownMenuItem(value: null, child: Text(noneLabel)),
            const DropdownMenuItem(value: 'percent', child: Text('%')),
            const DropdownMenuItem(value: 'amount', child: Text('€')),
          ],
        ),
        const SizedBox(width: ArtizenSpacing.sm),
        Expanded(
          child: TextField(
            controller: controller,
            enabled: type != null,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              isDense: true,
              hintText: type == 'percent'
                  ? '0 – 100'
                  : (type == 'amount' ? 'Montant €' : '—'),
            ),
            onChanged: onValueChanged,
          ),
        ),
      ],
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
            lines: [for (final line in draft.lines) line.toInput()],
            discountType: draft.discountType,
            discountValue: draft.discountValue,
            depositType: draft.depositType,
            depositValue: draft.depositValue,
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
                  calc == null ? '…' : '${calc.netTotalTtc} €',
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
                  '${quote.netTotalTtc} € TTC',
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
