import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/error_state.dart';
import '../../../shared/widgets/debounced_search_field.dart';
import '../../catalog/data/catalog_models.dart';
import '../../clients/data/client_model.dart';
import '../../clients/presentation/clients_providers.dart';
import '../data/quote_draft.dart';
import 'quote_draft_provider.dart';
import 'wizard_step.dart';

/// Renders the body of a step. Shell version: mock content only, so we can
/// validate the flow before wiring each step to its API. Every step keeps a
/// single objective — the question at the top is the one decision to make.
class WizardStepView extends StatelessWidget {
  const WizardStepView({required this.step, super.key});

  final WizardStep step;

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      step: step,
      // Client, Dossier and Articles are wired to the real API; the rest is mock.
      mock: step != WizardStep.client &&
          step != WizardStep.dossier &&
          step != WizardStep.articles,
      child: switch (step) {
        WizardStep.client => const _ClientStep(),
        WizardStep.dossier => const _DossierStep(),
        WizardStep.articles => const _ArticlesStep(),
        WizardStep.personnaliser => const _PersonnaliserStep(),
        WizardStep.recap => const _RecapStep(),
        WizardStep.creer => const _CreerStep(),
        WizardStep.envoyer => const _EnvoyerStep(),
      },
    );
  }
}

class _StepScaffold extends StatelessWidget {
  const _StepScaffold({required this.step, required this.child, this.mock = true});

  final WizardStep step;
  final Widget child;
  final bool mock;

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
            if (mock) const _MockBadge(),
            const SizedBox(height: ArtizenSpacing.md),
            child,
          ],
        ),
      ),
    );
  }
}

class _MockBadge extends StatelessWidget {
  const _MockBadge();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: ArtizenSpacing.xs),
      child: Row(
        children: [
          const Icon(Icons.science_outlined, size: 14, color: ArtizenColors.textSecondary),
          const SizedBox(width: 6),
          Text(
            'Aperçu — données simulées',
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: ArtizenColors.textSecondary),
          ),
        ],
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
      ref.read(quoteDraftProvider.notifier).selectClient(
            id: created.id,
            label: created.displayName,
          );
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
                          leading: const CircleAvatar(child: Icon(Icons.person_outline)),
                          title: Text(client.displayName),
                          subtitle: client.email == null ? null : Text(client.email!),
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
                          // a double tap can't hurt.
                          onTap: () => ref.read(quoteDraftProvider.notifier).selectClient(
                                id: client.id,
                                label: client.displayName,
                              ),
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
          const Icon(Icons.person_search_outlined, color: ArtizenColors.textSecondary),
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
                    // The one thing this step does: open a folder. Opening the
                    // same one again is a harmless no-op — a double tap can't hurt.
                    onTap: () => ref.read(selectedFolderProvider.notifier).open(folder.id),
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
  const _FolderCard({required this.folder, required this.open, required this.onTap});

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
        title: Text(folder.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$count article${count > 1 ? 's' : ''}'),
            if (hasPreview)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'Aperçu : ${folder.sampleDesignations.join(', ')}…',
                  style: const TextStyle(color: ArtizenColors.textSecondary, fontSize: 12),
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
              Icon(Icons.folder_off_outlined, color: ArtizenColors.textSecondary),
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
  void _add(CatalogItem item) {
    ref.read(quoteDraftProvider.notifier).addArticle(
          DraftLine(
            catalogItemId: item.id,
            designation: item.designation,
            unit: item.unit,
            quantity: 1,
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
        (draft) => {for (final line in draft.lines) line.catalogItemId: line.quantity},
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
                        item: item,
                        quantity: quantityByItem[item.id],
                        onAdd: () => _add(item),
                        onRemoveOne: () => ref
                            .read(quoteDraftProvider.notifier)
                            .setQuantity(item.id, (quantityByItem[item.id] ?? 1) - 1),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}

/// One catalog article, and the one action this step is about: add it to the
/// quote. Added lines show a clear "✔ Ajouté" with their quantity, and quick
/// +/− controls — so the artisan always knows what is already on the devis.
/// The price shown is the catalog's (a snapshot); no total is computed here.
class _ArticleRow extends StatelessWidget {
  const _ArticleRow({
    required this.item,
    required this.quantity,
    required this.onAdd,
    required this.onRemoveOne,
  });

  final CatalogItem item;

  /// Its quantity on the draft, or null if not added yet.
  final num? quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemoveOne;

  @override
  Widget build(BuildContext context) {
    final added = quantity != null;
    return Card(
      color: added ? ArtizenColors.infoSurface : null,
      child: ListTile(
        title: Text(item.designation, style: const TextStyle(fontWeight: FontWeight.w600)),
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
        isThreeLine: added,
        trailing: added
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    tooltip: 'Retirer une unité',
                    onPressed: onRemoveOne,
                  ),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.add),
                    tooltip: 'Ajouter une unité',
                    onPressed: onAdd,
                  ),
                ],
              )
            : FilledButton.tonalIcon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: const Text('Ajouter'),
              ),
      ),
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
          const Icon(Icons.search_off_outlined, color: ArtizenColors.textSecondary),
          const SizedBox(width: ArtizenSpacing.sm),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}

// --- Étape 4 : Personnaliser — quantités, prix, lignes libres --------------

class _PersonnaliserStep extends StatelessWidget {
  const _PersonnaliserStep();

  @override
  Widget build(BuildContext context) {
    const lines = <(String, int, String)>[
      ('Chauffe-eau électrique 200 L', 1, '380,00 €'),
      ('Groupe de sécurité', 1, '14,00 €'),
      ('Pose d\'un chauffe-eau', 1, '280,00 €'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (name, qty, total) in lines)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(ArtizenSpacing.sm),
              child: Row(
                children: [
                  Expanded(child: Text(name)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.remove_circle_outline)),
                  Text('$qty'),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
                  const SizedBox(width: ArtizenSpacing.sm),
                  Text(total, style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        const SizedBox(height: ArtizenSpacing.xs),
        Wrap(
          spacing: ArtizenSpacing.xs,
          children: [
            OutlinedButton.icon(
                onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Ligne libre')),
            OutlinedButton.icon(
                onPressed: () {}, icon: const Icon(Icons.percent), label: const Text('Remise')),
          ],
        ),
      ],
    );
  }
}

// --- Étape 5 : Récapitulatif — vérifier les montants -----------------------

class _RecapStep extends StatelessWidget {
  const _RecapStep();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(ArtizenSpacing.md),
        child: Column(
          children: const [
            _RecapRow('Client', 'Martin Dubois'),
            _RecapRow('Lignes', '3 articles'),
            Divider(),
            _RecapRow('Total HT', '674,00 €'),
            _RecapRow('TVA (10 %)', '67,40 €'),
            Divider(),
            _RecapRow('Total TTC', '741,40 €', strong: true),
          ],
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
        ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: ArtizenColors.nightBlue)
        : const TextStyle();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }
}

// --- Étape 6 : Créer — le devis officiel -----------------------------------

class _CreerStep extends StatelessWidget {
  const _CreerStep();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Card(
          child: ListTile(
            leading: Icon(Icons.description_outlined, size: 40),
            title: Text('Devis prêt à être créé'),
            subtitle: Text('Un numéro officiel (DEV-2026-XXXX) lui sera attribué.'),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.md),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.check_circle_outline),
          label: const Text('Créer le devis'),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            backgroundColor: ArtizenColors.gold,
            foregroundColor: ArtizenColors.onGold,
          ),
        ),
      ],
    );
  }
}

// --- Étape 7 : Envoyer — au client -----------------------------------------

class _EnvoyerStep extends StatelessWidget {
  const _EnvoyerStep();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Card(
          child: ListTile(
            leading: Icon(Icons.picture_as_pdf_outlined),
            title: Text('DEV-2026-0042.pdf'),
            subtitle: Text('Devis joint automatiquement'),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.sm),
        TextFormField(
          initialValue: 'martin.dubois@email.fr',
          decoration: const InputDecoration(
            labelText: 'À',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.sm),
        const TextField(
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Message',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: ArtizenSpacing.md),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send),
          label: const Text('Envoyer au client'),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
        ),
      ],
    );
  }
}
