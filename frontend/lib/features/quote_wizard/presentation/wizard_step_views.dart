import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/error_state.dart';
import '../../../shared/widgets/debounced_search_field.dart';
import '../../clients/data/client_model.dart';
import '../../clients/presentation/clients_providers.dart';
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
      // Client and Dossier are wired to the real API; the rest is still mock.
      mock: step != WizardStep.client && step != WizardStep.dossier,
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

class _DossierStep extends ConsumerWidget {
  const _DossierStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          ? const Padding(
              padding: EdgeInsets.all(ArtizenSpacing.md),
              child: Text(
                'Votre catalogue est vide. Activez un métier dans « Mes métiers » '
                'pour le remplir.',
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final folder in list)
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.folder_outlined, color: ArtizenColors.nightBlue),
                      title: Text(folder.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${folder.itemCount} article${folder.itemCount > 1 ? 's' : ''}'),
                          if (folder.sampleDesignations.isNotEmpty)
                            Text(
                              '💬 ${folder.sampleDesignations.join(' • ')}…',
                              style: const TextStyle(
                                  color: ArtizenColors.textSecondary, fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                      isThreeLine: folder.sampleDesignations.isNotEmpty,
                      trailing: folder.id == openId
                          ? const Icon(Icons.check_circle, color: ArtizenColors.success)
                          : null,
                      selected: folder.id == openId,
                      // The one thing this step does: open a folder.
                      onTap: () => ref.read(selectedFolderProvider.notifier).open(folder.id),
                    ),
                  ),
              ],
            ),
    );
  }
}

// --- Étape 3 : Articles — quoi ? -------------------------------------------

class _ArticlesStep extends StatelessWidget {
  const _ArticlesStep();

  @override
  Widget build(BuildContext context) {
    const articles = <(String, String, bool)>[
      ('Chauffe-eau électrique 200 L', '380,00 € HT', true),
      ('Groupe de sécurité', '14,00 € HT', true),
      ('Vase d\'expansion 8 L', '38,00 € HT', false),
      ('Pose d\'un chauffe-eau', '280,00 € HT', true),
      ('Déplacement zone 1', '35,00 € HT', false),
    ];
    return Column(
      children: [
        for (final (name, price, checked) in articles)
          Card(
            child: CheckboxListTile(
              value: checked,
              onChanged: (_) {},
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(name),
              subtitle: Text(price),
            ),
          ),
        const SizedBox(height: ArtizenSpacing.xs),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Ajouter un article'),
        ),
      ],
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
