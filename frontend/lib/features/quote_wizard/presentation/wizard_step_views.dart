import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/debouncer.dart';
import '../../../core/widgets/error_state.dart';
import '../../../shared/widgets/debounced_search_field.dart';
import '../../branding/presentation/branding_providers.dart';
import '../../catalog/data/catalog_models.dart';
import '../../clients/data/client_model.dart';
import '../../clients/presentation/clients_providers.dart';
import '../../quotes/data/quote_calculation.dart';
import '../../quotes/data/quote_models.dart';
import '../../quotes/presentation/quotes_providers.dart';
import '../data/quote_draft.dart';
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
    return _StepScaffold(
      step: step,
      child: switch (step) {
        WizardStep.client => const _ClientStep(),
        WizardStep.dossier => const _DossierStep(),
        WizardStep.articles => const _ArticlesStep(),
        WizardStep.personnaliser => const _PersonnaliserStep(),
        WizardStep.recap => const _RecapStep(),
        WizardStep.creer => const _CreerStep(),
        WizardStep.confirmation => const _ConfirmationStep(),
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

// --- Étape 2 : Dossier — quel dossier du catalogue ? (câblé) ---------------

class _DossierStep extends ConsumerStatefulWidget {
  const _DossierStep();

  @override
  ConsumerState<_DossierStep> createState() => _DossierStepState();
}

class _DossierStepState extends ConsumerState<_DossierStep> {
  Future<void> _activateMetier() async {
    // The catalog is empty — send the artisan to "Mes métiers", then refresh
    // the folder list so a métier activated there shows up on return.
    await context.push('/metiers');
    if (!mounted) return;
    ref.invalidate(foldersProvider);
  }

  @override
  Widget build(BuildContext context) {
    final folders = ref.watch(foldersProvider);
    final openId = ref.watch(selectedFolderProvider);

    return folders.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(ArtizenSpacing.lg),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => ErrorState(
        error: error,
        onRetry: () => ref.invalidate(foldersProvider),
      ),
      data: (list) => list.isEmpty
          ? _EmptyCatalog(onActivate: _activateMetier)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final folder in list)
                  _FolderCard(
                    folder: folder,
                    open: folder.id == openId,
                    // The one thing this step does: open a folder — which also
                    // asks the wizard to move on to the Articles step, so a tap
                    // is enough (no second click on Suivant). Opening the same
                    // one again is a harmless no-op that still advances.
                    onTap: () {
                      ref.read(selectedFolderProvider.notifier).open(folder.id);
                      ref.read(wizardAdvanceRequestProvider.notifier).state++;
                    },
                  ),
              ],
            ),
    );
  }
}

/// One catalog folder, made scannable: its name, how many articles it holds,
/// and a representative preview of what is inside — so the artisan knows at a
/// glance what he'll find before opening it. Everything shown comes straight
/// from `GET /catalog/categories/overview`; nothing is inferred client-side.
class _FolderCard extends StatelessWidget {
  const _FolderCard({
    required this.folder,
    required this.open,
    required this.onTap,
  });

  final CategoryOverview folder;
  final bool open;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final count = folder.itemCount;
    final hasPreview = folder.sampleDesignations.isNotEmpty;
    return Card(
      color: open ? ArtizenColors.infoSurface : null,
      child: ListTile(
        leading: Icon(
          Icons.folder_outlined,
          color: open ? ArtizenColors.success : ArtizenColors.nightBlue,
        ),
        title: Text(
          folder.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$count article${count > 1 ? 's' : ''}'),
            if (hasPreview)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'Aperçu : ${folder.sampleDesignations.join(', ')}…',
                  style: const TextStyle(
                    color: ArtizenColors.textSecondary,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (open)
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'Dossier ouvert',
                  style: TextStyle(
                    color: ArtizenColors.success,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        isThreeLine: hasPreview,
        trailing: open
            ? const Icon(
                Icons.check_circle,
                color: ArtizenColors.success,
                semanticLabel: 'Dossier ouvert',
              )
            : null,
        selected: open,
        onTap: onTap,
      ),
    );
  }
}

/// An actionable empty state: a catalog with no folder is a dead end unless it
/// points the artisan at where folders come from — activating a métier.
class _EmptyCatalog extends StatelessWidget {
  const _EmptyCatalog({required this.onActivate});

  final VoidCallback onActivate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(ArtizenSpacing.md),
          child: Row(
            children: [
              Icon(
                Icons.folder_off_outlined,
                color: ArtizenColors.textSecondary,
              ),
              SizedBox(width: ArtizenSpacing.sm),
              Expanded(
                child: Text(
                  "Votre catalogue est vide. Activez un métier pour le remplir "
                  "de dossiers et d'articles.",
                ),
              ),
            ],
          ),
        ),
        OutlinedButton.icon(
          onPressed: onActivate,
          icon: const Icon(Icons.build_outlined),
          label: const Text('Activer un métier'),
        ),
      ],
    );
  }
}

// --- Étape 3 : Articles — quoi ? -------------------------------------------

class _ArticlesStep extends ConsumerStatefulWidget {
  const _ArticlesStep();

  @override
  ConsumerState<_ArticlesStep> createState() => _ArticlesStepState();
}

class _ArticlesStepState extends ConsumerState<_ArticlesStep> {
  /// Mirrors the search field so the empty state tells "empty folder" from
  /// "nothing matches this search".
  String _query = '';

  /// Snapshot the catalog article onto the draft line (décision 5): its
  /// designation, unit and price travel with the line. No amount is computed
  /// here — totals come from the backend at the Récap step.
  void _add(CatalogItem item, num quantity) {
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

  @override
  Widget build(BuildContext context) {
    final openFolder = ref.watch(selectedFolderProvider);
    if (openFolder == null) {
      // Reaching this step means a folder is open (gating), but stay safe.
      return const Padding(
        padding: EdgeInsets.all(ArtizenSpacing.md),
        child: Text('Ouvrez d\'abord un dossier à l\'étape précédente.'),
      );
    }

    final results = ref.watch(articlePickerProvider);
    final quantityByItem = ref.watch(
      quoteDraftProvider.select(
        (draft) => {
          for (final line in draft.lines) line.catalogItemId: line.quantity,
        },
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DebouncedSearchField(
          hintText: 'Rechercher un article dans ce dossier',
          isLoading: results.isLoading,
          onChanged: (query) {
            setState(() => _query = query.trim());
            ref.read(articlePickerProvider.notifier).search(query);
          },
        ),
        const SizedBox(height: ArtizenSpacing.sm),
        results.when(
          skipLoadingOnReload: true,
          skipLoadingOnRefresh: true,
          loading: () => const Padding(
            padding: EdgeInsets.all(ArtizenSpacing.lg),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => ErrorState(
            error: error,
            onRetry: () => ref.invalidate(articlePickerProvider),
          ),
          data: (items) => items.isEmpty
              ? _EmptyArticles(query: _query)
              : Column(
                  children: [
                    for (final item in items)
                      _ArticleRow(
                        key: ValueKey(item.id),
                        item: item,
                        quantity: quantityByItem[item.id],
                        onAdd: (qty) => _add(item, qty),
                        onRemoveOne: () => ref
                            .read(quoteDraftProvider.notifier)
                            .setQuantity(
                              item.id,
                              (quantityByItem[item.id] ?? 1) - 1,
                            ),
                      ),
                  ],
                ),
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

/// Tells an empty folder apart from a search that matched nothing.
class _EmptyArticles extends StatelessWidget {
  const _EmptyArticles({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final message = query.isEmpty
        ? 'Ce dossier ne contient aucun article.'
        : 'Aucun article ne correspond à « $query » dans ce dossier.';
    return Padding(
      padding: const EdgeInsets.all(ArtizenSpacing.md),
      child: Row(
        children: [
          const Icon(
            Icons.search_off_outlined,
            color: ArtizenColors.textSecondary,
          ),
          const SizedBox(width: ArtizenSpacing.sm),
          Expanded(child: Text(message)),
        ],
      ),
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
    if (draft.lines.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(ArtizenSpacing.md),
        child: Text(
          "Ajoutez des articles à l'étape précédente pour les personnaliser.",
        ),
      );
    }

    final totalByItem = {
      for (final line
          in draft.calculation?.lines ?? const <QuoteCalculationLine>[])
        line.catalogItemId: line.totalHt,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final line in draft.lines)
          _EditableLine(
            line: line,
            // The line total is the backend's, matched by article — null (shown
            // as "—") until the first calculation lands.
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
        _TotalsCard(
          calculation: draft.calculation,
          recalculating: _recalculating,
        ),
      ],
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
                    color: ArtizenColors.onGold,
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
            backgroundColor: ArtizenColors.gold,
            foregroundColor: ArtizenColors.onGold,
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
